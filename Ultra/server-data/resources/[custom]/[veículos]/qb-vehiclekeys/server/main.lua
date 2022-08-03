-----------------------
----   Variables   ----
-----------------------
local QBCore = exports['qb-core']:GetCoreObject()
local VehicleList = {}

-----------------------
----   Threads     ----
-----------------------

-----------------------
---- Server Events ----
-----------------------

-- Event to give keys. receiver can either be a single id, or a table of ids.
-- Must already have keys to the vehicle, trigger the event from the server, or pass forcegive paramter as true.
RegisterNetEvent('qb-vehiclekeys:server:GiveVehicleKeys', function(receiver, plate)
    local giver = source

    if HasKeys(giver, plate) then
        TriggerClientEvent('QBCore:Notify', giver, "Des-te as chaves.", 'success')
        if type(receiver) == 'table' then
            for _,r in ipairs(receiver) do
                GiveKeys(receiver[r], plate)
            end
        else
            GiveKeys(receiver, plate)
        end
    else
        TriggerClientEvent('QBCore:Notify', giver, "Não tens chaves.", "error")
    end
end)

RegisterNetEvent('qb-vehiclekeys:server:AcquireVehicleKeys', function(plate)
    local src = source
    GiveKeys(src, plate)
end)

QBCore.Functions.CreateCallback('qb-vehiclekeys:server:GetVehicleKeys', function(source, cb)
    local citizenid = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
    local keysList = {}
    for plate, citizenids in pairs (VehicleList) do
        if citizenids[citizenid] then
            keysList[plate] = true
        end
    end
    cb(keysList)
end)

-----------------------
----   Functions   ----
-----------------------

function GiveKeys(id, plate)
    local citizenid = QBCore.Functions.GetPlayer(id).PlayerData.citizenid

    if not VehicleList[plate] then VehicleList[plate] = {} end
    VehicleList[plate][citizenid] = true
    
    TriggerClientEvent('QBCore:Notify', id, "Recebes-te as chaves do veículo!")
    TriggerClientEvent('qb-vehiclekeys:client:AddKeys', id, plate)
end

function RemoveKeys(id, plate)
    local citizenid = QBCore.Functions.GetPlayer(id).PlayerData.citizenid

    if VehicleList[plate] and VehicleList[plate][citizenid] then
        VehicleList[plate][citizenid] = nil
    end

    TriggerClientEvent('qb-vehiclekeys:client:RemoveKeys', id, plate)
end

function HasKeys(id, plate)
    local citizenid = QBCore.Functions.GetPlayer(id).PlayerData.citizenid
    if VehicleList[plate] and VehicleList[plate][citizenid] then
        return true
    end
    return false
end

QBCore.Commands.Add("motor", "Ligar / Desligar Motor", {}, false, function(source)
	TriggerClientEvent('qb-vehiclekeys:client:ToggleEngine', source)
end)

QBCore.Commands.Add("darchaves", "Dar as chaves do veículo a alguem. Se não colocares ID vai dar à pessoa mais proxima.", {{name = "id", help = "Player ID"}}, false, function(source, args)
	local src = source
    TriggerClientEvent('qb-vehiclekeys:client:GiveKeys', src, tonumber(args[1]))
end)

QBCore.Commands.Add("adicionarchaves", "Adiciona as chaves para um veiculo a alguem.", {{name = "id", help = "Player ID"}, {name = "plate", help = "Plate"}}, true, function(source, args)
	local src = source
    if not args[1] or not args[2] then
        TriggerClientEvent('QBCore:Notify', src, 'Preenche o ID e a matricula.')
        return
    end
    GiveKeys(tonumber(args[1]), args[2])
end, 'admin')

QBCore.Commands.Add("removekeys", "Remover chaves de um veiculo.", {{name = "id", help = "Player ID"}, {name = "plate", help = "Plate"}}, true, function(source, args)
	local src = source
    if not args[1] or not args[2] then
        TriggerClientEvent('QBCore:Notify', src, 'Preenche o ID e a matricula.')
        return
    end
    RemoveKeys(tonumber(args[1]), args[2])
end, 'admin')