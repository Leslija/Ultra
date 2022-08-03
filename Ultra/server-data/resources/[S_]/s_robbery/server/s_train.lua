local QBCore = exports['qb-core']:GetCoreObject()
local lastrob = 0
local start = false
discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/977568122053726259/6r2Whd_NzPOhTX10XMOrgJaZ15ptjctsCK_BXIrFHLs3ElwclPggzJy6fGYpzNm04yzy',
    ['name'] = 'Ultra',
    ['image'] = 'https://cdn.discordapp.com/attachments/976167165436760125/976183704911241286/2lovelogo.png'
}

RegisterServerEvent('comboioestado')
AddEventHandler('comboioestado', function()
    TriggerEvent('qs-scoreboard:server:SetActivityBusy', "comboios", true)
    Citizen.Wait(2700000)
    TriggerEvent('qs-scoreboard:server:SetActivityBusy', "comboios", false)
end)

QBCore.Functions.CreateCallback('trainheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = QBCore.Functions.GetPlayer(src)
    local policeCount = 0

    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['TrainHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('QBCore:Notify', src, Strings['need_police'], "error")
    end
end)

QBCore.Functions.CreateCallback('trainheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['TrainHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['TrainHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(player.PlayerData.name, ' começou o assalto aos comboios!')
        TriggerEvent('qb-scoreboard:server:SetActivityBusy', "comboios", true)
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('trainheist:server:hasItem', function(source, cb, item)
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

RegisterServerEvent('comboioheist:server:policeAlert')
AddEventHandler('comboioheist:server:policeAlert', function(data, customcoords)

end)

RegisterServerEvent('trainheist:server:rewardItems')
AddEventHandler('trainheist:server:rewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        player.Functions.AddItem(Config['TrainHeist']['reward']['itemName'], Config['TrainHeist']['reward']['grabCount'])
    end
end)


RegisterServerEvent('trainheist:server:containerSync')
AddEventHandler('trainheist:server:containerSync', function(coords, rotation)
    TriggerClientEvent('trainheist:client:containerSync', -1, coords, rotation)
end)

RegisterServerEvent('trainheist:server:objectSync')
AddEventHandler('trainheist:server:objectSync', function(e)
    TriggerClientEvent('trainheist:client:objectSync', -1, e)
end)

RegisterServerEvent('trainheist:server:trainLoop')
AddEventHandler('trainheist:server:trainLoop', function()
    TriggerClientEvent('trainheist:client:trainLoop', -1)
end)

RegisterServerEvent('trainheist:server:lockSync')
AddEventHandler('trainheist:server:lockSync', function(index)
    TriggerClientEvent('trainheist:client:lockSync', -1, index)
end)

RegisterServerEvent('trainheist:server:grabSync')
AddEventHandler('trainheist:server:grabSync', function(index, index2)
    TriggerClientEvent('trainheist:client:grabSync', -1, index, index2)
end)

RegisterServerEvent('trainheist:server:resetHeist')
AddEventHandler('trainheist:server:resetHeist', function()
    if not start then return end
    start = false
    TriggerClientEvent('trainheist:client:resetHeist', -1)
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