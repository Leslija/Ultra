local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Skirts

RegisterNetEvent('jim-mechanic:client:Skirts:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if data == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
	else
		local label = GetModTextLabel(vehicle, tonumber(data.bumperid), tonumber(data.mod))
		local modName = GetLabelText(label)
		if modName == "NULL" then modName = "Stock Skirts" end
		if GetVehicleMod(vehicle, tonumber(data.bumperid)) == tonumber(data.mod) then
			TriggerEvent('QBCore:Notify', modName.." já instalado!", "error")
			TriggerEvent('jim-mechanic:client:Skirts:Choose', tonumber(data.bumperid))
		elseif GetVehicleMod(vehicle, tonumber(data.bumperid)) ~= tonumber(data.mod) then
			time = math.random(3000,5000)

			QBCore.Functions.Progressbar("drink_something", "A instalar "..modName.."..", time, false, true, { 
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
				SetVehicleMod(vehicle, tonumber(data.bumperid), tonumber(data.mod))
				--SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Skirts:Choose', tonumber(data.bumperid))
				TriggerEvent("QBCore:Notify", "Successo! Saias instaladas", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou ao instalar saias", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Skirts:Check', function()
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
					if GetNumVehicleMods(vehicle, 3) ~= 0 then skirt = true else skirt = false end 
					if GetNumVehicleMods(vehicle, 9) ~= 0 then rfend = true else rfend = false end 
					if GetNumVehicleMods(vehicle, 8) ~= 0 then lfend = true else lfend = false end 
					
					installed1 = GetLabelText(GetModTextLabel(vehicle, 3, GetVehicleMod(vehicle, 3)))
					installed2 = GetLabelText(GetModTextLabel(vehicle, 9, GetVehicleMod(vehicle, 9)))
					installed3 = GetLabelText(GetModTextLabel(vehicle, 8, GetVehicleMod(vehicle, 8)))
					
					if installed1 == "NULL" then installed1 = "Stock" else end
					if installed2 == "NULL" then installed2 = "Stock" else end
					if installed3 == "NULL" then installed3 = "Stock" else end				
					
					if not skirt and not rfend and not lfend then
						TriggerEvent("QBCore:Notify", "Nenhuma opção disponivel para este item", "error")
						return
					end			
					local SkirtMenu = {
						{ isMenuHeader = true, header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Skirt and Fender Cosmetics', },
						{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Skirts:Apply", args = -2 } }
					}
					
					if skirt then SkirtMenu[#SkirtMenu + 1] = { header = "Saias", txt = "["..(GetNumVehicleMods(vehicle, 3)+1).." Opções] Instalado: "..installed1, params = { event = "jim-mechanic:client:Skirts:Choose", args = 3 } } end
					if rfend then SkirtMenu[#SkirtMenu + 1] = { header = "Pára-Choque Direito", txt = "["..(GetNumVehicleMods(vehicle, 9)+1).." Opções] Instalado: "..installed2, params = { event = "jim-mechanic:client:Skirts:Choose", args = 9 } } end
					if lfend then SkirtMenu[#SkirtMenu + 1] = { header = "Pára-Choque Esquerdo", txt = "["..(GetNumVehicleMods(vehicle, 8)+1).." Opções] Instalado: "..installed3, params = { event = "jim-mechanic:client:Skirts:Choose", args = 8 } } end

					exports['qb-menu']:openMenu(SkirtMenu)					
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Skirts:Choose', function(mod)
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
			for i = 1, GetNumVehicleMods(vehicle, mod) do
				local label = GetModTextLabel(vehicle, mod, (i - 1))
				local modName = GetLabelText(label)
				if GetVehicleMod(vehicle, mod) == (i-1) then
					txt = "Já Instalado"
				elseif GetVehicleMod(vehicle, mod) ~= (i-1) then
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
			if GetVehicleMod(vehicle, mod) == -1 then
				stockinstall = "Já Instalado"
			elseif GetVehicleMod(vehicle, mod) ~= -1 then
				stockinstall = ""
			end
			local SkirtsMenu = {
					{
						isMenuHeader = true,
						header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Saias',
						txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, tonumber(mod))+1,
					},
					{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:Skirts:Check" } },
					{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Skirts:Apply", args = { mod = -1, bumperid = tonumber(mod) } }
					}	
				}
				for k,v in pairs(validMods) do
					SkirtsMenu[#SkirtsMenu + 1] = { header = v.name, txt = v.install, params = { event = 'jim-mechanic:client:Skirts:Apply', args = { mod = tostring(v.id), bumperid = tonumber(mod) } } }
				end
			exports['qb-menu']:openMenu(SkirtsMenu)
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)
