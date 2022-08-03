if Config.Framework == 'ESX' then

    ESX = nil
    
    CreateThread(function()
        while not ESX do
            TriggerEvent(Config.getSharedObject, function(obj) ESX = obj end)
            Wait(500)
        end
    end)
    
    function getIdentifier(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            local identifier = xPlayer.getIdentifier()
    
            return ""..identifier
        end
    end
    
    function showNotification(source, message)
        TriggerClientEvent('esx:showNotification', source, message)
      --  TriggerClientEvent('chat:addMessage', source, { args = { message }})
    end
    
    -- This function will return the amount of money in the player's wallet account
    function getWalletMoney(source)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            return xPlayer.getMoney()
        end  
    end
    
    -- This function will remove money from the player's Wallet account
    function removeWalletMoney(source, value)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            xPlayer.removeMoney(value)
        end 
    end
    
    -- This function will add money from the player's Wallet account
    function addWalletMoney(source, value)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            xPlayer.addMoney(value)
        end 
    end
    
    -- This function will return the amount of money in the player's bank account
    function getBankMoney(source)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            return xPlayer.getAccount('bank').money
        end  
    end
    
    -- This function will remove money from the player's bank account
    function removeBankMoney(source, value)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            xPlayer.removeAccountMoney('bank', value)
        end 
    end
    
    -- This function will add money to the player's bank account
    function addBankMoney(source, value)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            xPlayer.addInventoryItem('black_money', value)
        end 
    end
    
    -- This function will return the player's name
    function getName(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local name = xPlayer.getName()
        return name
    end
    
    
    function canCarryItem(source, item, _amount)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer.canCarryItem(item, _amount) then
            return true
        else 
            return false
        end
    end
    
    --[[function canCarryItem(source, weight)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            local my_weight = xPlayer.getWeight()
            local my_maxweight = xPlayer.maxWeight
            local new_weight = my_weight + weight
                return true
        end    
    
        return false
    end--]]
        
    
    -- This function will return the player's inventory
    function getInventory(source)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            local inventory = xPlayer.getInventory()
            for i,k in pairs(inventory) do
                if k.count ~= nil then
                    k.amount = k.count
                end
                
                if not k.amount then
                    k.amount = 0
                end
            end
            
            return inventory
        end
    end
    
    -- This function will remove an item from the player's inventory
    function removeInventoryItem(source, item, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            xPlayer.removeInventoryItem(item, amount)
        end 
    end
    
    -- This function will add an item to the player's inventory
    function addInventoryItem(source, item, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            xPlayer.addInventoryItem(item, amount)
        end 
    end
    
    -- This function will add an weapon to the player
    function addWeapon(source, weapon, ammo)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        if xPlayer then
            xPlayer.addWeapon(weapon, ammo)
        end
    end
        
end
        
