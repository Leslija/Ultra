RegisterServerEvent("aspect_badge:identify")
AddEventHandler("aspect_badge:identify", function(identity)
    local src = source
    TriggerClientEvent("aspect_badge:identify", -1, identity, GetEntityCoords(GetPlayerPed(src)))
end)

function SetIdentification(source, identity)
    if (source == -1) then return end
    TriggerEvent("aspect_badge:set", source, identity)
end

exports("SetIdentification", SetIdentification)