local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Exterior
RegisterNetEvent('jim-mechanic:client:Exterior:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if data == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		
		for i = 0, 5 do
		  SetVehicleDoorShut(vehicle, i, false, true) -- will open every door from 0-5
		end
		
		exports['qb-menu']:closeMenu()
	else
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes instalar dentro do veículo", "error")
        ClearPedTasks(playerPed)
        return
    end	
		local label = GetModTextLabel(vehicle, tonumber(data.mod), tonumber(data.id))
		local modName = GetLabelText(label)
		if modName == "NULL" then modName = "Stock Exterior" end
		if GetVehicleMod(vehicle, tonumber(data.mod)) == tonumber(data.id) then
			TriggerEvent('QBCore:Notify', modName.." já instalado!", "error")
			TriggerEvent('jim-mechanic:client:Exterior:Choose', data)
		elseif GetVehicleMod(vehicle, tonumber(data.mod)) ~= tonumber(data.id) then
			time = math.random(3000,5000)

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
				TriggerEvent('jim-mechanic:client:Exterior:Choose', data)
				TriggerEvent("QBCore:Notify", "Successo! "..modName.." Instalado", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a instalação do exterior!", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
			end)
		else
			TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Exterior:Check', function()
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
				
					if GetNumVehicleMods(vehicle, 27) ~= 0 then trima = true else trima = false end 
					if GetNumVehicleMods(vehicle, 44) ~= 0 then trimb = true else trimb = false end 
					if GetNumVehicleMods(vehicle, 37) ~= 0 then trunk = true else trunk = false end 
					if GetNumVehicleMods(vehicle, 39) ~= 0 then engineblock = true else engineblock = false end 
					if GetNumVehicleMods(vehicle, 40) ~= 0 then filter = true else filter = false end 
					if GetNumVehicleMods(vehicle, 41) ~= 0 then strut = true else strut = false end 
					
					if GetNumVehicleMods(vehicle, 38) ~= 0 then hydraulic = true else hydraulic = false end 
					if GetNumVehicleMods(vehicle, 42) ~= 0 then archcover = true else archcover = false end 
					if GetNumVehicleMods(vehicle, 45) ~= 0 then fueltank = true else fueltank = false end 
					if GetNumVehicleMods(vehicle, 43) ~= 0 then aerial = true else aerial = false end 

					installed2 = GetLabelText(GetModTextLabel(vehicle, 27, GetVehicleMod(vehicle, 27)))
					installed3 = GetLabelText(GetModTextLabel(vehicle, 44, GetVehicleMod(vehicle, 44)))
					installed4 = GetLabelText(GetModTextLabel(vehicle, 37, GetVehicleMod(vehicle, 37)))
					installed5 = GetLabelText(GetModTextLabel(vehicle, 39, GetVehicleMod(vehicle, 39)))
					installed6 = GetLabelText(GetModTextLabel(vehicle, 40, GetVehicleMod(vehicle, 40)))
					installed7 = GetLabelText(GetModTextLabel(vehicle, 41, GetVehicleMod(vehicle, 41)))
					installed8 = GetLabelText(GetModTextLabel(vehicle, 38, GetVehicleMod(vehicle, 38)))
					installed9 = GetLabelText(GetModTextLabel(vehicle, 42, GetVehicleMod(vehicle, 42)))
					installed10 = GetLabelText(GetModTextLabel(vehicle, 45, GetVehicleMod(vehicle, 45)))
					installed11 = GetLabelText(GetModTextLabel(vehicle, 43, GetVehicleMod(vehicle, 43)))

					if installed2 == "NULL" then installed2 = "Stock" else end
					if installed3 == "NULL" then installed3 = "Stock" else end
					if installed4 == "NULL" then installed4 = "Stock" else end
					if installed5 == "NULL" then installed5 = "Stock" else end
					if installed6 == "NULL" then installed6 = "Stock" else end
					if installed7 == "NULL" then installed7 = "Stock" else end
					if installed8 == "NULL" then installed8 = "Stock" else end
					if installed9 == "NULL" then installed9 = "Stock" else end
					if installed10 == "NULL" then installed10 = "Stock" else end
					if installed11 == "NULL" then installed11 = "Stock" else end
					
					if not trima and not trimb and not trunk and not engineblock and not filter and not strut and not hydraulic and not archcover and not fueltank and not aerial then
						TriggerEvent("QBCore:Notify", "Nenhuma opção disponivel para este item", "error")
						return
					end
					local ExteriorMenu = {
						{ isMenuHeader = true, header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Exterior Modification', },
						{ header = "", txt = "Close", params = { event = "jim-mechanic:client:Exterior:Apply", args = -2 } }
					}
					
					if trima then ExteriorMenu[#ExteriorMenu + 1] = { header = "Guarnição A", txt = "["..(GetNumVehicleMods(vehicle, 27)+1).." Opções] Instalado: "..installed2, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 27 } } } end
					if trimb then ExteriorMenu[#ExteriorMenu + 1] = { header = "Guarnição B", txt = "["..(GetNumVehicleMods(vehicle, 44)+1).." Opções] Instalado: "..installed3, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 44 } } } end
					if trunk then ExteriorMenu[#ExteriorMenu + 1] = { header = "Mala", txt = "["..(GetNumVehicleMods(vehicle, 37)+1).." Opções] Instalado: "..installed4, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 37 } } } end
					if engineblock then ExteriorMenu[#ExteriorMenu + 1] = { header = "Blocos Motor", txt = "["..(GetNumVehicleMods(vehicle, 39)+1).." Opções] Instalado: "..installed5, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 39 } } } end
					if filter then ExteriorMenu[#ExteriorMenu + 1] = { header = "Filtro", txt = "["..(GetNumVehicleMods(vehicle, 40)+1).." Opções] Instalado: "..installed6, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 40 } } } end
					if strut then ExteriorMenu[#ExteriorMenu + 1] = { header = "Suportes", txt = "["..(GetNumVehicleMods(vehicle, 41)+1).." Opções] Instalado: "..installed7, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 41 } } } end

					if hydraulic then ExteriorMenu[#ExteriorMenu + 1] = { header = "Hidráulicos", txt = "["..(GetNumVehicleMods(vehicle, 38)+1).." Opções] Instalado: "..installed8, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 38 } } } end
					if archcover then ExteriorMenu[#ExteriorMenu + 1] = { header = "Cobertura Arcos", txt = "["..(GetNumVehicleMods(vehicle, 42)+1).." Opções] Instalado: "..installed9, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 42 } } } end
					if fueltank then ExteriorMenu[#ExteriorMenu + 1] = { header = "Tanques Comb.", txt = "["..(GetNumVehicleMods(vehicle, 45)+1).." Opções] Instalado: "..installed10, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 45 } } } end
					if aerial then ExteriorMenu[#ExteriorMenu + 1] = { header = "Aéreos", txt = "["..(GetNumVehicleMods(vehicle, 43)+1).." Opções] Instalado: "..installed11, params = { event = "jim-mechanic:client:Exterior:Choose", args = { mod = 43 } } } end
				
					exports['qb-menu']:openMenu(ExteriorMenu)
				end
			end
		end, GetVehicleNumberPlateText(vehicle))		
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Exterior:Choose', function(data)
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
			
			for i = 0, 5 do
			  SetVehicleDoorOpen(vehicle, i, false, false) -- will open every door from 0-5
			end
			
			local ModMenu = {
					{
						isMenuHeader = true,
						header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Exterior',
						txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, tonumber(data.mod))+1,
					},
					{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:Exterior:Check" } },
					{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Exterior:Apply", args = { id = -1, mod = tonumber(data.mod) } }
					}	
				}
				for k,v in pairs(validMods) do
					ModMenu[#ModMenu + 1] = { header = v.name, txt = v.install, params = { event = 'jim-mechanic:client:Exterior:Apply', args = { id = v.id, mod = data.mod } } }
				end
				
			exports['qb-menu']:openMenu(ModMenu)
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)
