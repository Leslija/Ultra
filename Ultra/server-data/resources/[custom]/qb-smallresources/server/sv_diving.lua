
QBCore = exports['qb-core']:GetCoreObject()



QBCore.Functions.CreateUseableItem("jerry_can", function(source, item)
    TriggerClientEvent("qb-diving:client:UseJerrycan", source)
end)

QBCore.Functions.CreateUseableItem("diving_gear", function(source, item)
    TriggerClientEvent("qb-diving:client:UseGear", source, true)
end)

-- Commands

QBCore.Commands.Add("mergulho", "Remover equipamento mergulho", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb-diving:client:UseGear", source, false)
end)




RegisterNetEvent('qb-diving:server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
end)
