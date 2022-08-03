isCreatingGang = false
hasStash = false
hasGarage = false
gang = nil
name = nil
label = nil


local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-gangs:client:BeginGangCreation")
AddEventHandler("qb-gangs:client:BeginGangCreation", function(gangName, gangLabel)
    name = gangName
    label = gangLabel
    gang = {
        ["VehicleSpawner"] = {},
        ["Stash"] = {}
    }
    isCreatingGang = true
    TriggerEvent("chatMessage", "SYSTEM", "warning", "Nova org: "..gangName.." adicionada, usa /orgcofre, /orggaragem,  /terminarorg or /cancelarorg")
end)

RegisterCommand("orgcofre", function()
    if isCreatingGang then
        if not hasStash then
            local plyCoords = GetEntityCoords(PlayerPedId())
            
            gang["Stash"] = {
                label = name.." Cofre",
                coords = {x = plyCoords.x, y = plyCoords.y, z = plyCoords.z, h = GetEntityHeading(PlayerPedId())}    
            }

            hasStash = true
            QBCore.Functions.Notify("Cofre colocado", "success")
        else
            QBCore.Functions.Notify("Tu já colocas-te o cofre", "error")
        end
    else
        QBCore.Functions.Notify("Não estás a criar nenhuma org", "error")
    end
end)

RegisterCommand("orggaragem", function()
    if isCreatingGang then
        if not hasGarage then
            -- NUI To handle colour picker and vehicle selection
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = "open"
            })
        else
            QBCore.Functions.Notify("Já colocas-te a garagem", "error")
        end
    else
        QBCore.Functions.Notify("Não estás a criar nenhuma org", "error")
    end
end)

RegisterCommand("terminarorg", function()
    if isCreatingGang then
        if hasGarage and hasStash then
            TriggerServerEvent("qb-gangs:server:creategang", gang, name, label)
            gang = nil
            hasGarage, hasStash = false, false
        else
            QBCore.Functions.Notify("Ainda não terminas-te", "error")
        end
    else
        QBCore.Functions.Notify("Não estás a criar nenhuma org", "error")
    end
end)

RegisterCommand("cancelarorg", function()
    if isCreatingGang then
        isCreatingGang, hasGarage, hasStash = false, false, false
        gang, name, label = nil, nil, nil
    else
        QBCore.Functions.Notify("Não estás a criar nenhuma org", "error")
    end
end)

RegisterNUICallback("SetVehicleColour", function(data, cb)
    SetNuiFocus(false, false)
    -- Recieve arrays for colours and vehicles, js handlers spliting into arrays
    local primary = data.primary
    local secondary = data.secondary
    local vehicleList = data.vehicleList

    print(json.encode(vehicleList))

    local coords = GetEntityCoords(PlayerPedId())
    
    gang["VehicleSpawner"] = {
        label = "Veiculos",
        coords = {x = coords.x, y = coords.y, z = coords.z, h = GetEntityHeading(PlayerPedId())},
        colours = {
            ["primary"] = {
                r = tonumber(primary[1]),
                g = tonumber(primary[2]), 
                b = tonumber(primary[3])
            },
            ["secondary"] = { 
                r = tonumber(secondary[1]),
                g = tonumber(secondary[2]), 
                b = tonumber(secondary[3])
            },
        },
        vehicles = {}
    }

    -- Iterate through vehicles array, check they are valid and insert into gang vehicles
    for k, v in pairs(vehicleList) do
    if QBCore.Shared.Vehicles[v] ~= nil then
            local name = QBCore.Shared.Vehicles[v].name
            gang["VehicleSpawner"]["vehicles"][v] = name
        else
            QBCore.Functions.Notify(v.." não existe em qb-core/shared-modules/vehicles.lua", "error")
        end
    end

    hasGarage = true
    QBCore.Functions.Notify("Garagem colocada", "success")
end)

RegisterNUICallback("CloseMenu", function(source, cb)
    SetNuiFocus(false, false)
end)