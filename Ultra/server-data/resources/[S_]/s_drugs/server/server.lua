ESX = nil
QBCore = nil
local PlayerJob = nil
PlayerData = {}

if Config.Framework == 'ESX' then
    TriggerEvent(Config.getSharedObject, function(obj) ESX = obj end)
elseif Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
end


if Config.Framework == 'ESX' then
--- ######### COCAINA ######### --------

-- APANHA
RegisterNetEvent("nxt_core:server:apanhacocaina")
AddEventHandler("nxt_core:server:apanhacocaina", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            xPlayer.addInventoryItem(Config['Items']['pickupcocaine'], Config['Drugs']['cocainevalues']['pickup'])
        end
end)

-- PROCESSO
ESX.RegisterServerCallback("nxt_drugs:server:procesooncacoca", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local folhascoca = xPlayer.getInventoryItem(Config['Items']['pickupcocaine']) and xPlayer.getInventoryItem(Config['Items']['pickupcocaine']).count
    if folhascoca >= Config['Drugs']['cocainevalues']['processneeded'] then
        cb(true)
        xPlayer.removeInventoryItem(Config['Items']['pickupcocaine'], Config['Drugs']['cocainevalues']['processneeded'])
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:finalizarcoca')
AddEventHandler('nxt_drugs:server:finalizarcoca', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem(Config['Items']['processcocaine'], Config['Drugs']['cocainevalues']['processreward'])
end)
-- CORTE
ESX.RegisterServerCallback("nxt_drugs:server:cortarcocaina", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local coca = xPlayer.getInventoryItem(Config['Items']['processcocaine']) and xPlayer.getInventoryItem(Config['Items']['processcocaine']).count
    local balanca = xPlayer.getInventoryItem(Config['Items']['drugscale']) and xPlayer.getInventoryItem(Config['Items']['drugscale']).count
    local sacos = xPlayer.getInventoryItem(Config['Items']['emptybag']) and xPlayer.getInventoryItem(Config['Items']['emptybag']).count
    if coca >= Config['Drugs']['cocainevalues']['cutneeded'] and balanca >= 1 and sacos >= Config['Drugs']['bagsneeded'] then
        cb(true)
        xPlayer.removeInventoryItem(Config['Items']['processcocaine'], Config['Drugs']['cocainevalues']['cutneeded'])
        xPlayer.removeInventoryItem(Config['Items']['emptybag'], Config['Drugs']['bagsneeded'])
        xPlayer.addInventoryItem(Config['Items']['cutcocaine'], Config['Drugs']['cocainevalues']['cutreward'])
    else
        cb(false)
    end
end)

--- ######### ERVA ######### --------

-- APANHA
RegisterNetEvent("nxt_core:server:apanhaerva")
AddEventHandler("nxt_core:server:apanhaerva", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            xPlayer.addInventoryItem(Config['Items']['pickupweed'], Config['Drugs']['weedvalues']['pickup'])
        end
end)

-- PROCESSO
ESX.RegisterServerCallback("nxt_drugs:server:procesooncaerva", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local folhascoca = xPlayer.getInventoryItem(Config['Items']['pickupweed']) and xPlayer.getInventoryItem(Config['Items']['pickupweed']).count
    if folhascoca >= Config['Drugs']['weedvalues']['processneeded'] then
        cb(true)
        xPlayer.removeInventoryItem(Config['Items']['pickupweed'], Config['Drugs']['weedvalues']['processneeded'])
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:finalizarerva')
AddEventHandler('nxt_drugs:server:finalizarerva', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem(Config['Items']['processweed'], Config['Drugs']['weedvalues']['processreward'])
end)
-- CORTE
ESX.RegisterServerCallback("nxt_drugs:server:cortarerva", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local coca = xPlayer.getInventoryItem(Config['Items']['processweed']) and xPlayer.getInventoryItem(Config['Items']['processweed']).count
    local balanca = xPlayer.getInventoryItem(Config['Items']['drugscale']) and xPlayer.getInventoryItem(Config['Items']['drugscale']).count
    local sacos = xPlayer.getInventoryItem(Config['Items']['emptybag']) and xPlayer.getInventoryItem(Config['Items']['emptybag']).count
    if coca >= Config['Drugs']['weedvalues']['cutneeded'] and balanca >= 1 and sacos >= Config['Drugs']['bagsneeded'] then
        cb(true)
        xPlayer.removeInventoryItem(Config['Items']['processweed'], Config['Drugs']['weedvalues']['cutneeded'])
        xPlayer.removeInventoryItem(Config['Items']['emptybag'], Config['Drugs']['bagsneeded'])
        xPlayer.addInventoryItem(Config['Items']['cutweed'], Config['Drugs']['weedvalues']['cutreward'])
    else
        cb(false)
    end
end)


--- ######### META ######### --------

-- APANHA
RegisterNetEvent("nxt_core:server:apanhameta")
AddEventHandler("nxt_core:server:apanhameta", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            xPlayer.addInventoryItem(Config['Items']['pickupmeth'], Config['Drugs']['methvalues']['pickup'])
        end
end)

-- PROCESSO
ESX.RegisterServerCallback("nxt_drugs:server:procesooncameta", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local folhascoca = xPlayer.getInventoryItem(Config['Items']['pickupmeth']) and xPlayer.getInventoryItem(Config['Items']['pickupmeth']).count
    if folhascoca >= Config['Drugs']['methvalues']['processneeded'] then
        cb(true)
        xPlayer.removeInventoryItem(Config['Items']['pickupmeth'], Config['Drugs']['methvalues']['processneeded'])
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:finalizarmeta')
AddEventHandler('nxt_drugs:server:finalizarmeta', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem(Config['Items']['processmeth'], Config['Drugs']['methvalues']['processreward'])
end)
-- CORTE
ESX.RegisterServerCallback("nxt_drugs:server:cortarmeta", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local coca = xPlayer.getInventoryItem(Config['Items']['processmeth']) and xPlayer.getInventoryItem(Config['Items']['processmeth']).count
    local balanca = xPlayer.getInventoryItem(Config['Items']['drugscale']) and xPlayer.getInventoryItem(Config['Items']['drugscale']).count
    local sacos = xPlayer.getInventoryItem(Config['Items']['emptybag']) and xPlayer.getInventoryItem(Config['Items']['emptybag']).count
    if coca >= Config['Drugs']['methvalues']['cutneeded'] and balanca >= 1 and sacos >= Config['Drugs']['bagsneeded'] then
        cb(true)
        xPlayer.removeInventoryItem(Config['Items']['processmeth'], Config['Drugs']['methvalues']['cutneeded'])
        xPlayer.removeInventoryItem(Config['Items']['emptybag'], Config['Drugs']['bagsneeded'])
        xPlayer.addInventoryItem(Config['Items']['cutmeth'], Config['Drugs']['methvalues']['cutreward'])
    else
        cb(false)
    end
end)

elseif Config.Framework == 'QBCore' then
    --- ######### COCAINA ######### --------

-- APANHA
RegisterNetEvent("nxt_core:server:apanhacocaina")
AddEventHandler("nxt_core:server:apanhacocaina", function(item, count)
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
        if xPlayer then
            xPlayer.Functions.AddItem(Config['Items']['pickupcocaine'], Config['Drugs']['cocainevalues']['pickup'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['pickupcocaine']], "add")
        end
end)

-- PROCESSO
QBCore.Functions.CreateCallback("nxt_drugs:server:procesooncacoca", function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local folhascoca = xPlayer.Functions.GetItemByName(Config['Items']['pickupcocaine'])
    if xPlayer and folhascoca ~= nil then
    if folhascoca.amount >= Config['Drugs']['cocainevalues']['processneeded'] then
        cb(true)
        xPlayer.Functions.RemoveItem(Config['Items']['pickupcocaine'], Config['Drugs']['cocainevalues']['processneeded'])
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['pickupcocaine']], "remove")
    else
        cb(false)
    end
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:finalizarcocaina')
AddEventHandler('nxt_drugs:server:finalizarcocaina', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    xPlayer.Functions.AddItem(Config['Items']['processcocaine'], Config['Drugs']['cocainevalues']['processreward'])
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['processcocaine']], "add")
end)

-- CORTE
QBCore.Functions.CreateCallback("nxt_drugs:server:cortarcocaina", function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local coca = xPlayer.Functions.GetItemByName(Config['Items']['processcocaine']) 
    local balanca = xPlayer.Functions.GetItemByName(Config['Items']['drugscale']) 
    local sacos = xPlayer.Functions.GetItemByName(Config['Items']['emptybag']) 
    if xPlayer and coca ~= nil and balanca ~= nil and sacos ~= nil then
    if coca.amount >= Config['Drugs']['cocainevalues']['cutneeded'] and balanca.amount >= 1 and sacos.amount >= Config['Drugs']['bagsneeded'] then
        cb(true)
        xPlayer.Functions.RemoveItem(Config['Items']['processcocaine'], Config['Drugs']['cocainevalues']['cutneeded'])
        xPlayer.Functions.RemoveItem(Config['Items']['emptybag'], Config['Drugs']['bagsneeded'])
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['processcocaine']], "remove")
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['emptybag']], "remove")
    else
        cb(false)
    end
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:finalizarcocaina2')
AddEventHandler('nxt_drugs:server:finalizarcocaina2', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    xPlayer.Functions.AddItem(Config['Items']['cutcocaine'], Config['Drugs']['cocainevalues']['cutreward'])
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['cutcocaine']], "add")
end)

--- ######### ERVA ######### --------

-- APANHA
RegisterNetEvent("nxt_core:server:apanhaerva")
AddEventHandler("nxt_core:server:apanhaerva", function(item, count)
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
        if xPlayer ~= nil then
            xPlayer.Functions.AddItem(Config['Items']['pickupweed'], Config['Drugs']['weedvalues']['pickup'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['pickupweed']], "add")
        end
end)

-- PROCESSO
QBCore.Functions.CreateCallback("nxt_drugs:server:procesooncaerva", function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local folhascoca = xPlayer.Functions.GetItemByName(Config['Items']['pickupweed']) 
    if xPlayer and folhascoca ~= nil then 
        if folhascoca.amount >= Config['Drugs']['weedvalues']['processneeded'] then
            cb(true)
            xPlayer.Functions.RemoveItem(Config['Items']['pickupweed'], Config['Drugs']['weedvalues']['processneeded'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['pickupweed']], "remove")
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:finalizarerva')
AddEventHandler('nxt_drugs:server:finalizarerva', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    xPlayer.Functions.AddItem(Config['Items']['processweed'], Config['Drugs']['weedvalues']['processreward'])
end)
-- CORTE
QBCore.Functions.CreateCallback("nxt_drugs:server:cortarerva", function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local coca = xPlayer.Functions.GetItemByName(Config['Items']['processweed']) 
    local balanca = xPlayer.Functions.GetItemByName(Config['Items']['drugscale']) 
    local sacos = xPlayer.Functions.GetItemByName(Config['Items']['emptybag']) 
    if xPlayer and coca ~= nil and balanca ~= nil and sacos ~= nil then
        if coca.amount >= Config['Drugs']['weedvalues']['cutneeded'] and balanca.amount >= 1 and sacos.amount >= Config['Drugs']['bagsneeded'] then
            cb(true)
            xPlayer.Functions.RemoveItem(Config['Items']['processweed'], Config['Drugs']['weedvalues']['cutneeded'])
            xPlayer.Functions.RemoveItem(Config['Items']['emptybag'], Config['Drugs']['bagsneeded'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['processweed']], "remove")
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['emptybag']], "remove")
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:finalizarerva2')
AddEventHandler('nxt_drugs:server:finalizarerva2', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    xPlayer.Functions.AddItem(Config['Items']['cutweed'], Config['Drugs']['weedvalues']['cutreward'])
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['cutweed']], "add")
end)


--- ######### META ######### --------

-- APANHA
RegisterNetEvent("nxt_core:server:apanhameta")
AddEventHandler("nxt_core:server:apanhameta", function(item, count)
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
        if xPlayer ~= nil then
            xPlayer.Functions.AddItem(Config['Items']['pickupmeth'], Config['Drugs']['methvalues']['pickup'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['pickupmeth']], "add")
        end
end)

-- PROCESSO
QBCore.Functions.CreateCallback("nxt_drugs:server:procesooncameta", function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local folhascoca = xPlayer.Functions.GetItemByName(Config['Items']['pickupmeth'])
    if xPlayer and folhascoca ~= nil then 
        if folhascoca.amount >= Config['Drugs']['methvalues']['processneeded'] then
            cb(true)
            xPlayer.Functions.RemoveItem(Config['Items']['pickupmeth'], Config['Drugs']['methvalues']['processneeded'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['pickupmeth']], "remove")
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:finalizarmeta')
AddEventHandler('nxt_drugs:server:finalizarmeta', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    xPlayer.Functions.AddItem(Config['Items']['processmeth'], Config['Drugs']['methvalues']['processreward'])
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['processmeth']], "add")
end)
-- CORTE
QBCore.Functions.CreateCallback("nxt_drugs:server:cortarmeta", function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local coca = xPlayer.Functions.GetItemByName(Config['Items']['processmeth']) 
    local balanca = xPlayer.Functions.GetItemByName(Config['Items']['drugscale']) 
    local sacos = xPlayer.Functions.GetItemByName(Config['Items']['emptybag'])
    if xPlayer and coca ~= nil and balanca ~= nil and sacos ~= nil then
        if coca.amount >= Config['Drugs']['methvalues']['cutneeded'] and balanca.amount >= 1 and sacos.amount >= Config['Drugs']['bagsneeded'] then
            cb(true)
            xPlayer.Functions.RemoveItem(Config['Items']['processmeth'], Config['Drugs']['methvalues']['cutneeded'])
            xPlayer.Functions.RemoveItem(Config['Items']['emptybag'], Config['Drugs']['bagsneeded'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['processmeth']], "remove")
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['emptybag']], "remove")
            
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:finalizarmeta2')
AddEventHandler('nxt_drugs:server:finalizarmeta2', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    xPlayer.Functions.AddItem(Config['Items']['cutmeth'], Config['Drugs']['methvalues']['cutreward'])
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['cutmeth']], "add")
end)
end


-- CUT KIT 
if Config.Framework == 'ESX' then
    ESX.RegisterUsableItem('drug_cuttingkit', function(source)
        TriggerClientEvent("nxt_drugs:client:cortarmeta", source)
    end)
elseif Config.Framework == 'QBCore' then
    QBCore.Functions.CreateUseableItem("drug_cuttingkit", function(source)
        TriggerClientEvent("nxt_drugs:client:cortarmeta", source)
    end)
end

-- ######## VENDA ############ -----
if Config.Framework == 'ESX' then
-- COCAINA
ESX.RegisterServerCallback("nxt_drugs:server:checarcoca", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local cocafinal = xPlayer.getInventoryItem(Config['Items']['cutcocaine']) and xPlayer.getInventoryItem(Config['Items']['cutcocaine']).count
    if cocafinal >= Config['Drugs']['cocainevalues']['sellquantity'] then
        cb(true)
        xPlayer.removeInventoryItem(Config['Items']['cutcocaine'], Config['Drugs']['cocainevalues']['sellquantity'])
        local pagamento = Config['Drugs']['cocainevalues']['sellquantity']*Config['Drugs']['cocainevalues']['price1g']
        if Config.PaymentType == 0 then
            xPlayer.addMoney(pagamento)
        elseif Config.PaymentType == 1 then
            xPlayer.addAccountMoney('black_money', pagamento)
        elseif Config.PaymentType == 2 then
            xPlayer.addInventoryItem('black_money', pagamento)
        end
        discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), ' Sold Cocaine and got '..pagamento..'€!' )
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("nxt_drugs:server:checarerva", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local cocafinal = xPlayer.getInventoryItem(Config['Items']['cutweed']) and xPlayer.getInventoryItem(Config['Items']['cutweed']).count
    if cocafinal >= Config['Drugs']['weedvalues']['sellquantity'] then
        cb(true)
        xPlayer.removeInventoryItem(Config['Items']['cutweed'], Config['Drugs']['weedvalues']['sellquantity'])
        local pagamento = Config['Drugs']['weedvalues']['sellquantity']*Config['Drugs']['weedvalues']['price1g']
        if Config.PaymentType == 0 then
            xPlayer.addMoney(pagamento)
        elseif Config.PaymentType == 1 then
            xPlayer.addAccountMoney('black_money', pagamento)
        elseif Config.PaymentType == 2 then
            xPlayer.addInventoryItem('black_money', pagamento)
        end
        discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), ' Sold Weed and got '..pagamento..'€!' )
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("nxt_drugs:server:checarvmeta", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local cocafinal = xPlayer.getInventoryItem(Config['Items']['cutmeth']) and xPlayer.getInventoryItem(Config['Items']['cutmeth']).count
    if cocafinal >= Config['Drugs']['methvalues']['sellquantity'] then
        cb(true)
        xPlayer.removeInventoryItem(Config['Items']['cutmeth'], Config['Drugs']['methvalues']['sellquantity'])
        local pagamento = Config['Drugs']['methvalues']['sellquantity']*Config['Drugs']['methvalues']['price1g']
        if Config.PaymentType == 0 then
            xPlayer.addMoney(pagamento)
        elseif Config.PaymentType == 1 then
            xPlayer.addAccountMoney('black_money', pagamento)
        elseif Config.PaymentType == 2 then
            xPlayer.addInventoryItem('black_money', pagamento)
        end
        discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), ' Sold meth and got '..pagamento..'€!' )
    else
        cb(false)
    end
end)



-- LAVAGEM DE DINHEIRO
ESX.RegisterServerCallback("nxt_drugs:server:checarsujo", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if Config.BlackMoneyType == 0 then
        local sujofinal = xPlayer.getAccount('black_money').money
        if sujofinal >= Config['WashMoney']['amount'] then
            cb(true)
            xPlayer.removeAccountMoney('black_money', Config['WashMoney']['amount'])
            local dinheirolimpototal = Config['WashMoney']['amount']*Config['WashMoney']['percentage']
            xPlayer.addAccountMoney('money', dinheirolimpototal)
            discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), ' Washed dirty money and got '..dinheirolimpototal..'€ clean money!' )
        else
            cb(false)
        end
    else   
        local sujofinal = xPlayer.getInventoryItem(Config.BlackMoneyItem) and xPlayer.getInventoryItem(Config.BlackMoneyItem).count
        if sujofinal >= Config['WashMoney']['amount'] then
            cb(true)
            xPlayer.removeInventoryItem(Config.BlackMoneyItem, Config['WashMoney']['amount'])
            local dinheirolimpototal = Config['WashMoney']['amount']*Config['WashMoney']['percentage']
            xPlayer.addAccountMoney('money', dinheirolimpototal)
            discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), ' Washed dirty money and got '..dinheirolimpototal..'€ clean money!' )
        else
            cb(false)
        end
    end
end)

elseif Config.Framework == 'QBCore' then
-- COCAINA
QBCore.Functions.CreateCallback("nxt_drugs:server:checarcoca", function(source, cb)
    local src = source
    local xPlayer =  QBCore.Functions.GetPlayer(src)
    local cocafinal = xPlayer.Functions.GetItemByName(Config['Items']['cutcocaine']) 
    if xPlayer and cocafinal ~= nil then
        if cocafinal.amount >= Config['Drugs']['cocainevalues']['sellquantity'] then
            cb(true)
            xPlayer.Functions.RemoveItem(Config['Items']['cutcocaine'], Config['Drugs']['cocainevalues']['sellquantity'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['cutcocaine']], "remove")
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:vendercocafinalll')
AddEventHandler('nxt_drugs:server:vendercocafinalll', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    local pagamento = Config['Drugs']['cocainevalues']['sellquantity']*Config['Drugs']['cocainevalues']['price1g']
        if Config.PaymentType == 0 then
            xPlayer.Functions.AddMoney('cash', pagamento)
        elseif Config.PaymentType == 2 then
            xPlayer.Functions.AddItem('black_money', pagamento)       
        end
        discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), ' Sold Cocaine and got '..pagamento..'€!' )
end)

QBCore.Functions.CreateCallback("nxt_drugs:server:checarerva", function(source, cb)
    local src = source
    local xPlayer =  QBCore.Functions.GetPlayer(src)
    local cocafinal = xPlayer.Functions.GetItemByName(Config['Items']['cutweed']) 
    if xPlayer and cocafinal ~= nil then
        if cocafinal.amount >= Config['Drugs']['weedvalues']['sellquantity'] then
            cb(true)
            xPlayer.Functions.RemoveItem(Config['Items']['cutweed'], Config['Drugs']['weedvalues']['sellquantity'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['cutweed']], "remove")
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:venderervafinalll')
AddEventHandler('nxt_drugs:server:venderervafinalll', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    local pagamento = Config['Drugs']['weedvalues']['sellquantity']*Config['Drugs']['weedvalues']['price1g']
        if Config.PaymentType == 0 then
            xPlayer.Functions.AddMoney('cash', pagamento)
        elseif Config.PaymentType == 2 then
            xPlayer.Functions.AddItem('black_money', pagamento)       
        end
        discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), ' Sold Weed and got '..pagamento..'€!' )
end)

QBCore.Functions.CreateCallback("nxt_drugs:server:checarvmeta", function(source, cb)
    local src = source
    local xPlayer =  QBCore.Functions.GetPlayer(src)
    local cocafinal = xPlayer.Functions.GetItemByName(Config['Items']['cutmeth']) 
    if xPlayer and cocafinal ~= nil then
        if cocafinal.amount >= Config['Drugs']['methvalues']['sellquantity'] then
            cb(true)
            xPlayer.Functions.RemoveItem(Config['Items']['cutmeth'], Config['Drugs']['methvalues']['sellquantity'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config['Items']['cutmeth']], "remove")
            
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('nxt_drugs:server:vendermetafinalll')
AddEventHandler('nxt_drugs:server:vendermetafinalll', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    local pagamento = Config['Drugs']['methvalues']['sellquantity']*Config['Drugs']['methvalues']['price1g']
        if Config.PaymentType == 0 then
            xPlayer.Functions.AddMoney('cash', pagamento)
        elseif Config.PaymentType == 2 then
            xPlayer.Functions.AddItem('black_money', pagamento)       
        end
        discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), ' Sold meth and got '..pagamento..'€!' )
end)



-- LAVAGEM DE DINHEIRO
QBCore.Functions.CreateCallback("nxt_drugs:server:checarsujo", function(source, cb)
    local src = source
    local xPlayer =  QBCore.Functions.GetPlayer(src)
    local sujofinal = xPlayer.Functions.GetItemByName(Config.BlackMoneyItem)
    if xPlayer and sujofinal ~= nil then
        if sujofinal.amount >= Config['WashMoney']['amount'] then
            cb(true)
            xPlayer.Functions.RemoveItem(Config.BlackMoneyItem, Config['WashMoney']['amount'])
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.BlackMoneyItem], "remove")
        else
            cb(false)
        end
    else
        cb(false)
    end
end)
end

RegisterServerEvent('nxt_drugs:server:lavagemfinalll')
AddEventHandler('nxt_drugs:server:lavagemfinalll', function()
    local _source = source
    local xPlayer  = QBCore.Functions.GetPlayer(_source)
    local dinheirolimpototal = Config['WashMoney']['amount']*Config['WashMoney']['percentage']
    xPlayer.Functions.AddMoney('cash', dinheirolimpototal)
    discordLog(GetPlayerName(src) ..  ' - ' .. xPlayer.getIdentifier(), ' Washed dirty money and got '..dinheirolimpototal..'€ clean money!' )
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



