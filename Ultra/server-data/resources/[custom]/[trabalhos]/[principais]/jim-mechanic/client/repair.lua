local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Repair
local stashName = " "
--Stash Controls
Citizen.CreateThread(function()
	if Config.StashRepair and not Config.FreeRepair then
		for k, v in pairs(Config.SafeLocations) do
			exports['s_target']:AddBoxZone("MechSafe"..k, v.coords, v.w, v.d, { name="MechSafe"..k, heading = v.heading, debugPoly=false, minZ=v.coords.z-1.0, maxZ=v.coords.z+1.0 }, 
				{ options = { { event = "jim-mechanic:client:Safe", icon = "fas fa-cogs", label = "Cofre", job = v.job }, },
				  distance = 2.0
			})
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Safe', function(data) 
	TriggerEvent("inventory:client:SetCurrentStash", data.job .. "Cofre")
	TriggerServerEvent("inventory:server:OpenInventory", "stash", data.job .. "Cofre", { maxweight = 4000000, slots = 50, })
end)

Config.SafeLocations = {
    --Add your poly zone box locations and job name for each safe and it will add it to the s_target loop above
    { coords = vector3(-1255.39, 1603.57, 23.04), w = 4.4, d = 1.0, heading = 0, job = "libertywalk" },
	{ coords = vector3(-1035.19, 604.15, 2.3), w = 1.0, d = 2.8, heading = 0, job = "strtunners" },
   -- { coords = vector3(146.44, -3014.29, 6.97), heading = 0, job = "mechanic" },
}


RegisterNetEvent('jim-mechanic:client:Repair:ItemCheck', function(data)
	if not Config.FreeRepair then
		if Config.StashRepair then 
			TriggerEvent('jim-mechanic:client:Repair:Sure', data)
		else
			QBCore.Functions.TriggerCallback("jim-mechanic:repairCost", function(amount) 
				if amount then TriggerEvent('jim-mechanic:client:Repair:Sure', data)
				else 
				TriggerEvent("QBCore:Notify", "Não tens materiais suficientes", "error")
				TriggerEvent('jim-mechanic:client:Repair:Check', -1)
				end
			end, data)
		end
	elseif Config.FreeRepair then
		TriggerEvent('jim-mechanic:client:Repair:Sure', data)
	end
end)


RegisterNetEvent('jim-mechanic:client:Repair:Apply', function(data)
	if Config.RequiresJob == true then havejob = false
		for k, v in pairs(Config.JobRoles) do
			if v == PlayerJob.name then	havejob = true end
		end
		if havejob == false then TriggerEvent('QBCore:Notify', "Apenas os mecânicos sabem fazer isto", "error") return end
	end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if data == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		for i = 0, 5 do	SetVehicleDoorShut(vehicle, i, false, true) end -- will open every door from 0-5
	else
		if data.part == "Engine" then
			SetVehicleDoorOpen(vehicle, 4, false, true)
			setanimDict = "mini@repair"
			setanim = "fixing_a_ped"
			setflags = 16
			settask = nil
		elseif data.part == "Body" then
			SetVehicleDoorOpen(vehicle, 4, false, true)
			setanimDict = nil
			setanim = nil
			setflags = nil
			settask = "WORLD_HUMAN_WELDING"
		elseif data.part == "Radiator" then
			SetVehicleDoorOpen(vehicle, 4, false, true)
			setanimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
			setanim = "machinic_loop_mechandplayer"
			setflags = 8
			settask = nil
		elseif data.part == "Drive Shaft" then
			setanimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
			setanim = "machinic_loop_mechandplayer"
			setflags = 8
			settask = nil
		elseif data.part == "Brakes" then
			setanimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
			setanim = "machinic_loop_mechandplayer"
			setflags = 8
			settask = nil
		elseif data.part == "Clutch" then
			setanimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
			setanim = "machinic_loop_mechandplayer"
			setflags = 8
			settask = nil
		elseif data.part == "Fuel Tank" then
			setanimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
			setanim = "machinic_loop_mechandplayer"
			setflags = 8
			settask = nil
		end
	
		time = math.random(8000,10000)
		
		if Config.StashRepair and not Config.FreeRepair then
		
			stashName = PlayerJob.name .. "Cofre"
	
			if data.part == "Engine" then part = Config.RepairEngine cost = data.cost end
			if data.part == "Body" then part = Config.RepairBody cost = data.cost end
			if data.part == "Radiator" then part = Config.RepairRadiator cost = data.cost end
			if data.part == "Drive Shaft" then part = Config.RepairAxle cost = data.cost end
			if data.part == "Brakes" then part = Config.RepairBrakes cost = data.cost end
			if data.part == "Clutch" then part = Config.RepairClutch cost = data.cost end
			if data.part == "Fuel Tank" then part = Config.RepairFuel cost = data.cost end
			
			local hasitem = false
			local indx = 0
			local countitem = 0
			
			QBCore.Functions.TriggerCallback('qb-inventory:server:GetStashItems', function(StashItems)
				for k,v in pairs(StashItems) do
					if v.name == part then
						hasitem = true
						if v.amount >= cost then
							countitem = v.amount
							indx = k
						end
					end
				end
				if hasitem and countitem >= cost then
					QBCore.Functions.Progressbar("repair_part", "Repairing " ..data.part, time, false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {
						task = settask,
						animDict = setanimDict,
						anim = setanim,
						flags = setflag,
					}, {}, {}, function() -- Done
						SetVehicleModKit(vehicle, 0)
						ClearPedTasks(playerPed)
				
						if data.part == "Body" then
							for i = 0, 5 do
							  SetVehicleDoorShut(vehicle, i, false, true) -- will open every door from 0-5
							  Wait(250)
							end
							enhealth = GetVehicleEngineHealth(vehicle)
							SetVehicleBodyHealth(vehicle, 1000.0)
							SetVehicleFixed(vehicle)				
							SetVehicleEngineHealth(vehicle, enhealth)
						elseif data.part == "Engine" then
							SetVehicleEngineHealth(vehicle, 1000.0)
						elseif data.part == "Radiator" then
							TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "radiator", 100)
						elseif data.part == "Drive Shaft" then
							TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "axle", 100)
						elseif data.part == "Brakes" then
							TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "brakes", 100)
						elseif data.part == "Clutch" then
							TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "clutch", 100)
						elseif data.part == "Fuel Tank" then
							TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "fuel", 100)
						end
							
						if not Config.FreeRepair and not Config.StashRepair then TriggerServerEvent('jim-mechanic:ItemRemove', data) end
						
						FreezeEntityPosition(playerPed, false)
						CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
						TriggerServerEvent('updateVehicle', CurrentVehicleData)
						TriggerEvent("jim-mechanic:client:Repair:Check", -1)
						TriggerEvent("QBCore:Notify", "Successo! "..data.part.." reparado totalmente", "success")
					
						
						if (countitem - cost) <= 0 then
							StashItems[indx] = nil
						else
							countitem = (countitem - cost)
							StashItems[indx].amount = countitem
						end
						
						TriggerServerEvent('qb-inventory:server:SaveStashItems', stashName, StashItems)

					end, function()
						TriggerEvent('QBCore:Notify', data.part.." Reparação cancelada!", "error")
						ClearPedTasks(playerPed)
						FreezeEntityPosition(playerPed, false)	
					end)
				else
					TriggerEvent('QBCore:Notify', 'Não existe materiais suficientes no cofre', 'error')
					return
				end
			end, stashName)
			
		else
			QBCore.Functions.Progressbar("drink_something", "A reparar "..data.part, time, false, true, { 
				disableMovement = true, 
				disableCarMovement = true, 
				disableMouse = false, 
				disableCombat = true, 
			}, {
				task = settask,
				animDict = setanimDict,
				anim = setanim,
				flags = setflag,
			}, {}, {}, function()
				SetVehicleModKit(vehicle, 0)
				ClearPedTasks(playerPed)
			
				if data.part == "Body" then
					for i = 0, 5 do
					  SetVehicleDoorShut(vehicle, i, false, true) -- will open every door from 0-5
					  Wait(250)
					end
					enhealth = GetVehicleEngineHealth(vehicle)
					SetVehicleBodyHealth(vehicle, 1000.0)
					SetVehicleFixed(vehicle)				
					SetVehicleEngineHealth(vehicle, enhealth)
				elseif data.part == "Engine" then
					SetVehicleEngineHealth(vehicle, 1000.0)
				elseif data.part == "Radiator" then
					TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "radiator", 100)
				elseif data.part == "Drive Shaft" then
					TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "axle", 100)
				elseif data.part == "Brakes" then
					TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "brakes", 100)
				elseif data.part == "Clutch" then
					TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "clutch", 100)
				elseif data.part == "Fuel Tank" then
					TriggerServerEvent("vehiclemod:server:updatePart", GetVehicleNumberPlateText(vehicle), "fuel", 100)
				end
					
				if not Config.FreeRepair and not Config.StashRepair then TriggerServerEvent('jim-mechanic:ItemRemove', data) end
				
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent("jim-mechanic:client:Repair:Check", -1)
				TriggerEvent("QBCore:Notify", "Successo! "..data.part.." reparado totalmente", "success")
			end, function() -- Cancel
				TriggerEvent('QBCore:Notify', data.part.." Reparação cancelada!", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Repair:Check', function(skip)
	modelName = nil
	if Config.LocationRequired and not onDuty then
		TriggerEvent("QBCore:Notify", "Não estás na oficina", "error")
	else
		if Config.RequiresJob == true then havejob = false
			for k, v in pairs(Config.JobRoles) do
				if v == PlayerJob.name then	havejob = true end
			end
			if havejob == false then TriggerEvent('QBCore:Notify', "Apenas os mecânicos sabem fazer isto", "error") return end
		end
		local playerPed	= PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)
		if IsPedSittingInAnyVehicle(playerPed) then
			TriggerEvent("QBCore:Notify", "Não podes reparar dentro do veículo", "error")
			ClearPedTasks(playerPed)
			return
		end
			if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 4.5) then
				local vehicle = nil
				if IsPedInAnyVehicle(playerPed, false) then
					vehicle = GetVehiclePedIsIn(playerPed, false)
				else
					vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 4.5, 0, 71)
					SetVehicleModKit(vehicle, 0)
					modelName = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
				
					--For debugging. If you car is throwing out the "?" error F8 menu enable this
					--add it to the config under Config.carNames with the correct model name and the loop below will correct it
					--TriggerEvent("QBCore:Notify", modelName, "error")
					
					for k, v in pairs(Config.carNames) do if modelName == v.name then modelName = v.newName end	end
				end
				QBCore.Functions.TriggerCallback('qb-vehicletuning:server:GetStatus', function(status)
					if status == nil then TriggerEvent("QBCore:Notify", "Falha ao recuperar informações do carro, tente usar as ferramentas novamente", "error") TriggerServerEvent('vehiclemod:server:setupVehicleStatus', GetVehicleNumberPlateText(vehicle), GetVehicleEngineHealth(vehicle), GetVehicleBodyHealth(vehicle)) return end
					
					local vehicleStatus = status
					costEngine = ""
					costBody = ""
					costRadiator = ""
					costAxle = ""
					costBrakes = ""
					costClutch = ""
					costFuel = ""

					if not Config.FreeRepair then
					
						--Calculate the costs of each part based on damage
						EngineRepair = Config.RepairEngineCost - math.floor(Config.RepairEngineCost * math.floor((GetVehicleEngineHealth(vehicle)/10)+0.5) / 100)
						BodyRepair = Config.RepairBodyCost - math.floor(Config.RepairBodyCost * math.floor((GetVehicleBodyHealth(vehicle)/10)+0.5) / 100)
						RadiatorRepair = Config.RepairRadiatorCost - math.floor(Config.RepairRadiatorCost * math.floor((vehicleStatus['radiator'])+0.5) / 100)
						AxleRepair = Config.RepairAxleCost - math.floor(Config.RepairAxleCost * math.floor((vehicleStatus['axle'])+0.5) / 100)
						BrakesRepair = Config.RepairBrakesCost - math.floor(Config.RepairBrakesCost * math.floor((vehicleStatus['brakes'])+0.5) / 100)
						ClutchRepair = Config.RepairClutchCost - math.floor(Config.RepairClutchCost * math.floor((vehicleStatus['clutch'])+0.5) / 100)
						FuelRepair = Config.RepairFuelCost - math.floor(Config.RepairFuelCost * math.floor((vehicleStatus['fuel'])+0.5) / 100)
						
						--Create the info to be showed, if engine is full health, it leaves the message blank
						if EngineRepair ~= 0 then costEngine = "<br>Cost: "..EngineRepair.." "..QBCore.Shared.Items[Config.RepairEngine].label end
						if BodyRepair ~= 0 then costBody = "<br>Cost: "..BodyRepair.." "..QBCore.Shared.Items[Config.RepairBody].label end
						if RadiatorRepair ~= 0 then costRadiator = "<br>Cost: "..RadiatorRepair.." "..QBCore.Shared.Items[Config.RepairRadiator].label end
						if AxleRepair ~= 0 then costAxle = "<br>Cost: "..AxleRepair.." "..QBCore.Shared.Items[Config.RepairAxle].label end
						if BrakesRepair ~= 0 then costBrakes = "<br>Cost: "..BrakesRepair.." "..QBCore.Shared.Items[Config.RepairBrakes].label end
						if ClutchRepair ~= 0 then costClutch = "<br>Cost: "..ClutchRepair.." "..QBCore.Shared.Items[Config.RepairClutch].label end
						if FuelRepair ~= 0 then costFuel = "<br>Cost: "..FuelRepair.." "..QBCore.Shared.Items[Config.RepairFuel].label end
					end
					
						local RepairMenu = {
							{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[modelName].name.." "..QBCore.Shared.Vehicles[modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[modelName].price.."€ | Matrícula: ["..GetVehicleNumberPlateText(vehicle).."]" },
							{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Repair:Apply", args = -2 } },
							{ header = "Motor", txt = "Status: "..math.floor((GetVehicleEngineHealth(vehicle)/10)+0.5).."%"..costEngine, params = { event = "jim-mechanic:client:Repair:ItemCheck", args = { part = "Engine", vehicle = vehicle, cost = EngineRepair } } },
							{ header = "Carroceria", txt =  "Status: "..math.floor((GetVehicleBodyHealth(vehicle)/10)+0.5).."%"..costBody, params = { event = "jim-mechanic:client:Repair:ItemCheck", args = { part = "Body", vehicle = vehicle, cost = BodyRepair } } },
							{ header = "Radiador", txt =  "Status: "..math.floor((vehicleStatus['radiator'])+0.5).."%"..costRadiator, params = { event = "jim-mechanic:client:Repair:ItemCheck", args = { part = "Radiator", vehicle = vehicle, status = vehicleStatus, cost = RadiatorRepair } } },
							{ header = "Eixo Transmissão", txt =  "Status: "..math.floor((vehicleStatus['axle'])+0.5).."%"..costAxle, params = { event = "jim-mechanic:client:Repair:ItemCheck", args = { part = "Drive Shaft", vehicle = vehicle, status = vehicleStatus, cost = AxleRepair } } },
							{ header = "Travões", txt =  "Status: "..math.floor((vehicleStatus['brakes'])+0.5).."%"..costBrakes, params = { event = "jim-mechanic:client:Repair:ItemCheck", args = { part = "Brakes", vehicle = vehicle, status = vehicleStatus, cost = BrakesRepair } } },
							{ header = "Embreagem", txt =  "Status: "..math.floor((vehicleStatus['clutch'])+0.5).."%"..costClutch, params = { event = "jim-mechanic:client:Repair:ItemCheck", args = { part = "Clutch", vehicle = vehicle, status = vehicleStatus, cost = ClutchRepair } } },
							{ header = "Tanque Comb.", txt =  "Status: "..math.floor((vehicleStatus['fuel'])+0.5).."%"..costFuel, params = { event = "jim-mechanic:client:Repair:ItemCheck", args = { part = "Fuel Tank", vehicle = vehicle, status = vehicleStatus, cost = FuelRepair } } },
						}			
						if DoesEntityExist(vehicle) then
						local plate = GetVehicleNumberPlateText(vehicle)
						if skip == -1 then	
						TriggerEvent('animations:client:EmoteCommandStart', {"clipboard"})
						TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
						Wait(1000)
						exports['qb-menu']:openMenu(RepairMenu)
						else
							TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
							Wait(1000)
							SetVehicleDoorOpen(vehicle, 4, false, false)
							time = math.random(3000,5000)
							for i = 0, 5 do
							  SetVehicleDoorOpen(vehicle, i, false, false) -- will open every door from 0-5
							end

							QBCore.Functions.Progressbar("drink_something", "A verificar dano do motor..", time, false, true, { 
								disableMovement = true, 
								disableCarMovement = true, 
								disableMouse = false, 
								disableCombat = true, 
							}, {
								animDict = "mini@repair",
								anim = "fixing_a_ped",
								flags = 16,
							}, {}, {}, function()
							Wait(1000)
								time = math.random(3000,5000)
								QBCore.Functions.Progressbar("drink_something", "A verificar dano na carroceria..", time, false, true, { 
									disableMovement = true, 
									disableCarMovement = true, 
									disableMouse = false, 
									disableCombat = true, 
								}, {
								animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								anim = "machinic_loop_mechandplayer",
								flags = 8,
								}, {}, {}, function()
								
									Wait(1000)

									ClearPedTasks(playerPed)
									FreezeEntityPosition(playerPed, false)
									TriggerEvent('animations:client:EmoteCommandStart', {"clipboard"})
									
								exports['qb-menu']:openMenu(RepairMenu)
									
								end, function() -- Cancel
									ClearPedTasks(playerPed)
									FreezeEntityPosition(playerPed, false)	
								end)
								Wait(time+1000)
							end, function() -- Cancel
								ClearPedTasks(playerPed)
								FreezeEntityPosition(playerPed, false)
								return
							end)
							
						end

					end
				end, GetVehicleNumberPlateText(vehicle))
			else
				TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
			end
	end
end)

RegisterNetEvent('jim-mechanic:client:Repair:Sure', function(data)
	if Config.RequiresJob == true then havejob = false
		for k, v in pairs(Config.JobRoles) do
			if v == PlayerJob.name then	havejob = true end
		end
		if havejob == false then TriggerEvent('QBCore:Notify', "Apenas os mecânicos sabem fazer isto", "error") return end
	end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes reparar de dentro do carro", "error")
		ClearPedTasks(playerPed)
		return
	end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
			SetVehicleModKit(vehicle, 0)
			modelName = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
			for k, v in pairs(Config.carNames) do if modelName == v.name then modelName = v.newName end end
		end
		local vehicleStatus = data.status						
		if DoesEntityExist(vehicle) then
			local plate = GetVehicleNumberPlateText(vehicle)
			if data.part == "Engine" and math.floor((GetVehicleEngineHealth(vehicle)/10)+0.5) == 100 then 
				TriggerEvent("QBCore:Notify", "O motor está com a vida máxima", "error")
				TriggerEvent('jim-mechanic:client:Repair:Check', -1)
				return
			end
			if data.part == "Body" and math.floor((GetVehicleBodyHealth(vehicle)/10)+0.5) == 100 then
				TriggerEvent("QBCore:Notify", "Carroceria está com a vida máxima", "error")
				TriggerEvent('jim-mechanic:client:Repair:Check', -1)
				return
			end
			if data.part == "Radiator" and vehicleStatus['radiator'] == 100 then
				TriggerEvent('jim-mechanic:client:Repair:Check', -1)
				TriggerEvent("QBCore:Notify", "Radiador está com a vida máxima", "error")
				return
			end				
			if data.part == "Drive Shaft" and vehicleStatus['axle'] == 100 then
				TriggerEvent("QBCore:Notify", "Eixo de Transmissão está com a vida máxima", "error")
				TriggerEvent('jim-mechanic:client:Repair:Check', -1)
				return
			end				
			if data.part == "Brakes" and vehicleStatus['brakes'] == 100 then
				TriggerEvent("QBCore:Notify", "Travões estão com a vida máxima", "error")
				TriggerEvent('jim-mechanic:client:Repair:Check', -1)
				return
			end				
			if data.part == "Clutch" and vehicleStatus['clutch'] == 100 then
				TriggerEvent("QBCore:Notify", "Embreagem está com a vida máxima", "error")
				TriggerEvent('jim-mechanic:client:Repair:Check', -1)
				return
			end				
			if data.part == "Fuel Tank" and vehicleStatus['fuel'] == 100 then
				TriggerEvent("QBCore:Notify", "Tanque Combustível está com a vida máxima", "error")
				TriggerEvent('jim-mechanic:client:Repair:Check', -1)
				return
			end	
			TriggerEvent('animations:client:EmoteCommandStart', {"c"})
			exports['qb-menu']:openMenu({
				{ header = "Veículo: "..QBCore.Shared.Vehicles[modelName].name.." "..QBCore.Shared.Vehicles[modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[modelName].price.."€ | Matrícula: ["..GetVehicleNumberPlateText(vehicle).."]", isMenuHeader = true },
				
				{ header = "Queres reparar o "..data.part.."?", isMenuHeader = true },
				{ header = "Sim", params = { event = "jim-mechanic:client:Repair:Apply", args = { part = data.part, cost = data.cost} } },
				{ header = "Não", params = { event = "jim-mechanic:client:Repair:Check", args = -1 } },
			})
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:vehicledamage', function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	ClearPedTasks(playerPed)
	FreezeEntityPosition(playerPed, false)
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes verificar dentro do veículo", "error")
		ClearPedTasks(playerPed)
		return
	end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 4.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 4.5, 0, 71)
			SetVehicleModKit(vehicle, 0)
			modelName = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
			for k, v in pairs(Config.carNames) do if modelName == v.name then modelName = v.newName end	end
		end
		QBCore.Functions.TriggerCallback('qb-vehicletuning:server:GetStatus', function(status)
			if status == nil then TriggerEvent("QBCore:Notify", "Falha ao recuperar as informações do carro, tente executar o comando novamente", "error") TriggerServerEvent('vehiclemod:server:setupVehicleStatus', GetVehicleNumberPlateText(vehicle), GetVehicleEngineHealth(vehicle), GetVehicleBodyHealth(vehicle)) return end
			local vehicleStatus = status
			local RepairMenu = {
				{ isMenuHeader = true, header = "Veículo: "..QBCore.Shared.Vehicles[modelName].name.." "..QBCore.Shared.Vehicles[modelName].brand, txt = "Valor: "..QBCore.Shared.Vehicles[modelName].price.."€ | Matrícula: ["..GetVehicleNumberPlateText(vehicle).."]" },
				{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Menu:Close" } },
				{ isMenuHeader = true, header = "Motor", txt = "Status: "..math.floor((GetVehicleEngineHealth(vehicle)/10)+0.5).."%" },
				{ isMenuHeader = true, header = "Carroceria", txt =  "Status: "..math.floor((GetVehicleBodyHealth(vehicle)/10)+0.5).."%" },
				{ isMenuHeader = true, header = "Radiador", txt =  "Status: "..math.floor(vehicleStatus['radiator']+0.5).."%" },
				{ isMenuHeader = true, header = "Eixo Transmissão", txt =  "Status: "..math.floor(vehicleStatus['axle']+0.5).."%" },
				{ isMenuHeader = true, header = "Travões", txt =  "Status: "..math.floor(vehicleStatus['brakes']+0.5).."%" },
				{ isMenuHeader = true, header = "Embreagem", txt =  "Status: "..math.floor(vehicleStatus['clutch']+0.5).."%" },
				{ isMenuHeader = true, header = "Tanque Comb.", txt =  "Status: "..math.floor(vehicleStatus['fuel']+0.5).."%" },
			}			
			SetVehicleDoorOpen(vehicle, 4, false, false)
			time = math.random(3000,5000)
			for i = 0, 5 do
			  SetVehicleDoorOpen(vehicle, i, false, false) -- will open every door from 0-5
			end
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			QBCore.Functions.Progressbar("drink_something", "A verificar dano do motor..", time, false, true, { 
				disableMovement = true, 
				disableCarMovement = true, 
				disableMouse = false, 
				disableCombat = true, 
			}, {
				animDict = "mini@repair",
				anim = "fixing_a_ped",
				flags = 16,
			}, {}, {}, function()
				Wait(1000)
				time = math.random(3000,5000)
				QBCore.Functions.Progressbar("drink_something", "A verificar dano da carroceria..", time, false, true, { 
					disableMovement = true, 
					disableCarMovement = true, 
					disableMouse = false, 
					disableCombat = true, 
				}, {
				animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
				anim = "machinic_loop_mechandplayer",
				flags = 8,
				}, {}, {}, function()
					Wait(1000)
					ClearPedTasks(playerPed)
					FreezeEntityPosition(playerPed, false)						
					exports['qb-menu']:openMenu(RepairMenu)
				end, function() -- Cancel
					ClearPedTasks(playerPed)
					FreezeEntityPosition(playerPed, false)	
				end)
				Wait(time+1000)
			end, function() -- Cancel
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				return
			end)
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:quickrepair', function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local repaireng = true
	local repairbody = true
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	SetVehicleModKit(vehicle, 0)
	currentenginehealth = GetVehicleEngineHealth(vehicle)
	currentbodyhealth = GetVehicleBodyHealth(vehicle)
	
	if GetVehicleEngineHealth(vehicle) >= Config.MaxDuctEngine then repaireng = false else repaireng = true end
	if Config.DuctTapeBody and GetVehicleBodyHealth(vehicle) >= Config.MaxDuctBody then repairbody = false else repairbody = true end
	
	if repaireng or repairbody then
		TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
		Wait(1000)
		SetVehicleDoorOpen(vehicle, 4, false, false)
		QBCore.Functions.Progressbar("drink_something", "A aplicar fita adesiva..", 10000, false, true, { 
			disableMovement = true, 
			disableCarMovement = true, 
			disableMouse = false, 
			disableCombat = true, 
		}, {
			animDict = "mini@repair",
			anim = "fixing_a_ped",
			flags = 16,
		}, {}, {}, function()
			Wait(1000)
			ClearPedTasks(playerPed)
			FreezeEntityPosition(playerPed, false)						
			if Config.DuctSimpleMode then 
				SetVehicleEngineHealth(vehicle, Config.MaxDuctEngine) 
				SetVehicleBodyHealth(vehicle, Config.MaxDuctBody)
			elseif not Config.DuctSimpleMode then
				if currentenginehealth <= 50.0 and currentenginehealth <= 200 then 
					SetVehicleEngineHealth(vehicle, 300.0)
					--TriggerEvent("QBCore:Notify", "Engine repaired to "..(300.0/10).."%")
				else
					SetVehicleEngineHealth(vehicle, currentenginehealth + Config.DuctAmountEngine)
					if GetVehicleEngineHealth(vehicle) > Config.MaxDuctEngine then 
						
						SetVehicleEngineHealth(vehicle, Config.MaxDuctEngine)
					end
					--TriggerEvent("QBCore:Notify", "Engine is at "..(GetVehicleEngineHealth(vehicle)/10).."%")
				end
				
				if Config.DuctTapeBody then
					if currentbodyhealth <= 50.0 and currentbodyhealth <= 200 then 
						SetVehicleBodyHealth(vehicle, 300.0)
						--TriggerEvent("QBCore:Notify", "Body repaired to "..(300.0/10).."%")
					else
						SetVehicleBodyHealth(vehicle, currentbodyhealth + Config.DuctAmountBody)
						if GetVehicleBodyHealth(vehicle) > Config.MaxDuctBody then 
							SetVehicleBodyHealth(vehicle, Config.MaxDuctBody)
						end
						--TriggerEvent("QBCore:Notify", "Body is at "..(GetVehicleBodyHealth(vehicle)/10).."%")
					end
				end
				SetVehicleDoorShut(vehicle, 4, false, false)
			end
			if Config.RemoveDuctTape then TriggerServerEvent("jim-mechanic:server:removeTape") end
		end, function() -- Cancel
			SetVehicleDoorShut(vehicle, 4, false, false)
			ClearPedTasks(playerPed)
			FreezeEntityPosition(playerPed, false)	
		end)
	else
		TriggerEvent("QBCore:Notify", "Não podes usar mais fita adesiva neste veículo", "error")
	end
end)
