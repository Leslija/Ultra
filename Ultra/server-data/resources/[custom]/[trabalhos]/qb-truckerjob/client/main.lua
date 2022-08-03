local QBCore = exports['qb-core']:GetCoreObject()
local PlayerGang = {}
local JobsDone = 0
local LocationsDone = {}
local CurrentLocation = nil
local CurrentBlip = nil
local hasBox = false
local isWorking = false
local currentCount = 0
local CurrentPlate = nil
local selectedVeh = nil
local TruckVehBlip = nil
local ThreadAlreadyRan = false

-- Functions

local function hasDoneLocation(locationId)
    local retval = false
    if LocationsDone ~= nil and next(LocationsDone) ~= nil then
        for k, v in pairs(LocationsDone) do
            if v == locationId then
                retval = true
            end
        end
    end
    return retval
end

local function getNextClosestLocation()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = 0
    local dist = nil

    for k, _ in pairs(Config.Locations["stores"]) do
        if current ~= 0 then
            if #(pos - vector3(Config.Locations["stores"][k].coords.x, Config.Locations["stores"][k].coords.y, Config.Locations["stores"][k].coords.z)) < dist then
                if not hasDoneLocation(k) then
                    current = k
                    dist = #(pos - vector3(Config.Locations["stores"][k].coords.x, Config.Locations["stores"][k].coords.y, Config.Locations["stores"][k].coords.z))
                end
            end
        else
            if not hasDoneLocation(k) then
                current = k
                dist = #(pos - vector3(Config.Locations["stores"][k].coords.x, Config.Locations["stores"][k].coords.y, Config.Locations["stores"][k].coords.z))
            end
        end
    end

    return current
end

local function getNewLocation()
    local location = getNextClosestLocation()
    if location ~= 0 then
        CurrentLocation = {}
        CurrentLocation.id = location
        CurrentLocation.dropcount = math.random(1, 3)
        CurrentLocation.store = Config.Locations["stores"][location].name
        CurrentLocation.x = Config.Locations["stores"][location].coords.x
        CurrentLocation.y = Config.Locations["stores"][location].coords.y
        CurrentLocation.z = Config.Locations["stores"][location].coords.z

        CurrentBlip = AddBlipForCoord(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)
        SetBlipColour(CurrentBlip, 3)
        SetBlipRoute(CurrentBlip, true)
        SetBlipRouteColour(CurrentBlip, 3)
    else
        QBCore.Functions.Notify("Foste a todo o lado .. É hora de receber o pagamento!")
        if CurrentBlip ~= nil then
            RemoveBlip(CurrentBlip)
	    ClearAllBlipRoutes()
            CurrentBlip = nil
        end
    end
end

local function isTruckerVehicle(vehicle)
    local retval = false
    for k, v in pairs(Config.Vehicles) do
        if GetEntityModel(vehicle) == GetHashKey(k) then
            retval = true
        end
    end
    return retval
end

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function RemoveTruckerBlips()
    if TruckVehBlip ~= nil then
        RemoveBlip(TruckVehBlip)
	ClearAllBlipRoutes()
        TruckVehBlip = nil
    end

    if CurrentBlip ~= nil then
        RemoveBlip(CurrentBlip)
	ClearAllBlipRoutes()
        CurrentBlip = nil
    end
end

-- Old Menu Code (being removed)

local function MenuGarage()
    local truckMenu = {
        {
            header = "Carrinhas Disponiveis",
            isMenuHeader = true
        }
    }
    for k, v in pairs(Config.Vehicles) do
        truckMenu[#truckMenu+1] = {
            header = Config.Vehicles[k],
            params = {
                event = "qb-trucker:client:TakeOutVehicle",
                args = {
                    vehicle = k
                }
            }
        }
    end

    truckMenu[#truckMenu+1] = {
        header = "⬅ Fechar Menu",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(truckMenu)
end


local function CloseMenuFull()
    exports['qb-menu']:closeMenu()
end

-- Events

RegisterNetEvent('qb-trucker:client:SpawnVehicle', function()
    local vehicleInfo = selectedVeh
    local coords = Config.Locations["vehicle"].coords
    coords = vector3(coords.x, coords.y, coords.z)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if #(pos - coords) <= 3 then
        QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
            SetVehicleNumberPlateText(veh, "CCCR"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['s_fuel']:SetFuel(veh, 100.0)
            CloseMenuFull()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            SetEntityAsMissionEntity(veh, true, true)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            CurrentPlate = QBCore.Functions.GetPlate(veh)
            getNewLocation()
        end, coords, true)
    else
        QBCore.Functions.Notify('Estás muito longe', 'error')
    end

end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerGang = QBCore.Functions.GetPlayerData().gang
    CurrentLocation = nil
    CurrentBlip = nil
    hasBox = false
    isWorking = false
    JobsDone = 0

    if PlayerGang.name == "trucker" then
        TruckVehBlip = AddBlipForCoord(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)
        SetBlipSprite(TruckVehBlip, 326)
        SetBlipDisplay(TruckVehBlip, 4)
        SetBlipScale(TruckVehBlip, 0.5)
        SetBlipAsShortRange(TruckVehBlip, true)
        SetBlipColour(TruckVehBlip, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].label)
        EndTextCommandSetBlipName(TruckVehBlip)

        RunWorkThread()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    RemoveTruckerBlips()
    CurrentLocation = nil
    CurrentBlip = nil
    hasBox = false
    isWorking = false
    JobsDone = 0
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(InfoGang)
    local OldPlayerGang = PlayerGang.name
    PlayerGang = InfoGang

    if PlayerGang.name == "trucker" then
        TruckVehBlip = AddBlipForCoord(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)
        SetBlipSprite(TruckVehBlip, 326)
        SetBlipDisplay(TruckVehBlip, 4)
        SetBlipScale(TruckVehBlip, 0.5)
        SetBlipAsShortRange(TruckVehBlip, true)
        SetBlipColour(TruckVehBlip, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].label)
        EndTextCommandSetBlipName(TruckVehBlip)

        RunWorkThread()
    elseif OldPlayerGang == "trucker" then
        RemoveTruckerBlips()
    end
end)

RegisterNetEvent('qb-trucker:client:TakeOutVehicle', function(data)
    local coords = Config.Locations["vehicle"].coords
    coords = vector3(coords.x, coords.y, coords.z)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if #(pos - coords) <= 5 then
        local vehicleInfo = data.vehicle
        TriggerServerEvent('qb-trucker:server:DoBail', true, vehicleInfo)
        selectedVeh = vehicleInfo
    else
        QBCore.Functions.Notify('Estás muito longe', 'error')
    end
end)

RegisterNetEvent('qb-trucker:client:SelectVehicle', function()
    local coords = Config.Locations["vehicle"].coords
    coords = vector3(coords.x, coords.y, coords.z)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if #(pos - coords) <= 5 then
        MenuGarage()
    else
        QBCore.Functions.Notify('Estás muito longe', 'error')
    end
end)

-- Threads
function RunWorkThread()
    if not ThreadAlreadyRan then
        ThreadAlreadyRan = true
        CreateThread(function()
            local shownHeader = false
            local TruckerBlip = AddBlipForCoord(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z)
            SetBlipSprite(TruckerBlip, 479)
            SetBlipDisplay(TruckerBlip, 4)
            SetBlipScale(TruckerBlip, 0.5)
            SetBlipAsShortRange(TruckerBlip, true)
            SetBlipColour(TruckerBlip, 5)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Locations["main"].label)
            EndTextCommandSetBlipName(TruckerBlip)

            while LocalPlayer.state.isLoggedIn and PlayerGang.name == "trucker" do
                local sleep = 1000
                local pos = GetEntityCoords(PlayerPedId())
                local vehicleCoords = vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)
                local mainCoords = vector3(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z)

                if IsControlJustReleased(0, 178) then
                    if IsPedInAnyVehicle(PlayerPedId()) and isTruckerVehicle(GetVehiclePedIsIn(PlayerPedId(), false)) then
                        getNewLocation()
                        CurrentPlate = QBCore.Functions.GetPlate(GetVehiclePedIsIn(PlayerPedId(), false))
                    end
                end

                if #(pos - vehicleCoords) <= 5.0 then
                    local x = vehicleCoords.x
                    local y = vehicleCoords.y
                    local z = vehicleCoords.z

                    DrawMarker(2, x,y,z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 0, 248, 185, 222, false, false, false, true, false, false, false)
                    if #(pos - vehicleCoords) <= 1.5 then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            DrawText3D(x,y,z, "~b~E~w~ - Guardar Veículo")
                        else
                            if not shownHeader then
                                shownHeader = true
                                exports['qb-menu']:showHeader({
                                    {
                                        header = "Selecionar Veículo",
                                        params = {
                                            event = 'qb-trucker:client:SelectVehicle',
                                            args = {}
                                        },
                                    }
                                })
                            end

                        end

                        if IsControlJustReleased(0, 38) then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                                    if isTruckerVehicle(GetVehiclePedIsIn(PlayerPedId(), false)) then
                                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                        TriggerServerEvent('qb-trucker:server:DoBail', false)
                                    else
                                        QBCore.Functions.Notify('Humm não é este o veículo! Andas-te a beber?', 'error')
                                    end
                                else
                                    QBCore.Functions.Notify('Tens que ser o condutor para fazer isto..')
                                end
                            end
                        end
                    end
                    sleep = 5
                else
                    if shownHeader then
                        shownHeader = false
                        exports['qb-menu']:closeMenu()
                    end
                end

                if #(pos - mainCoords) < 4.5 then
                    if #(pos - mainCoords) < 1.5 then
                        local x = mainCoords.x
                        local y = mainCoords.y
                        local z = mainCoords.z

                        DrawText3D(x,y,z, "~b~E~w~ - Folha de Pagamento")
                        if IsControlJustReleased(0, 38) then
                            if JobsDone > 0 then
                                TriggerServerEvent("qb-trucker:server:01101110", JobsDone)
                                JobsDone = 0
                                if #LocationsDone == #Config.Locations["stores"] then
                                    LocationsDone = {}
                                end
                                if CurrentBlip ~= nil then
                                    RemoveBlip(CurrentBlip)
                                    ClearAllBlipRoutes()
                                    CurrentBlip = nil
                                end
                            else
                                QBCore.Functions.Notify("Ainda não fizes-te nada..", "error")
                            end
                        end
                    elseif #(pos - mainCoords) < 2.5 then
                        DrawText3D(x, y, z, "Folha de Pagamento")
                    end
                    sleep = 5
                end

                if CurrentLocation ~= nil  and currentCount < CurrentLocation.dropcount then
                    if #(pos - vector3(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)) < 40.0 and not IsPedInAnyVehicle(PlayerPedId()) then
                        sleep = 5
                        if not hasBox then
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                            if isTruckerVehicle(vehicle) and CurrentPlate == QBCore.Functions.GetPlate(vehicle) then
                                local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                                if #(pos - vector3(trunkpos.x, trunkpos.y, trunkpos.z)) < 1.5 and not isWorking then
                                    DrawText3D(trunkpos.x, trunkpos.y, trunkpos.z, "~b~E~w~ - Apanhar Produtos")
                                    if IsControlJustReleased(0, 38) then
                                        isWorking = true
                                        QBCore.Functions.Progressbar("work_carrybox", "Entregar Caixa de Produtos", 2000, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = "anim@gangops@facility@servers@",
                                            anim = "hotwire",
                                            flags = 16,
                                        }, {}, {}, function() -- Done
                                            isWorking = false
                                            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                            TriggerEvent('animations:client:EmoteCommandStart', {"box"})
                                            hasBox = true
                                        end, function() -- Cancel
                                            isWorking = false
                                            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                            QBCore.Functions.Notify("Cancelado", "error")
                                        end)
                                    end
                                else
                                    DrawText3D(trunkpos.x, trunkpos.y, trunkpos.z, "Apanhar Produtos")
                                end
                            end
                        elseif hasBox then
                            if #(pos - vector3(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)) < 1.5 and not isWorking then
                                DrawText3D(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z, "~b~E~w~ - Entregar Produtos")
                                if IsControlJustReleased(0, 38) then
                                    isWorking = true
                                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                                    Wait(500)
                                    TriggerEvent('animations:client:EmoteCommandStart', {"bumbin"})
                                    QBCore.Functions.Progressbar("work_dropbox", "A entregar produtos", 2000, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {}, {}, {}, function() -- Done
                                        isWorking = false
                                        ClearPedTasks(PlayerPedId())
                                        hasBox = false
                                        currentCount = currentCount + 1
                                        if currentCount == CurrentLocation.dropcount then
                                            LocationsDone[#LocationsDone+1] = CurrentLocation.id
                                            TriggerServerEvent("qb-shops:server:RestockShopItems", CurrentLocation.store)
                                            QBCore.Functions.Notify("Entregas-te todos os produtos, vamos para a próxima")
                                            local chance = math.random(1,100)
                                            if chance < 26 then
                                                TriggerServerEvent('qb-trucker:server:nano')
                                            end
                                            if CurrentBlip ~= nil then
                                                RemoveBlip(CurrentBlip)
                                                ClearAllBlipRoutes()
                                                CurrentBlip = nil
                                            end
                                            CurrentLocation = nil
                                            currentCount = 0
                                            JobsDone = JobsDone + 1
                                            getNewLocation()
                                        end
                                    end, function() -- Cancel
                                        isWorking = false
                                        ClearPedTasks(PlayerPedId())
                                        QBCore.Functions.Notify("Cancelado", "error")
                                    end)
                                end
                            else
                                DrawText3D(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z, "Entregar Produtos")
                            end
                        end
                    end
                end

                Wait(sleep)
            end

            ThreadAlreadyRan = false
        end)
    end
end