if Config.Framework == 'QBCore' then

    QBCore = exports['qb-core']:GetCoreObject()
    
    -- This function will return the player's identifier (identifier or id)
    function getIdentifier(source)
        local Player = QBCore.Functions.GetPlayer(source)
        
        if Player then
            return ""..Player.PlayerData.citizenid
        end
    end
    
    -- This function will return the player's name
    function getName(source)
        local Player = QBCore.Functions.GetPlayer(source)
        local name = GetPlayerName(source)
    
        if Player then
            name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        end
        
        return name
    end
    
    function showNotification(source, message)
        TriggerClientEvent('QBCore:Notify', source, message)
    end
    
    -- This function will return the amount of money in the player's bank account
    function getBankMoney(source)
        local Player = QBCore.Functions.GetPlayer(source)
    
        if Player then
            return Player.PlayerData.money["bank"]
        end
    end
    
    -- This function will remove money from the player's bank account
    function removeBankMoney(source, value)
        local Player = QBCore.Functions.GetPlayer(source)
    
        if Player then
            Player.Functions.RemoveMoney('bank', value)
        end 
    end
    
    -- This function will add money to the player's bank account
    function addBankMoney(source, value)
        local Player = QBCore.Functions.GetPlayer(source)
    
        if Player then
                Player.Functions.AddMoney('bank', value)
        end
    end
    
    -- This function will return the amount of money in the player's wallet account
    function getWalletMoney(source)
        local Player = QBCore.Functions.GetPlayer(source)
    
        if Player then
            return Player.PlayerData.money["cash"]
        end
    end
    
    -- This function will add money from the player's Wallet account
    function addWalletMoney(source, value)
        local Player = QBCore.Functions.GetPlayer(source)
    
        if Player then
             Player.Functions.AddMoney('cash', value)
        end
    end
    
    -- This function will remove money from the player's Wallet account
    function removeWalletMoney(source, value)
        local Player = QBCore.Functions.GetPlayer(source)
    
        if Player then
            Player.Functions.RemoveMoney('cash', value)
        end 
    end
    
    if Config.InventoryType == 'weight' then
        -- This function will return TRUE if the player has enough space in his inventory
        function canCarryItem(source, weight)
            local Player = QBCore.Functions.GetPlayer(source)
        
            if Player then
                local maxWeight = QBCore.Config.Player.MaxWeight
                local totalWeight = QBCore.Player.GetTotalWeight(Player.PlayerData.items)
    
                return ( (totalWeight + weight) <= maxWeight )
            end 
    
            return false
        end
        
    else
        -- This function will return TRUE if the player has enough space in his inventory
        function canCarryItem(source, item, _amount)
            local Player = QBCore.Functions.GetPlayer(source)
        
            if Player then
                local itemInfo = QBCore.Shared.Items[item:lower()]
                local maxWeight = QBCore.Config.Player.MaxWeight
                local totalWeight = QBCore.Player.GetTotalWeight(Player.PlayerData.items)
                local itemWeight = itemInfo.weight * _amount
                return ( (totalWeight + itemWeight) <= maxWeight )
            end   
            
            return false
        end
    end
    
    -- This function will return the player's weigth
    function getWeight(source)
        local Player = QBCore.Functions.GetPlayer(source)
        return QBCore.Player.GetTotalWeight(Player.PlayerData.items)
    end
    
    -- This function will return the player's inventory
    function getInventory(source)
        -- example:
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local Inventory = Player.PlayerData.items
        
        if Player then
            return Inventory
        end
    end
    
    -- This function will add an item to the player's inventory
    function addInventoryItem(source, item, amount)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            Player.Functions.AddItem(item, amount)
        end 
    end
    
    -- This function will remove an item from the player's inventory
    function removeInventoryItem(source, item, amount)
        -- example:
         local Player = QBCore.Functions.GetPlayer(source)
    
         if Player then
            Player.Functions.RemoveItem(item, amount)
         end 
    end
    
    -- This function will add an weapon to the player
    function addWeapon(source, weapon, ammo)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            local weaponInfo = QBCore.Shared.Items[weapon:lower()]
            local ammo_type = weaponInfo.ammotype
    
            if ammo > 0 then
                if ammo_type == "AMMO_PISTOL" then
                    addInventoryItem(source, "pistol_ammo", ammo)
                elseif ammo_type == "AMMO_SMG" then
                    addInventoryItem(source, "smg_ammo", ammo)
                elseif ammo_type == "AMMO_SHOTGUN" then
                    addInventoryItem(source, "shotgun_ammo", ammo)
                elseif ammo_type == "AMMO_RIFLE" then
                    addInventoryItem(source, "rifle_ammo", ammo)
                elseif ammo_type == "AMMO_MG" then
                    addInventoryItem(source, "mg_ammo", ammo)
                elseif ammo_type == "AMMO_SNIPER" then
                    addInventoryItem(source, "snp_ammo", ammo)
                end
            end
            
            addInventoryItem(source, weapon, 1)
        end
    end
    
    
    end