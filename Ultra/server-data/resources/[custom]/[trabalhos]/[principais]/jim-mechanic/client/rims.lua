local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Rims

RegisterNetEvent('jim-mechanic:client:Rims:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if data == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
	else
		TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
		Wait(1000)
		time = math.random(3000,5000)

		QBCore.Functions.Progressbar("drink_something", "A instalar", time, false, true, { 
			disableMovement = true, 
			disableCarMovement = true, 
			disableMouse = false, 
			disableCombat = true, 
		}, {
			animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
			anim = "machinic_loop_mechandplayer",
			flags = 8,
		}, {}, {}, function()
			SetVehicleModKit(vehicle, 0)
			SetVehicleWheelType(vehicle, tonumber(data.type))
			
			if not data.bike then
				SetVehicleMod(vehicle, 23, tonumber(data.mod), false)
			else
				SetVehicleMod(vehicle, 24, tonumber(data.mod), false)
			end
			--SetVehicleDoorShut(vehicle, 4, false)
			ClearPedTasks(playerPed)
			FreezeEntityPosition(playerPed, false)
			CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
			TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Rims:Choose', data.type)
			TriggerEvent("QBCore:Notify", "Successo! Jantes Instaladas", "success")
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", "Falhou a instalação das jantes!", "error")
			ClearPedTasks(playerPed)
			FreezeEntityPosition(playerPed, false)	
		end)
	end
end)

RegisterNetEvent('jim-mechanic:client:Rims:Check', function()
	if Config.CosmeticsJob then
		if Config.LocationRequired and not onDuty then
			TriggerEvent("QBCore:Notify", "Não estás na oficina", "error")
			return
		end
		if Config.RequiresJob == true then havejob = false
			for k, v in pairs(Config.JobRoles) do
				if v == PlayerJob.name then havejob = true end
			end
			if havejob == false then TriggerEvent('QBCore:Notify', "Apenas os mecânicos sabem fazer isto", "error") return end
		end
	end
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)  
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes instalar dentro do veículo", "error")
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
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)

						local cycle = false
				
					if IsThisModelABike(GetEntityModel(vehicle)) then cycle = true end
					--if IsThisModelABicycle(GetEntityModel(vehicle)) then cycle = true end
					--if IsThisModelAQuadbike(GetEntityModel(vehicle)) then cycle = true end

					local WheelMenu = { }

						WheelMenu[#WheelMenu + 1] = { header = "Rims Customisation", txt = "", isMenuHeader = true }
						WheelMenu[#WheelMenu + 1] = { header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Rims:Apply", args = -2 } }
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Sport", params = { event = "jim-mechanic:client:Rims:Choose", args = 0 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Muscle", params = { event = "jim-mechanic:client:Rims:Choose", args = 1 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Lowrider", params = { event = "jim-mechanic:client:Rims:Choose", args = 2 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "SUV", params = { event = "jim-mechanic:client:Rims:Choose", args = 3 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Offroad", params = { event = "jim-mechanic:client:Rims:Choose", args = 4 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Tuner", params = { event = "jim-mechanic:client:Rims:Choose", args = 5 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Highend", params = { event = "jim-mechanic:client:Rims:Choose", args = 7 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Benny's Originals", params = { event = "jim-mechanic:client:Rims:Choose", args = 8 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Benny's Bespoke", params = { event = "jim-mechanic:client:Rims:Choose", args = 9 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Open Wheel", params = { event = "jim-mechanic:client:Rims:Choose", args = 10 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Street", params = { event = "jim-mechanic:client:Rims:Choose", args = 11 } } end
						if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Track", params = { event = "jim-mechanic:client:Rims:Choose", args = 12 } } end
						--if not cycle then WheelMenu[#WheelMenu + 1] = { header = "Motorcycle", params = { event = "jim-mechanic:client:Rims:Choose", args = 6 } } end
						if cycle then WheelMenu[#WheelMenu + 1] = { header = "Front Wheel", params = { event = "jim-mechanic:client:Rims:Bike", args = { wheeltype = 6, bike = false } } } end
						if cycle then WheelMenu[#WheelMenu + 1] = { header = "Back Wheel", params = { event = "jim-mechanic:client:Rims:Bike", args = { wheeltype = 6, bike = true } } } end
											
					exports['qb-menu']:openMenu(WheelMenu)
							
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Rims:Choose', function(wheeltype)
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = { }
	local amountValidMods = 0   
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes instalar dentro do veículo", "error")
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
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
				originalWheel = GetVehicleWheelType(vehicle)
				SetVehicleWheelType(vehicle, tonumber(wheeltype))
				
			for i = 1, (GetNumVehicleMods(vehicle, 23) +1) do
				
				local modName = GetLabelText(GetModTextLabel(vehicle, 23, (i-1)))
				
				txt = ""
				if GetVehicleMod(vehicle, 23) == (i-1) and tonumber(originalWheel) == tonumber(wheeltype) then	
					txt = "Já Instalado"
				end
				validMods[i] =
				{
					id = (i-1),
					name = modName,
					install = txt
				}
			end
			
			local names = {}
			for i,v in ipairs(validMods) do
				if names[v.name] then
					names[v.name] = names[v.name] + 1
					v.name = v.name .. " - Tipo " .. names[v.name]
				else
					names[v.name] = 1
				end
			end

			table.sort(validMods, function(a,b) return a.name < b.name end)
		end

		if DoesEntityExist(vehicle) then
			local plate = GetVehicleNumberPlateText(vehicle)

			if GetVehicleMod(vehicle, 23) == -1 then
				stockinstall = "Já Instalado"
			elseif GetVehicleMod(vehicle, 23) ~= -1 then
				stockinstall = ""
			end
			
			labal = ""
			
			if wheeltype == 0 then label = "Sport" end
			if wheeltype == 1 then label = "Muscle" end
			if wheeltype == 2 then label = "Lowrider" end
			if wheeltype == 3 then label = "SUV" end
			if wheeltype == 4 then label = "OffRoad" end
			if wheeltype == 5 then label = "Tuner" end
			--if wheeltype == 6 then label = "Motorcycle" end
			if wheeltype == 7 then label = "Highend" end
			if wheeltype == 8 then label = "Benny's Originals" end
			if wheeltype == 9 then label = "Benny's Bespoke" end
			if wheeltype == 10 then label = "Open Wheel" end
			if wheeltype == 11 then label = "Street" end
			if wheeltype == 12 then label = "Track" end
			
			local RimsMenu = {
					{
						isMenuHeader = true,
						header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Jantes ('..string.upper(label)..')',
						txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, 23),
					},
					{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:Rims:Check" } },
					{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Rims:Apply",  args = { mod = -1, type = wheeltype, } } }
				}
				for k,v in pairs(validMods) do
					RimsMenu[#RimsMenu + 1] = { header = v.name, txt = v.install, params = { event = 'jim-mechanic:client:Rims:Apply', args = { mod = v.id, type = wheeltype, } } }
				end

			exports['qb-menu']:openMenu(RimsMenu)
			
			SetVehicleWheelType(vehicle, originalWheel)
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Rims:Bike', function(data)
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = { }
	local amountValidMods = 0   
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes instalar dentro do veículo", "error")
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
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
			
			if data.bike then
				wheel = 24
			else
				wheel = 23
			end
				originalWheel = GetVehicleWheelType(vehicle)
				SetVehicleWheelType(vehicle, tonumber(wheeltype))
			for i = 1, (GetNumVehicleMods(vehicle, wheel) +1) do
				local modName = GetLabelText(GetModTextLabel(vehicle, wheel, (i-1)))
				txt = ""
				if GetVehicleMod(vehicle, wheel) == (i-1) and tonumber(originalWheel) == tonumber(wheeltype) then	
					txt = "Já Instalado"
				end
					validMods[i] =
					{
						id = (i-1),
						name = modName,
						install = txt
					}
				local names = {}
				for i,v in ipairs(validMods) do
					if names[v.name] then
						names[v.name] = names[v.name] + 1
						v.name = v.name .. " - Tipo " .. names[v.name]
					else
						names[v.name] = 1
					end
				end

			table.sort(validMods, function(a,b) return a.name < b.name end)
			end
		end
		if DoesEntityExist(vehicle) then
			local plate = GetVehicleNumberPlateText(vehicle)
			if GetVehicleMod(vehicle, wheel) == -1 then
				stockinstall = "Já Instalado"
			elseif GetVehicleMod(vehicle, wheel) ~= -1 then
				stockinstall = ""
			end
			local RimsMenu = {
					{
						isMenuHeader = true,
						header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Jantes',
						txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, 23),
					},
					{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:Rims:Check" } },
					{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Rims:Apply",  args = { mod = -1, type = data.wheeltype, data.bike } } }
				}
				for k,v in pairs(validMods) do
					RimsMenu[#RimsMenu + 1] = { header = v.name, txt = v.install, params = { event = 'jim-mechanic:client:Rims:Apply', args = { mod = v.id, type = data.wheeltype, bike = data.bike } } }
				end

			exports['qb-menu']:openMenu(RimsMenu)
			SetVehicleWheelType(vehicle, originalWheel)
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)
