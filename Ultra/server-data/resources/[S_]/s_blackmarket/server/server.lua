products = {}

CreateThread(function()
    _createTableMarket(function()
        _selectTableMarket(function(result)
            products = result
        end)
    end)
end)

---------------- GENERAL

RegisterNetEvent('s_blackmarket:Open')
AddEventHandler('s_blackmarket:Open', function()
    local src = source
    TriggerClientEvent("s_blackmarket:OpenMarket", src)
end)

RegisterNetEvent('s_blackmarket:LoadProducts', function()
    local src = source

    local _, total_solds = GetSoldsPlayer(src)
    TriggerClientEvent("s_blackmarket:LoadedProducts", src, products, total_solds)
end)

RegisterNetEvent('s_blackmarket:LoadInventory', function()
    local src = source
    local inventory = getInventory(src)
    TriggerClientEvent("s_blackmarket:LoadedInventory", src, inventory)
end)

RegisterNetEvent('s_blackmarket:LoadSolds', function()
    local src = source
    local solds, total_solds = GetSoldsPlayer(src)
    TriggerClientEvent("s_blackmarket:LoadedSolds", src, solds, total_solds)
end)

RegisterNetEvent('s_blackmarket:LoadMyAds', function()
    local src = source
    local myads = GetAnnouncementsPlayer(src)
    TriggerClientEvent("s_blackmarket:LoadedMyAds", src, myads)
end)

RegisterNetEvent('s_blackmarket:SellProduct', function(data)
    local src = source

    local identifier = getIdentifier(src)
    local owner = getName(src)
    
    local item = data.product
    local amount = data.amount
    local is_anonymous = data.anonymous

    if is_anonymous then
        owner = translate.ANONYMOUS
    end

    -- check if is blacklist items
    if not IsItemBlackList(item.name) then
        showNotification(src, translate.CANT_ITEM)
        TriggerClientEvent("s_blackmarket:Error", src, translate.CANT_ITEM)
        return
    end

    -- check if has item
    if not HasItem(src, item.name, amount) then
        showNotification(src, translate.DONT_HAVE_ITEM)
        TriggerClientEvent("s_blackmarket:Error", src, translate.DONT_HAVE_ITEM)
        return
    end

    if HasAdvertisedItem(src, item.name) then
        showNotification(src, translate.CANT_SAME)
        TriggerClientEvent("s_blackmarket:Error", src, translate.CANT_SAME)
        return
    end

    -- check amount exploit
    if amount <= 0 then
        showNotification(src, translate.DONT_HAVE_ITEM)
        TriggerClientEvent("s_blackmarket:Error", src, translate.DONT_HAVE_ITEM)
        return
    end

    -- check payment fee and check fee exploit
    local money = getBankMoney(src)
    local fee = math.floor(item.price * amount * Config.SellFee)
    if fee > money or fee < 0 then
        showNotification(src, translate.DONT_HAVE_MONEY)
        TriggerClientEvent("s_blackmarket:Error", src, translate.DONT_HAVE_MONEY)
        return
    end

    -- check price exploit
    if item.price < 0 then
        showNotification(src, translate.DONT_HAVE_MONEY)
        TriggerClientEvent("s_blackmarket:Error", src, translate.DONT_HAVE_MONEY)
        return
    end    

    -- remove item and pay fee
    removeBankMoney(src, fee)
    removeInventoryItem(src, item.name, amount)

    _insertTableMarket(item.name, item.label, amount, item.weight, item.price, 0, owner, identifier,
    function(insertId)
        table.insert(products, {
            id = insertId,
            name = item.name,
            label = item.label,
            amount = amount,
            weight = item.weight,
            price = item.price,
            solds = 0,
            owner = owner,
            identifier = identifier,
        })

        showNotification(src, translate.ADVERTISE_SUCCESSFULL)
        TriggerClientEvent("s_blackmarket:FinishedTransaction", src)
    end)

    local message = "**PUT A ITEM ON BLACKMARKET**\nOwner:"..getName(src).."\nIdentifier:"..identifier.."\n Item: "..item.label.."\n Amount: "..amount.."\n Price: "..item.price.."."
    sendWebhook(message)
end)

RegisterNetEvent('s_blackmarket:BuyProduct', function(data)
    local src = source

    local identifier = getIdentifier(src)
    local name = getName(src)
    
    local item = data.product
    local amount = data.amount

    local real_item = GetProduct(item.id)

    -- check if item is selling
    if not real_item then
        showNotification(src, translate.NO_SALE)
        TriggerClientEvent("s_blackmarket:Error", src, translate.NO_SALE)
        return
    end
    
    -- check amount exploit
    if amount <= 0 then
        showNotification(src, translate.NO_SALE)
        TriggerClientEvent("s_blackmarket:Error", src, translate.NO_SALE)
        return
    end
    
    -- check amount
    if amount > real_item.amount then
        showNotification(src, translate.NOT_AMOUNT)
        TriggerClientEvent("s_blackmarket:Error", src, translate.NOT_AMOUNT)
        return
    end

    -- check if is owner
    if real_item.identifier == identifier then
        showNotification(src, translate.CANT_OWNER)
        TriggerClientEvent("s_blackmarket:Error", src, translate.CANT_OWNER)
        return
    end

    -- check can carry item
        if not canCarryItem(src, real_item.name, amount) then
            showNotification(src, translate.CANT_CARRY_ITEM)
            TriggerClientEvent("s_blackmarket:Error", src, translate.CANT_CARRY_ITEM)
            return
        end
    
    -- check payment
    local money = getBankMoney(src)
    local value = math.floor((item.price*amount) + (item.price * amount * Config.Fee))
    if value > money or value < 0 then
        showNotification(src, translate.DONT_HAVE_MONEY)
        TriggerClientEvent("s_blackmarket:Error", src, translate.DONT_HAVE_MONEY)
        return
    end

    -- remove item from market
    real_item.amount = real_item.amount - amount
    real_item.solds = real_item.solds + amount

    -- add item and pay it
    -- print(item.price)
    removeBankMoney(src, value)
    addInventoryItem(src, item.name, amount)

    _updateTableMarket(real_item.id, real_item.amount, real_item.solds,
    function()
        showNotification(src, translate.BUY_SUCCESSFULL)
        TriggerClientEvent("s_blackmarket:FinishedTransaction", src)

        local seller_src = GetSourceByIdentifier(real_item.identifier)
        
        if seller_src then
            showNotification(seller_src, real_item.label .. " x" .. amount .. " " .. translate.SELL_SUCCESSFULL)
        end
    end)

    local message = "**BOUGHT A ITEM ON BLACKMARKET**\nBuyer: "..name.."\nIdentifier: "..identifier.."\n Owner: "..real_item.owner.."\n Identifier: "..real_item.identifier.."\n Item: "..real_item.label.."\n Amount: "..amount.."\n Price: "..value.."."
    sendWebhook(message)
end)

RegisterNetEvent('s_blackmarket:ReceiveItem', function(data)
    local src = source

    local identifier = getIdentifier(src)
    
    local item = data.product

    local real_item, index_array = GetProduct(item.id)

    -- check if item is in market
    if not real_item then
        showNotification(src, translate.NO_EXIST)
        TriggerClientEvent("s_blackmarket:Error", src, translate.NO_EXIST)
        return
    end

    -- check if is owner
    if real_item.identifier ~= identifier then
        showNotification(src, translate.NOT_OWNER)
        TriggerClientEvent("s_blackmarket:Error", src, translate.NOT_OWNER)
        return
    end

    -- remove item from market
    local value = real_item.price * real_item.solds
    local bkp_solds = real_item.solds
    real_item.solds = 0

    -- add money
    addBankMoney(src, value)

    if real_item.amount == 0 then
        _deleteTableMarket(real_item.id, function()
            showNotification(src, translate.RECEIVED_SUCCESSFULL)
            TriggerClientEvent("s_blackmarket:FinishedTransaction", src)
        end)

        table.remove(products, index_array)
    else
        _updateTableMarket(real_item.id, real_item.amount, real_item.solds,
        function()
            showNotification(src, translate.RECEIVED_SUCCESSFULL)
            TriggerClientEvent("s_blackmarket:FinishedTransaction", src)
        end)
    end

    local message = "**RECEVEID MONEY**\nPlayer:"..real_item.owner.."\nIdentifier:"..real_item.identifier.."\n Item: "..real_item.label.."\n Amount: "..bkp_solds.."\n Value: "..value.."."
    sendWebhook(message)
end)

RegisterNetEvent('s_blackmarket:RemoveItem', function(data)
    local src = source

    local identifier = getIdentifier(src)
    
    local item = data.product

    local real_item, index_array = GetProduct(item.id)

    -- check if item is in market
    if not real_item or real_item.amount <= 0 then
        showNotification(src, translate.NO_EXIST)
        TriggerClientEvent("s_blackmarket:Error", src, translate.NO_EXIST)
        return
    end

    -- check if is owner
    if real_item.identifier ~= identifier then
        showNotification(src, translate.NOT_OWNER)
        TriggerClientEvent("s_blackmarket:Error", src, translate.NOT_OWNER)
        return
    end

     -- check can carry item
        if not canCarryItem(src, real_item.name, real_item.amount) then
            showNotification(src, translate.CANT_CARRY_ITEM)
            TriggerClientEvent("s_blackmarket:Error", src, translate.CANT_CARRY_ITEM)
            return
        end

    -- add to player and remove item from market
    addInventoryItem(src, real_item.name, real_item.amount)
    bkp_amount = real_item.amount
    real_item.amount = 0

    if real_item.amount == 0 and real_item.solds == 0 then
        _deleteTableMarket(real_item.id, function()
            showNotification(src, translate.REMOVE_SUCCESSFULL)
            TriggerClientEvent("s_blackmarket:FinishedTransaction", src)
        end)

        table.remove(products, index_array)
    else
        _updateTableMarket(real_item.id, real_item.amount, real_item.solds,
        function()
            showNotification(src, translate.REMOVE_SUCCESSFULL)
            TriggerClientEvent("s_blackmarket:FinishedTransaction", src)
        end)
    end
    local message = "**REMOVED ITEM**\nOwner:"..real_item.owner.."\nIdentifier:"..real_item.identifier.."\n Item: "..real_item.label.."\n Amount: "..bkp_amount.."."
    sendWebhook(message)
end)

RegisterNetEvent('s_blackmarket:showNotification', function(message)
    local src = source
    showNotification(src, message)
end)

function GetSourceByIdentifier(identifier)
    for i,k in pairs(GetPlayers()) do        
        local player_identifier = getIdentifier(tonumber(k))

        if player_identifier == identifier then
            return k
        end
    end

    return nil
end

function IsItemBlackList(name)
    for i,k in pairs(Config.BlackMarketItems) do
        if k == name then
            return true
        end
    end

    return false
end

function GetSoldsPlayer(source)
    local identifier = getIdentifier(source)
    local solds = {}
    local value = 0
    
    for i,k in pairs(products) do
        if k.identifier == identifier and k.solds > 0 then
            table.insert(solds, k)
            value = value + (k.price * k.solds)
        end
    end

    return solds, value
end

function GetAnnouncementsPlayer(source)
    local identifier = getIdentifier(source)
    local advertises = {}
    
    for i,k in pairs(products) do
        if k.identifier == identifier and k.amount > 0 then
            table.insert(advertises, k)
        end
    end

    return advertises
end

function GetProduct(id)
    for i,k in pairs(products) do
        if k.id == id then
            return k, i
        end
    end

    return nil
end

function HasAdvertisedItem(source, name)
    local identifier = getIdentifier(source)

    for i,k in pairs(products) do
        if k.identifier == identifier and k.name == name then
            return true
        end
    end

    return false
end

function HasItem(source, name, amount)
    local inventory = getInventory(source)

    for i,k in pairs(inventory) do
        if k.name == name and k.amount >= amount then
            return true
        end
    end

    return false
end

--------------- DISCORD

function sendWebhook(message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**S_BLACKMARKET**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end





        LG_MySQL = {}

function _createTableMarket(cb)
    LG_MySQL.Execute("CREATE TABLE IF NOT EXISTS s_blackmarket(id int AUTO_INCREMENT, name varchar(100), label varchar(100), amount int DEFAULT 1, weight varchar(10), price int, solds int DEFAULT 0, owner varchar(100), identifier varchar(200), PRIMARY KEY(id))", {}, cb)
end

function _selectTableMarket(cb)
    LG_MySQL.FetchAll('SELECT * FROM s_blackmarket', {}, cb)
end

function _updateTableMarket(id, amount, solds, cb)
    LG_MySQL.Update('UPDATE s_blackmarket SET amount = @amount, solds = @solds WHERE id = @id', {
        ['@amount'] = amount,
        ['@solds'] = solds,
        ['@id'] = id
    }, cb)
end

function _deleteTableMarket(id, cb)
    LG_MySQL.Update('DELETE FROM s_blackmarket WHERE id = @id', {
        ['@id'] = id
    }, cb)
end

function _insertTableMarket(name, label, amount, weight, price, solds, owner, identifier, cb)
    LG_MySQL.Insert('INSERT INTO s_blackmarket (name, label, amount, weight, price, solds, owner, identifier) VALUES (@name, @label, @amount, @weight, @price, @solds, @owner, @identifier)',{
        ['@name'] = name, 
        ['@label'] = label, 
        ['@amount'] = amount, 
        ['@weight'] = weight, 
        ['@price'] = price, 
        ['@solds'] = solds, 
        ['@owner'] = owner, 
        ['@identifier'] = identifier
    }, cb)
end

-- Framework integration created by Legendary Team
function LG_MySQL.Execute(query, data, callback)
    MySQL.Async.execute(query, data, callback)
end     

-- Framework integration created by Legendary Team
function LG_MySQL.FetchAll(query, data, callback)
    MySQL.Async.fetchAll(query, data, callback)
end     

-- Framework integration created by Legendary Team
function LG_MySQL.Update(query, data, callback)
    MySQL.Async.execute(query, data, callback)
end   

-- Framework integration created by Legendary Team
function LG_MySQL.Insert(query, data, callback)
    MySQL.Async.insert(query, data, callback)
end  
