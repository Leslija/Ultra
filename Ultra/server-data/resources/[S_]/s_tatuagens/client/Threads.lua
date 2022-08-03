dist_marker = 10000.0
next_marker = nil
next_dist = 1000.0
dist_ped = 2.0

CreateThread(function()
    CreateIcons()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local shortest_dist = 10000.0
        local store_found = false
        
        for i, k in pairs(tattoosShops) do
            dist_marker = #(pos - vec3(k.coords.x, k.coords.y, k.coords.z))
            if dist_marker < dist_ped and dist_marker < shortest_dist then

                if next_marker == nil then
                    EnableBlip()
                end

                next_marker = k
                next_dist = dist_marker
                shortest_dist = dist_marker   
                store_found = true   
            end
        end

        if not store_found then
            dist_marker = 10000.0
            next_marker = nil
            next_dist = 1000.0
        end
        Wait(1500)
    end
end)

function EnableBlip()
    CreateThread(function()
        while true do
            if IsPauseMenuActive() then
                CloseNuiTattos()
            elseif next_marker == nil then
                CloseNuiTattos()
                return 
            end

            local dist = next_dist
            if dist < dist_ped then
                if not opened then
                    DrawText3Ds(next_marker.coords.x, next_marker.coords.y, next_marker.coords.z + 0.2, 'Pressiona ~b~E~w~ para ver a lista de tatuagens.')
                    --DisplayHelpText(Texts.KeyNotifyOpenStore)
                end
                DrawMarker(20, next_marker.coords.x, next_marker.coords.y, next_marker.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false, true, false, false, false)
                --DrawMarker(27, next_marker.coords.x, next_marker.coords.y, next_marker.coords.z-0.9, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 0, 255, 0, 50, false, false, 2, "GolfPutting", nil, false)
            end
            Wait(0)
        end
    end)
end

-- Reset the tattoos if they disappear from the body
CreateThread(function()
    while true do
        if PlayerJoin then
            if not opened then
                local ped = PlayerPedId()
                ClearPedDecorations(ped)
                for i, k in pairs(my_tattoos) do
                    ApplyPedOverlay(ped, GetHashKey(k.dlc), GetHashKey(k.hash))
                end
            end

            if #my_tattoos == 0 then
                if PlayerCheck < 3 then
                    PlayerCheck = PlayerCheck + 1
                    TriggerServerEvent("qs-tattoos:GetTattoos")
                end
            end
        end
        Wait(5000)
    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end