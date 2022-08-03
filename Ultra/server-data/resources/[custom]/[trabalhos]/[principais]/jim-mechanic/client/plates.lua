local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Plates
RegisterNetEvent('jim-mechanic:client:Plates:Custom:Apply', function(index)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if index == -1 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
	else
		if GetVehicleNumberPlateTextIndex(vehicle) == tonumber(index) then
			TriggerEvent("QBCore:Notify", "Matrícula já instalada!", "error")
			TriggerEvent('jim-mechanic:client:Plates:Custom')
		elseif GetVehicleNumberPlateTextIndex(vehicle) ~= tonumber(index) then
			time = math.random(3000,5000)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			QBCore.Functions.Progressbar("drink_something", "A instalar matrícula..", time, false, true, { 
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
				SetVehicleNumberPlateTextIndex(vehicle, index)
				--SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Plates:Custom')
				TriggerEvent("QBCore:Notify", "Successo! Matrícula Instalada", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a instalar a matrícula!", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Plates:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	if data == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
	else
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes instalar dentro do veículo", "error")
        ClearPedTasks(playerPed)
        return
    end	
		local label = GetModTextLabel(vehicle, tonumber(data.mod), tonumber(data.id))
		local modName = GetLabelText(label)
		if modName == "NULL" then modName = "Stock Plates" end
		if GetVehicleMod(vehicle, tonumber(data.mod)) == tonumber(data.id) then
			TriggerEvent('QBCore:Notify', modName.." já instalado!", "error")
			TriggerEvent('jim-mechanic:client:Plates:Choose', data)
		elseif GetVehicleMod(vehicle, tonumber(data.mod)) ~= tonumber(data.id) then
			time = math.random(3000,5000)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			QBCore.Functions.Progressbar("drink_something", "A instalar "..modName.."..", time, false, true, { 
				disableMovement = true, 
				disableCarMovement = true, 
				disableMouse = false, 
				disableCombat = true, 
			}, {
				animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
				anim = "machinic_loop_mechandplayer",
				flags = 16,
			}, {}, {}, function()
				SetVehicleModKit(vehicle, 0)
				SetVehicleMod(vehicle, tonumber(data.mod), tonumber(data.id))
				--SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Plates:Choose', data)
				TriggerEvent("QBCore:Notify", "Successo! "..modName.." Instalado", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a instalar a matrícula!", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
			end)
		else
			TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Plates:Check', function()
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
					if GetNumVehicleMods(vehicle, 25) ~= 0 then vanity = true else vanity = false end 
					if GetNumVehicleMods(vehicle, 26) ~= 0 then vanity2 = true else vanity2 = false end 
					
					installed1 = GetLabelText(GetModTextLabel(vehicle, 25, GetVehicleMod(vehicle, 25)))
					installed2 = GetLabelText(GetModTextLabel(vehicle, 26, GetVehicleMod(vehicle, 26)))
				
					if installed1 == "NULL" then installed1 = "Stock" else end
					if installed2 == "NULL" then installed2 = "Stock" else end

					local PlatesMenu = {
						{ isMenuHeader = true, header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Matrícula', },
						{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Plates:Apply", args = -2 } }
					}
					
					if vanity then PlatesMenu[#PlatesMenu + 1] = { header = "Suporte Matrícula", txt = "["..(GetNumVehicleMods(vehicle, 25)+1).." Opções] Instalado: "..installed1, params = { event = "jim-mechanic:client:Plates:Choose", args = { mod = 25 } } } end
					if vanity2 then PlatesMenu[#PlatesMenu + 1] = { header = "Matrículas Vanity", txt = "["..(GetNumVehicleMods(vehicle, 26)+1).." Opções] Instalado: "..installed2, params = { event = "jim-mechanic:client:Plates:Choose", args = { mod = 26 } } } end
					PlatesMenu[#PlatesMenu + 1] = { header = "Matrículas Customizadas", txt = "["..GetNumberOfVehicleNumberPlates(vehicle).." Opções] Instalado: "..installed1, params = { event = "jim-mechanic:client:Plates:Custom" } }

					exports['qb-menu']:openMenu(PlatesMenu)
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Plates:Custom', function()
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
		if DoesEntityExist(vehicle) then
			local plate = GetVehicleNumberPlateText(vehicle)
			local installs = {}
			for i = 1, 6 do
				if GetVehicleNumberPlateTextIndex(vehicle) == i-1 then
					installs[i-1] = { txt = "Já Instalado" }
				elseif GetVehicleNumberPlateTextIndex(vehicle) ~= i-1 then
					installs[i-1] = { txt = "" }
				end
			end
			exports['qb-menu']:openMenu({
				{ header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))).." Matrículas Customizadas", isMenuHeader = true },
				{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:Plates:Check" } },
				{ header = "Azul no Branco #1", txt = installs[0].txt, params = { event = "jim-mechanic:client:Plates:Custom:Apply", args = 0 } },
				{ header = "Azul no Branco #2", txt = installs[3].txt, params = { event = "jim-mechanic:client:Plates:Custom:Apply", args = 3 } },
				{ header = "Azul no Branco #3", txt = installs[4].txt, params = { event = "jim-mechanic:client:Plates:Custom:Apply", args = 4 } },
				{ header = "Amarelo no Azul", txt = installs[2].txt, params = { event = "jim-mechanic:client:Plates:Custom:Apply", args = 2 } },
				{ header = "Amarelo no Preto", txt = installs[1].txt, params = { event = "jim-mechanic:client:Plates:Custom:Apply", args = 1 } },
				{ header = "North Yankton", txt = installs[5].txt, params = { event = "jim-mechanic:client:Plates:Custom:Apply", args = 5 } },
			})
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Plates:Choose', function(data)
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
			for i = 1, GetNumVehicleMods(vehicle, tonumber(data.mod)) do
				local label = GetModTextLabel(vehicle, tonumber(data.mod), (i - 1))
				local modName = GetLabelText(label)
				if GetVehicleMod(vehicle,  tonumber(data.mod)) == (i-1) then
					txt = "Já Instalado"
				elseif GetVehicleMod(vehicle,  tonumber(data.mod)) ~= (i-1) then
					txt = ""
				end
				validMods[i] =
				{
					id = (i - 1),
					name = modName,
					install = txt
				}
				amountValidMods = amountValidMods + 1
			end
		end
		if DoesEntityExist(vehicle) then
			local plate = GetVehicleNumberPlateText(vehicle)					
			if GetVehicleMod(vehicle, tonumber(data.mod)) == -1 then
				stockinstall = "Já Instalado"
			elseif GetVehicleMod(vehicle, tonumber(data.mod)) ~= -1 then
				stockinstall = ""
			end
			local ModMenu = {
					{
						isMenuHeader = true,
						header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Matrícula',
						txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, tonumber(data.mod))+1,
					},
					{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:Plates:Check" } },
					{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Plates:Apply", args = { id = -1, mod = tonumber(data.mod) } }
					}	
				}
				for k,v in pairs(validMods) do
					ModMenu[#ModMenu + 1] = { header = v.name, txt = v.install, params = { event = 'jim-mechanic:client:Plates:Apply', args = { id = v.id, mod = data.mod } } }
				end
				
			exports['qb-menu']:openMenu(ModMenu)
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)
