local QBCore = exports['qb-core']:GetCoreObject()
local lastrob = 0
local start = false
discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/977568889854652456/L9Cf-_pTElYMjzEBTyZ1gdZf4LLDSDjq4eP_419TFfnLTyP1akeZRHk_ToptpU1I7LiS',
    ['name'] = 'Ultra',
    ['image'] = 'https://cdn.discordapp.com/attachments/976167165436760125/976183704911241286/2lovelogo.png'
}


QBCore.Functions.CreateCallback('artheist:server:checkRobTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['ArtHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['ArtHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('esx:showNotification', source, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
        cb(false)

    else
        lastrob = os.time()
        start = true
        discordLog(QBCore.Functions.GetIdentifier(player),  ' ```Iniciou assalto a quadros de arte!```')
        TriggerEvent('qb-scoreboard:server:SetActivityBusy', "arte", true)
        cb(true)
    end
end)

RegisterServerEvent('artheist:server:policeAlert')
AddEventHandler('artheist:server:policeAlert', function(coords)
	local src = source
    local players = QBCore.Functions.GetPlayers(src)
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) then
            TriggerClientEvent('pacificheist:client:policeAlert', players[i], coords)
        end
    end
end)

--[[RegisterServerEvent('arteestado')
AddEventHandler('arteestado', function()
    TriggerEvent('qs-scoreboard:server:SetActivityBusy', "arte", true)
    Citizen.Wait(1800000)
    TriggerEvent('qs-scoreboard:server:SetActivityBusy', "arte", false)
end)--]]


RegisterServerEvent('artheist:server:syncHeistStart')
AddEventHandler('artheist:server:syncHeistStart', function()
    TriggerClientEvent('artheist:client:syncHeistStart', -1)
end)

RegisterServerEvent('artheist:server:syncPainting')
AddEventHandler('artheist:server:syncPainting', function(x)
    TriggerClientEvent('artheist:client:syncPainting', -1, x)
end)

RegisterServerEvent('artheist:server:syncAllPainting')
AddEventHandler('artheist:server:syncAllPainting', function()
    TriggerClientEvent('artheist:client:syncAllPainting', -1)
end)

RegisterServerEvent('artheist:server:rewardItem')
AddEventHandler('artheist:server:rewardItem', function(scene)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local item = scene['rewardItem']

    if player then
        player.Functions.AddItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
    end
end)

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "ARTE",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end