local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Interior

RegisterNetEvent('jim-mechanic:client:Interior:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetVehiclePedIsIn(playerPed, false)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if data == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		
		for i = 0, 5 do
		  SetVehicleDoorShut(vehicle, i, false, true) -- will open every door from 0-5
		end
		
		exports['qb-menu']:closeMenu()
	else
		local label = GetModTextLabel(vehicle, tonumber(data.bumperid), tonumber(data.mod))
		local modName = GetLabelText(label)
		if modName == "NULL" then modName = "Stock Interior" end
		if GetVehicleMod(vehicle, tonumber(data.bumperid)) == tonumber(data.mod) then
			TriggerEvent('QBCore:Notify', modName.." já instalado!", "error")
			TriggerEvent('jim-mechanic:client:Interior:Choose', tonumber(data.bumperid))
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
				flags = 16,
			}, {}, {}, function()
				SetVehicleModKit(vehicle, 0)
				SetVehicleMod(vehicle, tonumber(data.bumperid), tonumber(data.mod))
				--SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Interior:Choose', tonumber(data.bumperid))
				TriggerEvent("QBCore:Notify", "Successo! "..modName.." Instalado", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a instalar o interior!", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Interior:Check', function()
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
		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
			local vehicle = nil
			if IsPedInAnyVehicle(playerPed, false) then
				vehicle = GetVehiclePedIsIn(playerPed, false)
				SetVehicleModKit(vehicle, 0)
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
						if GetNumVehicleMods(vehicle, 5) ~= 0 then rollcage = true else rollcage = false end 
						if GetNumVehicleMods(vehicle, 28) ~= 0 then ornaments = true else ornaments = false end 
						if GetNumVehicleMods(vehicle, 29) ~= 0 then dashboard = true else dashboard = false end 
						if GetNumVehicleMods(vehicle, 30) ~= 0 then dials = true else dials = false end 
						if GetNumVehicleMods(vehicle, 31) ~= 0 then doorspeaker = true else doorspeaker = false end 
						if GetNumVehicleMods(vehicle, 33) ~= 0 then steering = true else steering = false end 
						if GetNumVehicleMods(vehicle, 34) ~= 0 then shifter = true else shifter = false end 
						if GetNumVehicleMods(vehicle, 35) ~= 0 then plaque = true else plaque = false end 
						if GetNumVehicleMods(vehicle, 36) ~= 0 then speaker = true else speaker = false end 
						
						installed1 = GetLabelText(GetModTextLabel(vehicle, 5, GetVehicleMod(vehicle, 25)))
						installed2 = GetLabelText(GetModTextLabel(vehicle, 28, GetVehicleMod(vehicle, 27)))
						installed3 = GetLabelText(GetModTextLabel(vehicle, 29, GetVehicleMod(vehicle, 44)))
						installed4 = GetLabelText(GetModTextLabel(vehicle, 30, GetVehicleMod(vehicle, 37)))
						installed5 = GetLabelText(GetModTextLabel(vehicle, 31, GetVehicleMod(vehicle, 39)))
						installed6 = GetLabelText(GetModTextLabel(vehicle, 33, GetVehicleMod(vehicle, 40)))
						installed7 = GetLabelText(GetModTextLabel(vehicle, 34, GetVehicleMod(vehicle, 41)))
						installed8 = GetLabelText(GetModTextLabel(vehicle, 35, GetVehicleMod(vehicle, 38)))
						installed9 = GetLabelText(GetModTextLabel(vehicle, 36, GetVehicleMod(vehicle, 36)))

						if installed1 == "NULL" then installed1 = "Stock" else end
						if installed2 == "NULL" then installed2 = "Stock" else end
						if installed3 == "NULL" then installed3 = "Stock" else end
						if installed4 == "NULL" then installed4 = "Stock" else end
						if installed5 == "NULL" then installed5 = "Stock" else end
						if installed6 == "NULL" then installed6 = "Stock" else end
						if installed7 == "NULL" then installed7 = "Stock" else end
						if installed8 == "NULL" then installed8 = "Stock" else end						
						if installed9 == "NULL" then installed9 = "Stock" else end						
						
						if not rollcage and not ornaments and not dashboard and not dials and not doorspeaker and not steering and not shifter and not plaque and not speaker then
							TriggerEvent("QBCore:Notify", "Nenhuma opção disponivel para este item", "error")
							return
						end
						local InteriorMenu = {
							{ isMenuHeader = true, header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Interior Modification', },
							{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Interior:Apply", args = -2 } }
						}
						
						if rollcage then InteriorMenu[#InteriorMenu + 1] = { header = "Gaiolas", txt = "["..(GetNumVehicleMods(vehicle, 5)+1).." Opções] Instalado: "..installed1, params = { event = "jim-mechanic:client:Interior:Choose", args = 5 } } end
						if ornaments then InteriorMenu[#InteriorMenu + 1] = { header = "Enfeites", txt = "["..(GetNumVehicleMods(vehicle, 28)+1).." Opções] Instalado: "..installed2, params = { event = "jim-mechanic:client:Interior:Choose", args = 28 } } end
						if dashboard then InteriorMenu[#InteriorMenu + 1] = { header = "Painéis", txt = "["..(GetNumVehicleMods(vehicle, 29)+1).." Opções] Instalado: "..installed3, params = { event = "jim-mechanic:client:Interior:Choose", args = 29 } } end
						if dials then InteriorMenu[#InteriorMenu + 1] = { header = "Mostradores", txt = "["..(GetNumVehicleMods(vehicle, 30)+1).." Opções] Instalado: "..installed4, params = { event = "jim-mechanic:client:Interior:Choose", args = 30 } } end
						if doorspeaker then InteriorMenu[#InteriorMenu + 1] = { header = "Colunas Portas", txt = "["..(GetNumVehicleMods(vehicle, 31)+1).." Opções] Instalado: "..installed5, params = { event = "jim-mechanic:client:Interior:Choose", args = 31 } } end
						if steering then InteriorMenu[#InteriorMenu + 1] = { header = "Volantes", txt = "["..(GetNumVehicleMods(vehicle, 33)+1).." Opções] Instalado: "..installed6, params = { event = "jim-mechanic:client:Interior:Choose", args = 33 } } end
						if shifter then InteriorMenu[#InteriorMenu + 1] = { header = "Mudanças", txt = "["..(GetNumVehicleMods(vehicle, 34)+1).." Opções] Instalado: "..installed7, params = { event = "jim-mechanic:client:Interior:Choose", args = 34 } } end
						if plaque then InteriorMenu[#InteriorMenu + 1] = { header = "Placas", txt = "["..(GetNumVehicleMods(vehicle, 35)+1).." Opções] Instalado: "..installed8, params = { event = "jim-mechanic:client:Interior:Choose", args = 35 } } end
						if speaker then InteriorMenu[#InteriorMenu + 1] = { header = "Colunas", txt = "["..(GetNumVehicleMods(vehicle, 36)+1).." Opções] Instalado: "..installed9, params = { event = "jim-mechanic:client:Interior:Choose", args = 36 } } end
							
						exports['qb-menu']:openMenu(InteriorMenu)
					end
				end
			end, GetVehicleNumberPlateText(vehicle))
		else
			TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
		end
	else
		TriggerEvent("QBCore:Notify", "Tens que estar dentro do veículo", "error")
        ClearPedTasks(playerPed)
        return
    end
end)

RegisterNetEvent('jim-mechanic:client:Interior:Choose', function(mod)
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = { }
	local amountValidMods = 0   
	local vehicle = nil
	if IsPedInAnyVehicle(playerPed, true) then
		vehicle = GetVehiclePedIsIn(playerPed, true)
		SetVehicleModKit(vehicle, 0)
		vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
		for i = 1, GetNumVehicleMods(vehicle, tonumber(mod)) do
			local label = GetModTextLabel(vehicle, tonumber(mod), (i - 1))
			local modName = GetLabelText(label)
			if GetVehicleMod(vehicle,  tonumber(mod)) == (i-1) then
				txt = "Já Instalado"
			elseif GetVehicleMod(vehicle,  tonumber(mod)) ~= (i-1) then
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
		if GetVehicleMod(vehicle, tonumber(mod)) == -1 then
			stockinstall = "Já Instalado"
		elseif GetVehicleMod(vehicle, tonumber(mod)) ~= -1 then
			stockinstall = ""
		end
		
		for i = 0, 5 do
		  SetVehicleDoorOpen(vehicle, i, false, false) -- will open every door from 0-5
		end
		
		local ModMenu = {
				{
					isMenuHeader = true,
					header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Interior',
					txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, tonumber(mod))+1,
				},
				{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:Interior:Check" } },
				{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Interior:Apply", args = { mod = -1, bumperid = tonumber(mod) } }
				}	
			}
			for k,v in pairs(validMods) do
				ModMenu[#ModMenu + 1] = { header = v.name, txt = v.install, params = { event = 'jim-mechanic:client:Interior:Apply', args = { mod = v.id, bumperid = mod } } }
			end
			
		exports['qb-menu']:openMenu(ModMenu)
	end
end)
