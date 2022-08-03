local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Paint

RegisterNetEvent('jim-mechanic:client:Paints:Apply', function(data)
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
		local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
		local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
		
		if data.paint == "Primary" then colourCheck = vehPrimaryColour end
		if data.paint == "Secondary" then colourCheck = vehSecondaryColour end
		if data.paint == "Pearlescent" then colourCheck = vehPearlescentColour end
		if data.paint == "Wheel" then colourCheck = vehWheelColour end
	
		local label = GetModTextLabel(vehicle, 7, tonumber(mod))
		local modName = GetLabelText(label)
		if colourCheck == data.id then
			TriggerEvent('QBCore:Notify', data.finish.." "..data.name.." pintura já está aplicada!", "error")
			TriggerEvent('jim-mechanic:client:Paints:Choose:Paint', data)
		elseif colourCheck ~= data.id then
			time = math.random(3000,5000)
			local fwd = GetEntityForwardVector(playerPed)
			local coords = GetEntityCoords(playerPed) + fwd * 0.5 + vector3(0.0, 0.0, -0.5)
			
			CreateThread(function()
				local min = 255
				while spraying do
					local sleep = 3000
					min = min - (min/sleep) * 1000
					
					RequestNamedPtfxAsset("scr_recartheft")
					
					while not HasNamedPtfxAssetLoaded("scr_recartheft") do
						Citizen.Wait(0)
					end
					local pointers = {}
					local color = {255, 255, 255}
					local heading = GetEntityHeading(PlayerPed)
					UseParticleFxAssetNextCall("scr_recartheft")
					
					if string.find(data.name, "Red") then color = {255, 1, 1} end
					if string.find(data.name, "Black") then color = {1, 1, 1} end
					if string.find(data.name, "Blue") then color = {2, 21, 255} end
					if string.find(data.name, "Green") then color = {94, 255, 1} end
					if string.find(data.name, "Yellow") then color = {255, 255, 0} end
					if string.find(data.name, "Orange") then color = {255, 62, 1} end
					if string.find(data.name, "Pink") then color = {255, 50, 100} end
					if string.find(data.name, "Purple") then color = {159, 43, 104} end
					
					if data.paint == "Wheel" then
						setanimDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
						setanim = "machinic_loop_mechandplayer"
						setflags = 8
						settask = nil
						height = 0.8
					else
						setanimDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
						setanim = "weed_spraybottle_stand_spraying_01_inspector"
						setflags = 16
						settask = nil
						height = 1.5
					end
					
					SetParticleFxNonLoopedColour(color[1] / 255, color[2] / 255, color[3] / 255)
					SetParticleFxNonLoopedAlpha(1.0)
					local spray = StartNetworkedParticleFxNonLoopedAtCoord("scr_wheel_burnout", coords.x, coords.y, coords.z + height, 0.0, 0.0, heading, 0.7, 0.0, 0.0, 0.0)
					
					Wait(3000)
				end
			end)
			
		
					
			while ( not HasAnimDictLoaded( 'anim@amb@business@weed@weed_inspecting_lo_med_hi@' ) ) do
				RequestAnimDict( 'anim@amb@business@weed@weed_inspecting_lo_med_hi@' )
				Citizen.Wait( 1 )
			end
			

			--TaskPlayAnim(ped, 'anim@amb@business@weed@weed_inspecting_lo_med_hi@', 'weed_spraybottle_stand_spraying_01_inspector', 1.0, 1.0, -1, 16, 0, 0, 0, 0 )
			Wait(100)
			spraycan = CreateObject(GetHashKey('ng_proc_spraycan01b'),0.0, 0.0, 0.0,true, false, false)
			AttachEntityToEntity(spraycan, playerPed, GetPedBoneIndex(playerPed, 57005), 0.072, 0.041, -0.06,33.0, 38.0, 0.0, true, true, false, true, 1, true)
			QBCore.Functions.Progressbar("drink_something", "A aplicar "..data.paint.." "..data.finish.." "..data.name, time, false, true, { 
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
				if data.paint == "Primary" then SetVehicleColours(vehicle, data.id, vehSecondaryColour)
				elseif data.paint == "Secondary" then SetVehicleColours(vehicle, vehPrimaryColour, data.id)
				elseif data.paint == "Pearlescent" then SetVehicleExtraColours(vehicle, data.id, vehWheelColour)
				elseif data.paint == "Wheel" then SetVehicleExtraColours(vehicle, originalPearlescentColour, data.id) end

				ClearPedTasks(playerPed)
				spraying = false
				DetachEntity(spraycan)
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Paints:Choose:Paint', data)
				TriggerEvent("QBCore:Notify", "Successo! Pintura aplicada", "success")
				Wait(2000)
				DeleteEntity(spraycan)		

				end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a aplicar pintura!", "error")
				ClearPedTasks(playerPed)
				spraying = false
				DetachEntity(spraycan)
				Wait(2000)
				DeleteEntity(spraycan)
				FreezeEntityPosition(playerPed, false)	
			end)
		end
	end
end)


RegisterNetEvent('jim-mechanic:client:Paints:Check', function()
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
					exports['qb-menu']:openMenu({
						{ header =  GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))).." Cosmético Spray", txt = "", isMenuHeader = true },
						{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Paints:Apply", args = -2 } },
						{ header = "Primária", txt = "", params = { event = "jim-mechanic:client:Paints:Choose", args = "Primary" } },
						{ header = "Secundária", txt = "", params = { event = "jim-mechanic:client:Paints:Choose", args = "Secondary" } },
						{ header = "Perolado", txt = "", params = { event = "jim-mechanic:client:Paints:Choose", args = "Pearlescent" } },
						{ header = "Cor Rodas", txt = "", params = { event = "jim-mechanic:client:Paints:Choose", args = "Wheel" } },
					})
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Paints:Choose', function(data)
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
			exports['qb-menu']:openMenu({
				{ header = data.." Cosmético Spray", txt = "", isMenuHeader = true },
				{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:Paints:Check" } },
				{ header = "Clássico", txt = "", params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = "Classic" } } },
				{ header = "Metálico", txt = "", params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = "Metallic" } } },
				{ header = "Fosco", txt = "", params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = "Matte" } } },
				{ header = "Metais", txt = "", params = { event = "jim-mechanic:client:Paints:Choose:Paint", args = { paint = data, finish = "Metals" } } },
			})
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)


RegisterNetEvent('jim-mechanic:client:Paints:Choose:Paint', function(data)
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed) 
	local validMods = { }
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
			local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(vehicle)
			local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(vehicle)
			if data.paint == "Primary" then colourCheck = vehPrimaryColour end
			if data.paint == "Secondary" then colourCheck = vehSecondaryColour end
			if data.paint == "Pearlescent" then colourCheck = vehPearlescentColour end
			if data.paint == "Wheel" then colourCheck = vehWheelColour end
	
			if data.finish == "Classic" then
				for k, v in pairs(vehicleResprayOptionsClassic) do	
					if colourCheck == v.id then installed = "Atualmente Aplicado" else installed = "" end
					validMods[k] = {
						id = v.id,
						name = v.name,
						txt = installed,
					}
				end
			elseif data.finish == "Metallic" then
				for k, v in pairs(vehicleResprayOptionsMetallic) do	
					if colourCheck == v.id then installed = "Atualmente Aplicado" else installed = "" end
					validMods[k] = {
						id = v.id,
						name = v.name,
						txt = installed,
					}
				end
			elseif data.finish == "Matte" then
				for k, v in pairs(vehicleResprayOptionsMatte) do	
					if colourCheck == v.id then installed = "Atualmente Aplicado" else installed = "" end
					validMods[k] = {
						id = v.id,
						name = v.name,
						txt = installed,
					}
				end
			elseif data.finish == "Metals" then
				for k, v in pairs(vehicleResprayOptionsMetals) do	
					if colourCheck == v.id then installed = "Atualmente Aplicado" else installed = "" end
					validMods[k] = {
						id = v.id,
						name = v.name,
						txt = installed,
					}
				end
			end
		end
		if DoesEntityExist(vehicle) then
			local plate = GetVehicleNumberPlateText(vehicle)
			local PaintMenu = {	{
					isMenuHeader = true,
					header = data.finish.." "..data.paint.." Secção Spray",
					txt = 'Quantidade de Opções: '..#validMods,
				},
				{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:Paints:Choose", args = data.paint } }
			}
			for k,v in pairs(validMods) do
				PaintMenu[#PaintMenu + 1] = { header = v.name, txt = v.txt, params = { event = 'jim-mechanic:client:Paints:Apply', args = { paint = data.paint, id = v.id, name = v.name, finish = data.finish } } }
			end
			exports['qb-menu']:openMenu(PaintMenu)
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)