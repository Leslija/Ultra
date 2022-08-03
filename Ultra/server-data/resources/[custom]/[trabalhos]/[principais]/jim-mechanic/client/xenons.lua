
local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Headlights
RegisterNetEvent('jim-mechanic:client:applyXenons', function()
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
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes instalar isto dentro do veículo", "error")
        ClearPedTasks(playerPed)
        return
    end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
			NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
			NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
			local headlightl = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "headlight_l"))
			local headlightr = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "headlight_r"))
			local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
			distanceToL = GetDistanceBetweenCoords(playerpos, headlightl, 1)
			distanceToR = GetDistanceBetweenCoords(playerpos, headlightr, 1)
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if distanceToL <= 1 or distanceToR <= 1 then
						if tostring(vehProps.modXenon) ~= "false" then
							TriggerEvent("QBCore:Notify", "Faróis Xenon já instalados", "error")
						else
						playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 35000)
						TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
							Wait(1000)
							FreezeEntityPosition(playerPed, true)
							time = math.random(3000,7000)
							QBCore.Functions.Progressbar("accepted_key", "A instalar xenons", time, false, true, {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}, {
								animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								anim = "machinic_loop_mechandplayer",
								flags = 8,
							}, {}, {}, function() -- Done
								SetVehicleModKit(vehicle, 0)
								ToggleVehicleMod(vehicle, 22, true)
								ClearPedTasks(playerPed)
								FreezeEntityPosition(playerPed, false)
								CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
								TriggerServerEvent('updateVehicle', CurrentVehicleData)
								TriggerServerEvent('jim-mechanic:server:removeXenon')
								TriggerEvent("QBCore:Notify", "Successo! Faróis Xenon Instalados", "success")
							end, function() -- Cancel
								TriggerEvent("QBCore:Notify", "Falhou a instalar Xenons!", "error")
								ClearPedTasks(playerPed)
								FreezeEntityPosition(playerPed, false)								
							end)
						end
					else	
						TriggerEvent("QBCore:Notify", "Falhou a instalar Faróis Xenons!", "error")	
					end
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")	
	end
end)

RegisterNetEvent('jim-mechanic:client:giveXenon')
AddEventHandler('jim-mechanic:client:giveXenon', function()	
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
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
		if Config.isVehicleOwned and not owned then
			TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
			return
		else
			SetVehicleModKit(vehicle, 0)
			local headlightl = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "headlight_l"))
			local headlightr = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "headlight_r"))
			local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
			distanceToL = GetDistanceBetweenCoords(playerpos, headlightl, 1)
			distanceToR = GetDistanceBetweenCoords(playerpos, headlightr, 1)
			if distanceToR <= 1 or distanceToL <= 1 then
				TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
				Wait(1000)
				QBCore.Functions.Progressbar("accepted_key", "A remover xenons", 8000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
					anim = "machinic_loop_mechandplayer",
					flags = 8,
				}, {}, {}, function() -- Done
					SetVehicleModKit(vehicle, 0)
					ToggleVehicleMod(vehicle, 22, false)
					SetVehicleHeadlightsColour(vehicle, 0)
					--SetVehicleDoorShut(vehicle, 4, false)
					ClearPedTasks(playerPed)
					FreezeEntityPosition(playerPed, false)
					--SetVehicleEngineOn(vehicle, true, true)
					CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
					TriggerServerEvent('updateVehicle', CurrentVehicleData)
					TriggerServerEvent('jim-mechanic:server:giveXenon')
					TriggerEvent("QBCore:Notify", "Successo! Xenons Removidos", "success")
				end, function() -- Cancel
					TriggerEvent("QBCore:Notify", "Falhou a remover Xenons!", "error")
					ClearPedTasks(playerPed)								
				end)	
			else
				TriggerEvent("QBCore:Notify", "Tens que estar mais próximo dos faróis", "error")
			end
		end
	end, GetVehicleNumberPlateText(vehicle))
end)

RegisterNetEvent('jim-mechanic:client:neonMenu', function()
    local playerPed	= PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed)
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				local vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
				local plate = GetVehicleNumberPlateText(vehicle)
				local bike = false
				--local xenon = false
				if IsThisModelABike(GetEntityModel(vehicle)) then bike = true end
				if IsThisModelAQuadbike(GetEntityModel(vehicle)) then bike = true end
				if vehProps.modXenon then xenon = true end
				
				if bike and not xenon then
					TriggerEvent("QBCore:Notify", "Nenhuma opção disponivel para este item", "error")
					return
				end
					local NeonMenu = {
							{ isMenuHeader = true, header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Controlo de Luzes', },
							{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:applyNeonColor", args = 14 } } }

					if not bike then NeonMenu[#NeonMenu + 1] = { header = "Underglow Lighting Controls", txt = "", params = { event = "jim-mechanic:client:neonToggleMenu", } } end
					if not bike then NeonMenu[#NeonMenu + 1] = { header = "Underglow Color Controls", txt = "", params = { event = "jim-mechanic:client:neonColorMenu", } } end
					if xenon then NeonMenu[#NeonMenu + 1] = { header = "Xenon Headlight Controls", txt = "", params = { event = "jim-mechanic:client:xenonMenu", } } end

						
						exports['qb-menu']:openMenu(NeonMenu)
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		QBCore.Functions.Notify("Precisas de estar dentro do veículo para usar isto", "error", 3500)
    end
end)

RegisterNetEvent('jim-mechanic:client:applyNeonPostion', function(args) 
    local args = tonumber(args)
    local playerPed	= PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed)
    TriggerEvent("jim-mechanic:client:neonToggleMenu")
	SetVehicleEngineOn(vehicle, true, true)
	if args == 1 then
        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)
    elseif args == 2 then 
        SetVehicleNeonLightEnabled(vehicle, 0, false)
        SetVehicleNeonLightEnabled(vehicle, 1, false)
        SetVehicleNeonLightEnabled(vehicle, 2, false)
        SetVehicleNeonLightEnabled(vehicle, 3, false)
	elseif args == 3 then 
		if IsVehicleNeonLightEnabled(vehicle, 2) then SetVehicleNeonLightEnabled(vehicle, 2, false)
		elseif not IsVehicleNeonLightEnabled(vehicle, 2) then SetVehicleNeonLightEnabled(vehicle, 2, true) end
	elseif args == 4 then 
		if IsVehicleNeonLightEnabled(vehicle, 1) then SetVehicleNeonLightEnabled(vehicle, 1, false)
		elseif not IsVehicleNeonLightEnabled(vehicle, 1) then SetVehicleNeonLightEnabled(vehicle, 1, true) end
    elseif args == 5 then 
		if IsVehicleNeonLightEnabled(vehicle, 3) then SetVehicleNeonLightEnabled(vehicle, 3, false)
		elseif not IsVehicleNeonLightEnabled(vehicle, 3) then SetVehicleNeonLightEnabled(vehicle, 3, true) end
    elseif args == 6 then 
		if IsVehicleNeonLightEnabled(vehicle, 0) then SetVehicleNeonLightEnabled(vehicle, 0, false)
		elseif not IsVehicleNeonLightEnabled(vehicle, 0) then SetVehicleNeonLightEnabled(vehicle, 0, true) end
    end
end)

RegisterNetEvent('jim-mechanic:client:applyNeonColor', function(data) 
    local args = tonumber(args)
    local playerPed	= PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed)
	if data == 14 then
        exports['qb-menu']:closeMenu()
        CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
        TriggerServerEvent('updateVehicle', CurrentVehicleData)
	else
		TriggerEvent("jim-mechanic:client:neonColorMenu")
		SetVehicleEngineOn(vehicle, true, false)
		SetVehicleNeonLightsColour(vehicle, data.R, data.G, data.B)
	end
end)

RegisterNetEvent('jim-mechanic:client:applyCustomColor', function(R,G,B)
	local R = tonumber(R)
	local G = tonumber(G)
	local B = tonumber(B)
    TriggerEvent("jim-mechanic:client:neonColorMenu")    
	local playerPed	= PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed)
	SetVehicleNeonLightsColour(vehicle, R, G, B)
end)

RegisterNetEvent('jim-mechanic:client:neonCustomMenu', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Escolhe Custom RBG",
        submitText = "APLICAR",
        inputs = {
            { type = 'number', isRequired = true, name = 'Red', text = 'R' },
            { type = 'number', isRequired = true, name = 'Green', text = 'G' },
            { type = 'number', isRequired = true, name = 'Blue', text = 'B' }
        }
    })
    if dialog then
        if not dialog.Red or not dialog.Green or not dialog.Blue then return end
        TriggerEvent('jim-mechanic:client:applyCustomColor', dialog.Red, dialog.Green, dialog.Blue)
    end
end)

RegisterNetEvent('jim-mechanic:client:neonToggleMenu', function()
    exports['qb-menu']:openMenu({
		{ header = "Neon Underglow", txt = "Controlo Iluminação Néon", isMenuHeader = true },
        { header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:neonMenu", } },
        { header = "Toggle All ON", txt = "", params = { event = "jim-mechanic:client:applyNeonPostion", args = 1 } },
        { header = "Toggle All OFF", txt = "", params = { event = "jim-mechanic:client:applyNeonPostion", args = 2 } },
        { header = "Toggle Front", txt = "", params = { event = "jim-mechanic:client:applyNeonPostion", args = 3 } },
        { header = "Toggle Right", txt = "", params = { event = "jim-mechanic:client:applyNeonPostion", args = 4 } },
        { header = "Toggle Back", txt = "", params = { event = "jim-mechanic:client:applyNeonPostion", args = 5 } },
        { header = "Toggle Left", txt = "", params = { event = "jim-mechanic:client:applyNeonPostion", args = 6 } },
    })
end)


RegisterNetEvent('jim-mechanic:client:neonColorMenu', function()
    exports['qb-menu']:openMenu({
		{ header = "Neon Underglow", txt = "Mudar cor Underglow", isMenuHeader = true },
        { header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:neonMenu", } },
		{ header = "CUSTOM RBG", txt = "", params = { event = "jim-mechanic:client:neonCustomMenu", } },
        { header = "White", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 255, G = 255, B = 255 } } },
        { header = "Blue", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 2, G = 21, B = 255 } } },
        { header = "Electric Blue", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 3, G = 83, B = 255 } } },
        { header = "Mint Green", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 0, G = 255, B = 140 } } },
        { header = "Lime Green", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 94, G = 255, B = 1 } } },
        { header = "Yellow", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 255, G = 255, B = 0 } } },
        { header = "Golden Shower", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 255, G = 150, B = 0 } } },
        { header = "Orange", txt = "",  params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 255, G = 62, B = 0 } } },
        { header = "Red", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 255, G = 1, B = 1 } } },
        { header = "Pony Pink", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 255, G = 50, B = 100 } } },
        { header = "Hot Pink", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 255, G = 5, B = 190 } } },
        { header = "Purple", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 35, G = 1, B = 255 } } },
        { header = "Blacklight", txt = "", params = { event = "jim-mechanic:client:applyNeonColor", args = { R = 15, G = 3, B = 255 } } },
    })
end)

RegisterNetEvent('jim-mechanic:client:applyXenonColor', function(args) 
    local args = tonumber(args)
    local playerPed	= PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	SetVehicleModKit(vehicle, 0)
    TriggerEvent("jim-mechanic:client:xenonMenu")
	SetVehicleEngineOn(vehicle, true, false)
	if args == 1 then 
		SetVehicleHeadlightsColour(vehicle, 0)
    elseif args == 2 then 
		SetVehicleHeadlightsColour(vehicle, -1)      
    elseif args == 3 then 
		SetVehicleHeadlightsColour(vehicle, 1)    
    elseif args == 4 then 
		SetVehicleHeadlightsColour(vehicle, 2)    
    elseif args == 5 then
		SetVehicleHeadlightsColour(vehicle, 3)
	elseif args == 6 then
		SetVehicleHeadlightsColour(vehicle, 4)    
	elseif args == 7 then
		SetVehicleHeadlightsColour(vehicle, 5)    
	elseif args == 8 then
		SetVehicleHeadlightsColour(vehicle, 6)    
	elseif args == 9 then
		SetVehicleHeadlightsColour(vehicle, 7)    
	elseif args == 10 then
		SetVehicleHeadlightsColour(vehicle, 8)    
	elseif args == 11 then
		SetVehicleHeadlightsColour(vehicle, 9)   
	elseif args == 12 then
		SetVehicleHeadlightsColour(vehicle, 10)    
	elseif args == 13 then
		SetVehicleHeadlightsColour(vehicle, 11)    
	elseif args == 14 then
		SetVehicleHeadlightsColour(vehicle, 12)    
    else
        exports['qb-menu']:closeMenu()
        CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
        TriggerServerEvent('updateVehicle', CurrentVehicleData)
    end
end)

RegisterNetEvent('jim-mechanic:client:xenonMenu', function()
	local playerPed	= PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	SetVehicleModKit(vehicle, 0)
	vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
	if tostring(vehProps.modXenon) == "false" then
		TriggerEvent("QBCore:Notify", "Faróis Xenons não instalados", "error")
	else
		exports['qb-menu']:openMenu({
			{ header = "Xenon Controls", txt = "Ajustar cor dos faróis do veículo", isMenuHeader = true },
			{ header = "", txt = "⬅ Voltar", params = { event = "jim-mechanic:client:neonMenu", args = 14 } },
			{ header = "Stock", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 1 } },
			{ header = "Ice blue", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 2 } },
			{ header = "Blue", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 3 } },
			{ header = "Electric Blue", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 4 } },
			{ header = "Mint Green", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 5 } },
			{ header = "Lime Green", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 6 } },
			{ header = "Yellow", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 7 } },
			{ header = "Golden", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 8 } },
			{ header = "Orange", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 9 } },
			{ header = "Red", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 10 } },
			{ header = "Pony Pink ", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 11 } },
			{ header = "Hot Pink", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 12 } },
			{ header = "Purple", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 13 } },
			{ header = "Blacklight", txt = "", params = { event = "jim-mechanic:client:applyXenonColor", args = 14 } },
		})
	end
end)