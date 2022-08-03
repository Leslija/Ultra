QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()
local lastrob = 0
local start = false
discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/977568532990681170/aEwDKwf7nXn4ToJJ1aYQR4hAy15TCRjNnjOhSV3puia0Hw8_JoDYxFQbUDAAE073GfIt',
    ['name'] = 'Ultra',
    ['image'] = 'https://cdn.discordapp.com/attachments/976167165436760125/976183704911241286/2lovelogo.png'
}

RegisterServerEvent('estadojoalharia')
AddEventHandler('estadojoalharia', function()
    TriggerEvent('qs-scoreboard:server:SetActivityBusy', "joalharia", true)
    Citizen.Wait(1800000)
    TriggerEvent('qs-scoreboard:server:SetActivityBusy', "joalharia", false)
end)

QBCore.Functions.CreateUseableItem(Config['VangelicoHeist']['gasMask']['itemName'], function(source)
	local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        TriggerClientEvent('vangelicoheist:client:wearMask', src)
		player.Functions.RemoveItem(Config['VangelicoHeist']['gasMask']['itemName'], 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config['VangelicoHeist']['gasMask']['itemName']], "remove")
    end
end)

QBCore.Functions.CreateCallback('vangelicoheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = QBCore.Functions.GetPlayer(src)
    local policeCount = 0

    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['VangelicoHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('vangelicoheist:client:showNotification', src, Strings['need_police'])
    end
end)

QBCore.Functions.CreateCallback('vangelicoheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['VangelicoHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['VangelicoHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(player.PlayerData.name, ' começou o assalto á Joalharia!')
        TriggerEvent('qb-scoreboard:server:SetActivityBusy', "joalharia", true)
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('vangelicoheist:server:hasItem', function(source, cb, item)
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
            TriggerClientEvent('vangelicoheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('vangelicoheist:server:rewardItem')
AddEventHandler('vangelicoheist:server:rewardItem', function(item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local whitelistItems = {}

    if player then
        for k, v in pairs(Config['VangelicoHeist']['smashRewards']) do
            whitelistItems[v['item']] = true
        end

        for k, v in pairs(Config['VangelicoInside']['glassCutting']['rewards']) do
            whitelistItems[v['item']] = true
        end

        for k, v in pairs(Config['VangelicoInside']['painting']) do
            whitelistItems[v['rewardItem']] = true
        end

        if whitelistItems[item] then
            player.Functions.AddItem(item, 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
        else
            TriggerClientEvent('QBCore:Notify', src, 'Add item exploit playerID: ' .. src .. ' name: ' .. player.PlayerData.name, "error")
        end
    end
end)



RegisterCommand('pdvangelico', function(source, args)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if player then
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            if start then
                TriggerClientEvent('vangelicoheist:client:resetHeist', -1)
                start = false
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'Não pertences à Polícia!', "error")
        end
    end
end)

RegisterServerEvent('vangelicoheist:server:startGas')
AddEventHandler('vangelicoheist:server:startGas', function()
    TriggerClientEvent('vangelicoheist:client:startGas', -1)
end)

RegisterServerEvent('vangelicoheist:server:insideLoop')
AddEventHandler('vangelicoheist:server:insideLoop', function()
    TriggerClientEvent('vangelicoheist:client:insideLoop', -1)
end)

RegisterServerEvent('vangelicoheist:server:lootSync')
AddEventHandler('vangelicoheist:server:lootSync', function(type, index)
    TriggerClientEvent('vangelicoheist:client:lootSync', -1, type, index)
end)

RegisterServerEvent('vangelicoheist:server:globalObject')
AddEventHandler('vangelicoheist:server:globalObject', function(obj, random)
    TriggerClientEvent('vangelicoheist:client:globalObject', -1, obj, random)
end)

RegisterServerEvent('vangelicoheist:server:smashSync')
AddEventHandler('vangelicoheist:server:smashSync', function(sceneConfig)
    TriggerClientEvent('vangelicoheist:client:smashSync', -1, sceneConfig)
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