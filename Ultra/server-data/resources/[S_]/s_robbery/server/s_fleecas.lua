
local QBCore = exports['qb-core']:GetCoreObject()
lastRob = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
}

discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/977568607242448906/XNg5iYsumyJ6_3iiFQGZAJLxKVrR3Nxp7eBNEf8yQWrR52WEZTUqtArtCdkGabQVgOZa',
    ['name'] = 'Ultra',
    ['image'] = 'https://cdn.discordapp.com/attachments/976167165436760125/976183704911241286/2lovelogo.png'
}




RegisterServerEvent('fleecaheist:server:policeAlert')
AddEventHandler('fleecaheist:server:policeAlert', function(coords)
	local src = source
    local players = QBCore.Functions.GetPlayer(src)
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            TriggerClientEvent('fleecaheist:client:policeAlert', players[i], coords)
        end
    end
end)

QBCore.Functions.CreateCallback('fleecaheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local policeCount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['FleecaMain']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('fleecaheist:client:showNotification', src, Strings['need_police'])
    end
end)

QBCore.Functions.CreateCallback('fleecaheist:server:checkTime', function(source, cb, index)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastRob[index]) < Config['FleecaHeist'][index]['nextRob'] and lastRob[index] ~= 0 then
        local seconds = Config['FleecaHeist'][index]['nextRob'] - (os.time() - lastRob[index])
        TriggerClientEvent('fleecaheist:client:showNotification', src, Strings['wait_nextheist'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
        cb(false)
    else
        lastRob[index] = os.time()
        discordLog(player.PlayerData.name ..  ' começou assalto a um banco!')
        TriggerEvent('qb-scoreboard:server:SetActivityBusy', "bancos", true)
        cb(true)
    end
end)


QBCore.Functions.CreateCallback('fleecaheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local playerItem = player.Functions.GetItemByName(item)

    if player and playerItem ~= nil then
        if playerItem then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Não tens o que é necessário', "error")
    end
end)


RegisterServerEvent('vangelicoheist:server:policeAlert')
AddEventHandler('vangelicoheist:server:policeAlert', function(coords)
	local src = source
    local players = QBCore.Functions.GetPlayer(src)
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            TriggerClientEvent('fleecaheist:client:policeAlert', players[i], coords)
        end
    end
end)
RegisterServerEvent('fleecaheist:server:rewardItem')
AddEventHandler('fleecaheist:server:rewardItem', function(reward, count)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        if reward.item ~= nil then
            if count ~= nil then
                player.Functions.AddItem(reward.item, count)
            else
                 player.Functions.AddItem(reward.item, reward.count)
            end
        else
            if count ~= nil then
                 player.Functions.AddItem("black_money", count)
            else
                 player.Functions.AddItem("black_money", reward.count)
            end
        end
    end
end)

RegisterServerEvent('fleecaheist:server:doorSync')
AddEventHandler('fleecaheist:server:doorSync', function(index)
    TriggerClientEvent('fleecaheist:client:doorSync', -1, index)
end)

RegisterServerEvent('fleecaheist:server:lootSync')
AddEventHandler('fleecaheist:server:lootSync', function(index, type, k)
    TriggerClientEvent('fleecaheist:client:lootSync', -1, index, type, k)
end)

RegisterServerEvent('fleecaheist:server:modelSync')
AddEventHandler('fleecaheist:server:modelSync', function(index, k, model)
    TriggerClientEvent('fleecaheist:client:modelSync', -1, index, k, model)
end)

RegisterServerEvent('fleecaheist:server:grabSync')
AddEventHandler('fleecaheist:server:grabSync', function(index, k, model)
    TriggerClientEvent('fleecaheist:client:grabSync', -1, index, k, model)
end)

RegisterServerEvent('fleecaheist:server:resetHeist')
AddEventHandler('fleecaheist:server:resetHeist', function(index)
    TriggerClientEvent('fleecaheist:client:resetHeist', -1, index)
end)

RegisterCommand('fecharbanco', function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if player then
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            TriggerClientEvent('fleecaheist:client:nearBank', src)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Não pertences à Polícia!', "error")
        end
    end
end)

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end