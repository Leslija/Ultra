QBCore = exports['qb-core']:GetCoreObject()
local isRoll = false
local amount = Config.Amount

RegisterServerEvent('qb-casinowheel:getLucky', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not isRoll then
        if Player ~= nil then
            local chips = Player.Functions.GetItemByName('casinochips')
            if chips ~= nil and chips.amount >= amount then
                Player.Functions.RemoveItem('casinochips', amount)
                isRoll = true

                local _randomPrice = math.random(1, 100)
                if _randomPrice == 1 then
                    -- Win car
                    local _subRan = math.random(1,1000)
                    if _subRan <= 1 then
                        _priceIndex = 19
                    else
                        _priceIndex = 3
                    end
                elseif _randomPrice > 1 and _randomPrice <= 6 then
                    -- Win skin AK Gold
                    _priceIndex = 12
                    local _subRan = math.random(1,20)
                    if _subRan <= 2 then
                        _priceIndex = 12
                    else
                        _priceIndex = 7
                    end
                elseif _randomPrice > 6 and _randomPrice <= 15 then
                    -- Black money
                    -- 4, 8, 11, 16
                    local _sRan = math.random(1, 4)
                    if _sRan == 1 then
                        _priceIndex = 4
                    elseif _sRan == 2 then
                        _priceIndex = 8
                    elseif _sRan == 3 then
                        _priceIndex = 11
                    else
                        _priceIndex = 16
                    end
                elseif _randomPrice > 15 and _randomPrice <= 25 then
                    -- Win 300,000$
                    -- _priceIndex = 5
                    local _subRan = math.random(1,20)
                    if _subRan <= 2 then
                        _priceIndex = 5
                    else
                        _priceIndex = 20
                    end
                elseif _randomPrice > 25 and _randomPrice <= 40 then
                    -- 1, 9, 13, 17
                    local _sRan = math.random(1, 4)
                    if _sRan == 1 then
                        _priceIndex = 1
                    elseif _sRan == 2 then
                        _priceIndex = 9
                    elseif _sRan == 3 then
                        _priceIndex = 13
                    else
                        _priceIndex = 17
                    end
                elseif _randomPrice > 40 and _randomPrice <= 60 then
                    local _itemList = {}
                    _itemList[1] = 2
                    _itemList[2] = 6
                    _itemList[3] = 10
                    _itemList[4] = 14
                    _itemList[5] = 18
                    _priceIndex = _itemList[math.random(1, 5)]
                elseif _randomPrice > 60 and _randomPrice <= 100 then
                    local _itemList = {}
                    _itemList[1] = 3
                    _itemList[2] = 7
                    _itemList[3] = 15
                    _itemList[4] = 20
                    _priceIndex = _itemList[math.random(1, 4)]
                end
                print("Price " .. _priceIndex)
                SetTimeout(5000, function()
                    isRoll = false
                    -- Give Price
                    if _priceIndex == 1 or _priceIndex == 9 or _priceIndex == 13 or _priceIndex == 17 then
                        Player.Functions.AddItem("casinochips", 25000)
                        TriggerClientEvent('QBCore:Notify', src, 'Ganhas-te 25,000 fichas do casino!', 'success')
                    elseif _priceIndex == 2 or _priceIndex == 6 or _priceIndex == 10 or _priceIndex == 14 or _priceIndex == 18 then
                        Player.Functions.AddItem("sandwich", 10)
                        Player.Functions.AddItem("water_bottle", 24)
                        TriggerClientEvent('QBCore:Notify', src, 'Uma agua e uma sandes??', 'success')
                    elseif _priceIndex == 3 or _priceIndex == 7 or _priceIndex == 15 or _priceIndex == 20 then
                        local _money = 0
                        if _priceIndex == 3 then
                            _money = 20000
                        elseif _priceIndex == 7 then
                            _money = 30000
                        elseif _priceIndex == 15 then
                            _money = 40000
                        elseif _priceIndex == 20 then
                            _money = 50000
                        end
                        Player.Functions.AddMoney('cash', _money)
                        TriggerClientEvent('QBCore:Notify', src, 'Ganhas-te '.._money..'€ !', 'success')
                    elseif _priceIndex == 4 or _priceIndex == 8 or _priceIndex == 11 or _priceIndex == 16 then
                        local _blackMoney = 0
                        if _priceIndex == 4 then
                            _blackMoney = 10000
                        elseif _priceIndex == 8 then
                            _blackMoney = 15000
                        elseif _priceIndex == 11 then
                            _blackMoney = 20000
                        elseif _priceIndex == 16 then
                            _blackMoney = 25000
                        end
                        Player.Functions.AddItem("markedbills", _blackMoney * 10)
                        TriggerClientEvent('QBCore:Notify', src, 'Ganhas-te notas marcadas!', 'success')
                    elseif _priceIndex == 5 then
                        -- print("Win 300,000$")
                        Player.Functions.AddMoney('cash', 300000)
                        TriggerClientEvent('QBCore:Notify', src, 'Ganhas-te 300,000€!', 'success')
                    elseif _priceIndex == 12 then
                        -- print("Win ak gold")
                        Player.Functions.AddItem("weapon_pistol50", 1)
                        TriggerClientEvent('QBCore:Notify', src, 'Ganhas-te uma pistola!', 'success')
                    elseif _priceIndex == 19 then
                        -- print("Win car lp700r")
                        TriggerClientEvent("qb-casinowheel:winCar", src)
                        TriggerClientEvent('QBCore:Notify', src, 'Ganhas-te um carro!', 'success')
                    end
                    TriggerClientEvent("qb-casinowheel:rollFinished", -1)
                end)
                TriggerClientEvent("qb-casinowheel:doRoll", -1, _priceIndex)
            else
                TriggerClientEvent("qb-casinowheel:rollFinished", -1)    
                TriggerClientEvent('QBCore:Notify', src, 'Precisas de '..amount..' para rodar!', 'error')
            end
        end
    end
end)
