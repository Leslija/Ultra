ESX = nil
QBCore = nil
local PlayerJob = nil
PlayerData = {}

if Config.Framework == 'ESX' then
    TriggerEvent(Config.getSharedObject, function(obj) ESX = obj end)
elseif Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

local dbTerritory = {}
local territoryCount = {}
local playerInfo = {}

---### CONTROLO AREA ####
if Config.Framework == 'ESX' then
RegisterServerEvent('s_territories:server:comecarcontrolo')
AddEventHandler('s_territories:server:comecarcontrolo', function(name)
    if (not Config.Territories[name].control.enabled or dbTerritory[name] == nil) then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    if (dbTerritory[name].gang == xPlayer.job.name) then
        local notification = { msg = Translations['already_owned'], type = "error",}
        TriggerClientEvent('safky:client:shownotification', source, notification)
        return
    elseif (territoryCount[xPlayer.job.name] ~= nil and territoryCount[xPlayer.job.name].count >= Config.MaxTerritories) then
        local notification = { msg = Translations['max_territories'], type = "error",}
        TriggerClientEvent('safky:client:shownotification', source, notification)
        return
    elseif (dbTerritory[name].capturing) then
        local notification = { msg = Translations['already_attempt'], type = "error",}
        TriggerClientEvent('safky:client:shownotification', source, notification)
        return
    end

    dbTerritory[name].capturing = true
    playerInfo[source] = name
    TriggerClientEvent('chat:addMessage', -1, {color = {0, 248, 185}, multiline = true, args = {Translations['server_name'], Translations['attempt_started']..Config.Territories[name].label}})
    TriggerClientEvent('s_territories:client:capturar', source)
    discordLog('Player: '..GetPlayerName(source)..'\n Start attempt to control: '..Config.Territories[name].label)
end)

RegisterServerEvent('s_territories:server:controlofalhado')
AddEventHandler('s_territories:server:controlofalhado', function(name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local label = Config.Territories[name].label
    dbTerritory[name].capturing = false
    discordLog('Player: '..GetPlayerName(xPlayer)..'\n Failed to control: '..Config.Territories[name].label)
    if (xPlayer == nil) then
        TriggerClientEvent('chat:addMessage', -1, {color = {0, 248, 185}, multiline = true, args = {Translations['server_name'], Translations['failed_attempt']..label}})
    else
        TriggerClientEvent('chat:addMessage', -1, {color = {0, 248, 185}, multiline = true, args = {Translations['server_name'], Translations['failed_attempt']..label}})
    end
    
end)

RegisterServerEvent('s_territories:server:updateowner')
AddEventHandler('s_territories:server:updateowner', function(name)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (territoryCount[dbTerritory[name].gang] ~= nil and dbTerritory[name] ~= nil) then
        territoryCount[dbTerritory[name].gang].count = territoryCount[dbTerritory[name].gang].count - 1
        dbTerritory[name].gang = xPlayer.job.name

        if (territoryCount[xPlayer.job.name] ~= nil) then
            territoryCount[xPlayer.job.name] = territoryCount[xPlayer.job.name].count + 1
        else
            territoryCount[xPlayer.job.name] = {}
            territoryCount[xPlayer.job.name].count = 1
        end

        TriggerClientEvent('chat:addMessage', -1, {color = {0, 248, 185}, multiline = true, args = {Translations['server_name'], Config.Territories[name].label..Translations['success_attempt']}})
        MySQL.Async.execute('UPDATE s_territories SET gang = @gang WHERE name = @name', {		
            ['@name'] = name,
            ['@gang'] = xPlayer.job.name
        }) 
        discordLog('Player: '..GetPlayerName(source)..'\n Job: '..xPlayer.job.name..'\n Controled with success: '..Config.Territories[name].label)
    end
end)

-------- #####COFRE######## ------
RegisterServerEvent('s_territories:server:openstash')
AddEventHandler('s_territories:server:openstash', function(name)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (dbTerritory[name].gang == xPlayer.job.name) then
        local amount = dbTerritory[name].amount
        local data = {name = name, amount = amount}
        TriggerClientEvent('s_territories:client:cofreautorizado', source, data)
        return
    end
    local notification = { msg = Translations['permissions'], type = "error",}
    TriggerClientEvent('safky:client:shownotification', source, notification)
end)

RegisterServerEvent('s_territories:server:stashreward')
AddEventHandler('s_territories:server:stashreward', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if Config.PaymentType == 'money' then
        xPlayer.addMoney(data.retirado)
    elseif Config.PaymentType == 'black_money' then
        xPlayer.addAccountMoney('black_money', data.retirado)
    elseif Config.PaymentType == 'item' then
        xPlayer.addInventoryItem(Config.PaymentItem, data.retirado)
    end
    MySQL.Async.execute('UPDATE s_territories SET amount = @final WHERE name = @name', {		
            ['@name'] = data.name,
            ['@final'] = data.final
        })
    dbTerritory[data.name].amount = data.final
    discordLog('Player: '..GetPlayerName(src)..' (Removed money from stash)\n Location: '..data.name..'\n Removed: '..data.retirado..'€\n Balance Now: '..data.final)
end)


---########VENDA DE DROGAS

RegisterServerEvent('s_territories:server:venderdroga2')
AddEventHandler('s_territories:server:venderdroga2', function(data)
    local name = data.data
    local item = Config.Territories[data.data].selldrug.item
    local itemlabel = Config.Territories[data.data].selldrug.label
    local quantity = Config.Territories[data.data].selldrug.quantity
    local price = Config.Territories[data.data].selldrug.price
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local droga = xPlayer.getInventoryItem(item) and xPlayer.getInventoryItem(item).count
    if xPlayer and droga ~= nil then
        if droga >= quantity then
            xPlayer.removeInventoryItem(item, quantity)
            TriggerClientEvent("s_territories:client:venderdrogaprocesso", source, name)
        else
            local notification = { msg = Translations['dont_have'], type = "error",}
            TriggerClientEvent('safky:client:shownotification', source, notification)
        end
    else
    end
end)

RegisterServerEvent('s_territories:server:sellingreward')
AddEventHandler('s_territories:server:sellingreward', function(data)
    local name = data
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local quantity = Config.Territories[data].selldrug.quantity
    local price = Config.Territories[data].selldrug.price
    local pagamento = quantity*price
    --PAGA
    if Config.PaymentTypeDrugs == 'money' then
        xPlayer.addMoney(pagamento)
    elseif Config.PaymentTypeDrugs == 'black_money' then
        xPlayer.addAccountMoney('black_money', pagamento)
    elseif Config.PaymentTypeDrugs == 'item' then
        xPlayer.addInventoryItem('black_money', pagamento)
    end
    --ATUALIZA VALOR DO TERRITORIO
    local valoratual = dbTerritory[name].amount
    local valorfinal = valoratual + pagamento*Config.Percentage
    MySQL.Async.execute('UPDATE s_territories SET amount = @final WHERE name = @name', {		
        ['@name'] = name,
        ['@final'] = valorfinal
    })
    dbTerritory[name].amount = valorfinal
    discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), '\n Sold: '..Config.Territories[data].selldrug.label..' and received: '..pagamento..'\n Territory: '..Config.Territories[data].label..' Value: '..valorfinal)
end)


elseif Config.Framework == 'QBCore' then
RegisterServerEvent('s_territories:server:comecarcontroloqb')
AddEventHandler('s_territories:server:comecarcontroloqb', function(name, job)
    if (not Config.Territories[name].control.enabled or dbTerritory[name] == nil) then return end
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if (dbTerritory[name].gang == job) then
        local notification = { msg = Translations['already_owned'], type = "error",}
        TriggerClientEvent('safky:client:shownotification', source, notification)
        return
    elseif (territoryCount[job] ~= nil and territoryCount[job].count >= Config.MaxTerritories) then
        local notification = { msg = Translations['max_territories'], type = "error",}
        TriggerClientEvent('safky:client:shownotification', source, notification)
        return
    elseif (dbTerritory[name].capturing) then
        local notification = { msg = Translations['already_attempt'], type = "error",}
        TriggerClientEvent('safky:client:shownotification', source, notification)
        return
    end

    dbTerritory[name].capturing = true
    playerInfo[source] = name
    TriggerClientEvent('chat:addMessage', -1, {color = {0, 248, 185}, multiline = true, args = {Translations['server_name'], Translations['attempt_started']..Config.Territories[name].label}})
    TriggerClientEvent('s_territories:client:capturar', source)
    discordLog('Player: '..GetPlayerName(src)..'\n Start attempt to control: '..Config.Territories[name].label)
end)

RegisterServerEvent('s_territories:server:controlofalhadoqb')
AddEventHandler('s_territories:server:controlofalhadoqb', function(name)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local label = Config.Territories[name].label
    dbTerritory[name].capturing = false
    discordLog('Player: '..GetPlayerName(src)..'\n \n Failed to control: '..Config.Territories[name].label)
    if (xPlayer == nil) then
        TriggerClientEvent('chat:addMessage', -1, {color = {0, 248, 185}, multiline = true, args = {Translations['server_name'], Translations['failed_attempt']..label}})
    else
        TriggerClientEvent('chat:addMessage', -1, {color = {0, 248, 185}, multiline = true, args = {Translations['server_name'], Translations['failed_attempt']..label}})
    end
    
end)

RegisterServerEvent('s_territories:server:updateownerqb')
AddEventHandler('s_territories:server:updateownerqb', function(name, job)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if (territoryCount[dbTerritory[name].gang] ~= nil and dbTerritory[name] ~= nil) then
        territoryCount[dbTerritory[name].gang].count = territoryCount[dbTerritory[name].gang].count - 1
        dbTerritory[name].gang = job

        if (territoryCount[job] ~= nil) then
            territoryCount[job] = territoryCount[job].count + 1
        else
            territoryCount[job] = {}
            territoryCount[job].count = 1
        end

        TriggerClientEvent('chat:addMessage', -1, {color = {0, 248, 185}, multiline = true, args = {Translations['server_name'], Config.Territories[name].label..Translations['success_attempt']}})
        MySQL.Async.execute('UPDATE s_territories SET gang = @gang WHERE name = @name', {		
            ['@name'] = name,
            ['@gang'] = job
        }) 
        discordLog('Player: '..GetPlayerName(src)..'\n Job: '..job..'\n Controled with success: '..Config.Territories[name].label)
    end
end)

-------- #####COFRE######## ------
RegisterServerEvent('s_territories:server:openstashqb')
AddEventHandler('s_territories:server:openstashqb', function(name, job)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    print(job)
    if (dbTerritory[name].gang == job) then
        local amount = dbTerritory[name].amount
        local data = {name = name, amount = amount}
        TriggerClientEvent('s_territories:client:cofreautorizadoqb', source, data)
        return
    end
    local notification = { msg = Translations['permissions'], type = "error",}
    TriggerClientEvent('safky:client:shownotification', source, notification)
end)

RegisterServerEvent('s_territories:server:stashrewardqb')
AddEventHandler('s_territories:server:stashrewardqb', function(data, job)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if Config.PaymentType == 'money' then
        xPlayer.Functions.AddMoney('cash', data.retirado)
    elseif Config.PaymentType == 'item' then
        xPlayer.Functions.AddItem(Config.PaymentItem, data.retirado)
    end
    MySQL.Async.execute('UPDATE s_territories SET amount = @final WHERE name = @name', {		
            ['@name'] = data.name,
            ['@final'] = data.final
        })
    dbTerritory[data.name].amount = data.final
    discordLog('Player: '..GetPlayerName(src)..' (Removed money from stash)\n Location: '..data.name..'\n Removed: '..data.retirado..'€\n Balance Now: '..data.final)
end)

------ ####### VENDA DE DROGAS

RegisterServerEvent('s_territories:server:venderdroga2qb')
AddEventHandler('s_territories:server:venderdroga2qb', function(data)
    local name = data.data
    local item = Config.Territories[data.data].selldrug.item
    local itemlabel = Config.Territories[data.data].selldrug.label
    local quantity = Config.Territories[data.data].selldrug.quantity
    local price = Config.Territories[data.data].selldrug.price
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local droga = xPlayer.Functions.GetItemByName(item)
    if xPlayer and droga ~= nil then
        if droga.amount >= quantity then
            xPlayer.Functions.RemoveItem(item, quantity)
            TriggerClientEvent("s_territories:client:venderdrogaprocesso", source, name)
        else
            local notification = { msg = Translations['dont_have'], type = "error",}
            TriggerClientEvent('safky:client:shownotification', source, notification)
        end
    else
    end
end)

RegisterServerEvent('s_territories:server:sellingrewardqb')
AddEventHandler('s_territories:server:sellingrewardqb', function(data)
    local name = data
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local quantity = Config.Territories[data].selldrug.quantity
    local price = Config.Territories[data].selldrug.price
    local pagamento = quantity*price
    --PAGA
    if Config.PaymentTypeDrugs == 'money' then
        xPlayer.Functions.AddMoney('cash', pagamento)
    elseif Config.PaymentTypeDrugs == 'item' then
        xPlayer.Functions.AddItem(Config.PaymentItemDrugs, pagamento)
    end
    --ATUALIZA VALOR DO TERRITORIO
    local valoratual = dbTerritory[name].amount
    local valorfinal = valoratual + pagamento*Config.Percentage
    MySQL.Async.execute('UPDATE s_territories SET amount = @final WHERE name = @name', {		
        ['@name'] = name,
        ['@final'] = valorfinal
    })
    dbTerritory[name].amount = valorfinal
    discordLog(GetPlayerName(src) .. '\n Sold: '..Config.Territories[data].selldrug.label..' and received: '..pagamento..'\n Territory: '..Config.Territories[data].label..' Value: '..valorfinal)
end)

end


--- ### GLOBAL


RegisterServerEvent('s_territories:server:increasestash')
AddEventHandler('s_territories:server:increasestash', function()
        MySQL.Async.fetchAll('SELECT * FROM s_territories', {}, function(result)
            for k,v in pairs(result) do
                dbTerritory[v.name] = {
                    gang = v.gang,
                    amount = v.amount,
                    capturing = false
                }
                print(v.amount)
                local valorinicial = v.amount
                local valorfinal = v.amount + Config.IncreaseAmount
                
                MySQL.Async.execute('UPDATE s_territories SET amount = @final WHERE name = @name', {		
                    ['@name'] = v.name,
                    ['@final'] = valorfinal
                })

            end
        end)
end)


AddEventHandler("playerDropped", function()
    if (playerInfo[source] ~= nil) then
	    TriggerEvent('s_territories:server:controlofalhado', playerInfo[source])
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        Citizen.Wait(2000)
        MySQL.Async.fetchAll('SELECT * FROM s_territories', {}, function(result)
            for k,v in pairs(result) do
                dbTerritory[v.name] = {
                    gang = v.gang,
                    amount = v.amount,
                    capturing = false
                }
                
                if (territoryCount[v.gang] ~= nil) then
                    territoryCount[v.gang].count = territoryCount[v.gang].count + 1
                else
                    territoryCount[v.gang] = {}
                    territoryCount[v.gang].count = 1
                end
            end
        end)
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