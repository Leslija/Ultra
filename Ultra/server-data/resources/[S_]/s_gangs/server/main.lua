local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("qb-gangs:server:FetchConfig", function(source, cb)
    cb(json.decode(LoadResourceFile(GetCurrentResourceName(), "config.json")))
end)

QBCore.Commands.Add("criarorg", "Criar uma organização (garagem e cofre)", {{name = "org", help = "Nome"}, {name = "label", help = "Nome Completo"}}, true, function(source, args)
    name = args[1]
    table.remove(args, 1)
    label = table.concat(args, " ")
    
    TriggerClientEvent("qb-gangs:client:BeginGangCreation", source, name, label)
end, "admin")

RegisterServerEvent("qb-gangs:server:creategang", function(newGang, gangName, gangLabel)
  --  local permission = QBCore.Functions.GetPermission(source)

    if QBCore.Functions.HasPermission(source, 'god') or QBCore.Functions.HasPermission(source, 'admin') then
        local gangConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), "config.json"))
        gangConfig[gangName] = newGang

        local gangs = json.decode(LoadResourceFile(GetCurrentResourceName(), "gangs.json"))
        gangs[gangName] = {
            label = gangLabel
        }

        SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(gangConfig), -1)
        TriggerClientEvent("qb-gangs:client:UpdateGangs", -1, gangConfig)

        SaveResourceFile(GetCurrentResourceName(), "gangs.json", json.encode(gangs), -1)
        TriggerClientEvent("QBCore:Client:UpdateGangs", -1, gangs)
        TriggerEvent("QBCore:Server:UpdateGangs", gangs)

        TriggerClientEvent("QBCore:Notify", source, "Org: "..gangName.." criada com sucesso", "success")
    else
        QBCore.Functions.Kick(source, "Tentou criar uma gang")
    end
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

QBCore.Commands.Add("convidarorg", "Convidar jogador para a org", {{name = "ID", help = "Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local gang = Player.PlayerData.gang.name

    if gang == "none" then 
        TriggerClientEvent("QBCore:Notify", source, "Não estás em nenhuma org", "error")
        return 
    end
    if Config["GangLeaders"][gang] ~= nil and has_value(Config["GangLeaders"][gang], Player.PlayerData.citizenid) then
        local id = tonumber(args[1])
        if id == source then return end

        local OtherPlayer = QBCore.Functions.GetPlayer(id)
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetGang(gang)
            TriggerClientEvent("QBCore:Notify", source, ("%s foi convidado para a tua org"):format(GetPlayerName(id)))
            TriggerClientEvent("QBCore:Notify", id, ("%s convidou-te para %s"):format(GetPlayerName(source), QBCore.Shared.Gangs[gang].label))
        else
            TriggerClientEvent("QBCore:Notify", source, "Este jogador não está online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Não és chefe desta organização", "error")
    end
end)

QBCore.Commands.Add("removerorg", "Remover jogador da organização", {{name = "ID", help = "Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local gang = Player.PlayerData.gang.name

    if gang == "none" then 
        return TriggerClientEvent("QBCore:Notify", source, "Não estás em nenhuma org", "error")
    end
    if Config["GangLeaders"][gang] ~= nil and has_value(Config["GangLeaders"][gang], Player.PlayerData.citizenid) then
        local id = tonumber(args[1])
        if id == source then return end

        local OtherPlayer = QBCore.Functions.GetPlayer(id)
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetGang("none")
            TriggerClientEvent("QBCore:Notify", source, ("%s foi removido da tua org"):format(GetPlayerName(id)))
            TriggerClientEvent("QBCore:Notify", id, ("%s removeu-te de %s"):format(GetPlayerName(source), QBCore.Shared.Gangs[gang].label))
        else
            TriggerClientEvent("QBCore:Notify", source, "Este jogador não está online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Não és chefe desta organização", "error")
    end
end)
