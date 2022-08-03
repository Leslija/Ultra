local QBCore = exports['qb-core']:GetCoreObject()
local lastNapping = 0
local queryRoom = false

discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/977568390203998218/nqmrjQjMcirA0rsRuC2vfImRf3QXDaYacdPRHu300sWWpCcd6MIdeR1X3MGOVuZH0b9H',
    ['name'] = 'Ultra',
    ['image'] = 'https://cdn.discordapp.com/attachments/976167165436760125/976183704911241286/2lovelogo.png'
}

RegisterServerEvent('raptossim')
AddEventHandler('raptossim', function()
    TriggerEvent('qs-scoreboard:server:SetActivityBusy', "raptos", true)
    Citizen.Wait(900000)
    TriggerEvent('qs-scoreboard:server:SetActivityBusy', "raptos", false)
end)


TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

QBCore.Functions.CreateCallback('kidnapping:server:checkQueryRoom', function(source, cb)
    cb(queryRoom)
end)

RegisterServerEvent('kidnapping:server:syncQueryRoom')
AddEventHandler('kidnapping:server:syncQueryRoom', function()
    queryRoom = not queryRoom
end)

QBCore.Functions.CreateCallback('kidnapping:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastNapping) < Config['Kidnapping']['nextNapping'] and lastNapping ~= 0 then
        local seconds = Config['Kidnapping']['nextNapping'] - (os.time() - lastNapping)
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextnapping'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
        cb(false)
    else
        lastNapping = os.time()
        discordLog(player.PlayerData.name ..  ' -  começou um rapto!')
        TriggerEvent('qb-scoreboard:server:SetActivityBusy', "raptos", true)
        cb(true)
        

    end
end)

RegisterServerEvent('kidnapping:server:giveVideoRecord')
AddEventHandler('kidnapping:server:giveVideoRecord', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        player.Functions.AddItem(Config['Kidnapping']['videoRecordItem'], 1)
    end
end)

RegisterServerEvent('kidnapping:server:finish')
AddEventHandler('kidnapping:server:finish', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        local count = player.Functions.GetItemByName(Config['Kidnapping']['videoRecordItem'])
        if count ~= nil and count > 0 then -- Crash, drop, etc. that may occur after taking a video recording in the previous job. I make him sell all the video recordings on it for situations like.
            player.Functions.removeItem(Config['Kidnapping']['videoRecordItem'], count)
            player.Functions.addItem("black_money", count * Config['Kidnapping']['rewardCash'])
            discordLog(player.PlayerData.name .. ' Ganhou ' .. count * Config['Kidnapping']['rewardCash'] .. '€ a vender vídeo com informações!')
        end
    end
end)

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "RAPTOS",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end