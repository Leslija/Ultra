local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent("qs-tattoos:GetTattoos")
AddEventHandler("qs-tattoos:GetTattoos", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    MySQL.Async.fetchAll("SELECT * FROM tattoos where identifier = @identifier",
    {['@identifier'] = Player.PlayerData.citizenid},
    function(result)
        if result and #result > 0 then
            for i,k in pairs(result) do
                k.tattoos = json.decode(k.tattoos)
            end
            TriggerClientEvent("qs-tattoos:TattoosGeted", src, result[1].tattoos)
        else
            TriggerClientEvent("qs-tattoos:TattoosGeted", src, {})
        end
    end)  
end)

RegisterNetEvent("qs-tattoos:RegisterTattoos")
AddEventHandler("qs-tattoos:RegisterTattoos", function(tattoos, total_price, free)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local MoneyPlayer = Player.PlayerData.money['bank']

    if (total_price == 0 or MoneyPlayer >= total_price) or free then
        MySQL.Async.execute('UPDATE tattoos SET tattoos = @tattoos WHERE identifier = @identifier', {
            ['@tattoos'] = json.encode(tattoos), 
            ['@identifier'] = Player.PlayerData.citizenid
        }, function (rows)
            if rows == 0 then
                MySQL.Async.execute('INSERT INTO tattoos (identifier, tattoos) VALUES (@identifier, @tattoos)', {
                    ['@identifier'] = Player.PlayerData.citizenid,
                    ['@tattoos'] = json.encode(tattoos)
                }, function (rows)
                    if not free then 
                        Player.Functions.RemoveMoney('bank', total_price)
                        -- Insert your function to remove money here (variable: total_price)
                    end
                    TriggerClientEvent("qs-tattoos:ClosedStore", src, tattoos, total_price)
                end)
            else
                if not free then 
                    Player.Functions.RemoveMoney('bank', total_price)
                    -- Insert your function to remove money here (variable: total_price)
                end
                TriggerClientEvent("qs-tattoos:ClosedStore", src, tattoos, total_price)
            end
        end)
    else
        TriggerClientEvent("qs-tattoos:ClosedStore", src, -1, -1)
    end
end)



function GetLicenseFiveM(source)
    local licenca = GetPlayerIdentifiers(source)
    for _, v in pairs(licenca) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            licenca = v
            break
        end
    end 
    return licenca
end