local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-spawn:server:getOwnedHouses', function(source, cb, cid)
    if cid ~= nil then
        local houses = exports.oxmysql:executeSync('SELECT * FROM player_houses WHERE citizenid = ?', {cid})
        if houses[1] ~= nil then
            cb(houses)
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)


QBCore.Functions.CreateCallback('qb-spawn:server:getLasPosition', function(source, cb, cid)
    if cid ~= nil then
        
        cb(nil)
        print("ccc")
    else
        local location = exports.oxmysql:executeSync('SELECT * FROM players WHERE position = ?', {cid})
        if location[1] ~= nil then
            cb(nil)
            print(location)
        else
            cb(location)
            print(json.encode(location))

        end
    end
end)