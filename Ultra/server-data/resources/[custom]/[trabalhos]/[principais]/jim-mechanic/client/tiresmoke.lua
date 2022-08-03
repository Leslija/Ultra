local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Tires

RegisterNetEvent('jim-mechanic:client:Tires:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	SetVehicleModKit(vehicle, 0)
	if data == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
	else
		spraying = true

		local r,g,b = GetVehicleTyreSmokeColor(vehicle)

		if r == data.R and g == data.G and b == data.B then
			TriggerEvent("QBCore:Notify", "Esta cor está atualmente aplicada!", "error")
			TriggerEvent('jim-mechanic:client:Tires:Check')
		else
			time = math.random(3000,5000)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			local fwd = GetEntityForwardVector(playerPed)
				local coords = GetEntityCoords(playerPed) + fwd * 0.5 + vector3(0.0, 0.0, -0.5)
				
				CreateThread(function()
					local min = 255
					while spraying do
						local sleep = 3000
						min = min - (min/sleep) * 1000
						
						RequestNamedPtfxAsset("scr_recartheft")
						-- Wait for the particle dictionary to load.
						while not HasNamedPtfxAssetLoaded("scr_recartheft") do
							Citizen.Wait(0)
						end
						local pointers = {}
						--local color = {255, 255, 255}
						local heading = GetEntityHeading(PlayerPed)
						UseParticleFxAssetNextCall("scr_recartheft")
						
						SetParticleFxNonLoopedColour(data.R / 255, data.G / 255, data.B / 255)
						SetParticleFxNonLoopedAlpha(1.0)
						local spray = StartNetworkedParticleFxNonLoopedAtCoord("scr_wheel_burnout", coords.x, coords.y, coords.z, 0.0, 0.0, heading, 0.7, 0.0, 0.0, 0.0)
						
						Wait(3000)
					end
				end)

			QBCore.Functions.Progressbar("drink_something", "A instalar fumo nos pneus..", time, false, true, { 
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
				ToggleVehicleMod(vehicle, 20, true)
				SetVehicleTyreSmokeColor(vehicle, data.R, data.G, data.B)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Tires:Choose')
				TriggerEvent("QBCore:Notify", "Successo! Fumo pneus instalado", "success")
				spraying = false
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a instalar fumo nos pneus!", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
				spraying = false
			end)
		end
	end
end)


RegisterNetEvent('jim-mechanic:client:Tires:Check', function()
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)  
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
		if Config.isVehicleOwned and not owned then
			TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
			return
		else	
			SetVehicleModKit(vehicle, 0)
			local r,g,b = GetVehicleTyreSmokeColor(vehicle)
			
			local applied0 = ""
			local applied1 = ""
			local applied2 = ""
			local applied3 = ""
			local applied4 = ""
			local applied5 = ""
			local applied6 = ""
			local applied7 = ""
			local applied8 = ""
			local applied9 = ""
			local applied10 = ""
			local applied11 = ""
			local applied12 = ""
			local applied13 = ""
			local applied14 = ""
			local applied15 = ""
			
			if r == 1 and g == 1 and b == 1 then applied1 = "Atualmente Aplicado"
			elseif r == 255 and g == 255 and b == 255 then applied2 = "Atualmente Aplicado"
			elseif r == 2 and g == 21 and b == 255 then applied3 = "Atualmente Aplicado"
			elseif r == 3 and g == 83 and b == 255 then applied4 = "Atualmente Aplicado"
			elseif r == 0 and g == 255 and b == 140 then applied5 = "Atualmente Aplicado"
			elseif r == 94 and g == 255 and b == 1 then applied6 = "Atualmente Aplicado"
			elseif r == 255 and g == 255 and b == 0 then applied7 = "Atualmente Aplicado"
			elseif r == 255 and g == 150 and b == 0 then applied8 = "Atualmente Aplicado"
			elseif r == 255 and g == 62 and b == 1 then applied9 = "Atualmente Aplicado"
			elseif r == 255 and g == 1 and b == 1 then applied10 = "Atualmente Aplicado"
			elseif r == 255 and g == 50 and b == 100 then applied11 = "Atualmente Aplicado"
			elseif r == 255 and g == 5 and b == 190 then applied12 = "Atualmente Aplicado"
			elseif r == 35 and g == 1 and b == 255 then applied13 = "Atualmente Aplicado"
			elseif r == 15 and g == 3 and b == 255 then applied14 = "Atualmente Aplicado"
			elseif r == 0 and g == 0 and b == 0 then applied15 = "Atualmente Aplicado"
			else applied0 = "Atualmente Aplicado" end
			
			exports['qb-menu']:openMenu({
				{ header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))).." Customização Fumo Pneus", txt = "", },
				{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Tires:Apply", args = -2 } },
				{ header = "CUSTOM RBG", txt = applied0, params = { event = "jim-mechanic:client:smokeCustomMenu", } },
				{ header = "Black", txt = applied1, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 1, G = 1, B = 1 } } },
				{ header = "White", txt = applied2, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 255, B = 255 } } },
				{ header = "Blue", txt = applied3, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 2, G = 21, B = 255 } } },
				{ header = "Electric Blue", txt = applied4, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 3, G = 83, B = 255 } } },
				{ header = "Mint Green", txt = applied5, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 0, G = 255, B = 140 } } },
				{ header = "Lime Green", txt = applied6, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 94, G = 255, B = 1 } } },
				{ header = "Yellow", txt = applied7, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 255, B = 0 } } },
				{ header = "Golden Shower", txt = applied8, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 150, B = 0 } } },
				{ header = "Orange", txt = applied9,  params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 62, B = 0 } } },
				{ header = "Red", txt = applied10, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 1, B = 1 } } },
				{ header = "Pony Pink", txt = applied11, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 50, B = 100 } } },
				{ header = "Hot Pink", txt = applied12, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 255, G = 5, B = 190 } } },
				{ header = "Purple", txt = applied13, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 35, G = 1, B = 255 } } },
				{ header = "Blacklight", txt = applied14, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 15, G = 3, B = 255 } } },
				{ header = "Remove Smoke", txt = applied15, params = { event = "jim-mechanic:client:Tires:Apply", args = { R = 0, G = 0, B = 0 } } },
				
			})
		end
	end, GetVehicleNumberPlateText(vehicle))
end)

RegisterNetEvent('jim-mechanic:client:smokeCustomMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Escolhe RBG",
        submitText = "APLICAR",
        inputs = {
            { type = 'number', isRequired = true, name = 'R', text = 'Red' },
            { type = 'number', isRequired = true, name = 'G', text = 'Green' },
            { type = 'number', isRequired = true, name = 'B', text = 'Blue' }
        }
    })
    if dialog then
        if not dialog.R or not dialog.G or not dialog.B then return end
        local data = {}
		data = { R = tonumber(dialog.R), G = tonumber(dialog.G), B = tonumber(dialog.B) }
		TriggerEvent('jim-mechanic:client:Tires:Apply', data)
    end
end)