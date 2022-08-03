local CurrentDivingLocation = {
    Area = 0,
    Blip = {
        Radius = nil,
        Label = nil
    }
}

local currentGear = {
    mask = 0,
    tank = 0,
    enabled = false
}

-- Functions

local function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(0)
    end
end


local function DeleteGear()
	if currentGear.mask ~= 0 then
        DetachEntity(currentGear.mask, 0, 1)
        DeleteEntity(currentGear.mask)
		currentGear.mask = 0
    end

	if currentGear.tank ~= 0 then
        DetachEntity(currentGear.tank, 0, 1)
        DeleteEntity(currentGear.tank)
		currentGear.tank = 0
	end
end

local function GearAnim()
    loadAnimDict("clothingshirt")
	TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

-- Events

-- GALAO

RegisterNetEvent('qb-diving:client:UseJerrycan', function()
    local ped = PlayerPedId()
    local boat = IsPedInAnyBoat(ped)
    if boat then
        local curVeh = GetVehiclePedIsIn(ped, false)
        QBCore.Functions.Progressbar("reful_boat", "A reabastecer barco ..", 20000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            exports['s_fuel']:SetFuel(curVeh, 100)
            QBCore.Functions.Notify('O barco foi reabastecido', 'success')
            TriggerServerEvent('qb-diving:server:RemoveItem', 'jerry_can', 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['jerry_can'], "remove")
        end, function() -- Cancel
            QBCore.Functions.Notify('Cancelado!', 'error')
        end)
    else
        QBCore.Functions.Notify('Não estás em nenhum barco', 'error')
    end
end)

--- GALAO

RegisterNetEvent('qb-diving:client:UseGear', function(bool)
    if bool then
        GearAnim()
        QBCore.Functions.Progressbar("equip_gear", "A colocar equipamento mergulho", 5000, false, true, {}, {}, {}, {}, function() -- Done
            DeleteGear()
            local maskModel = `p_d_scuba_mask_s`
            local tankModel = `p_s_scuba_tank_s`

            RequestModel(tankModel)
            while not HasModelLoaded(tankModel) do
                Wait(1)
            end
            TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
            local bone1 = GetPedBoneIndex(PlayerPedId(), 24818)
            AttachEntityToEntity(TankObject, PlayerPedId(), bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
            currentGear.tank = TankObject

            RequestModel(maskModel)
            while not HasModelLoaded(maskModel) do
                Wait(1)
            end

            MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
            local bone2 = GetPedBoneIndex(PlayerPedId(), 12844)
            AttachEntityToEntity(MaskObject, PlayerPedId(), bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
            currentGear.mask = MaskObject

            SetEnableScuba(PlayerPedId(), true)
            SetPedMaxTimeUnderwater(PlayerPedId(), 2000.00)
            currentGear.enabled = true
            TriggerServerEvent('qb-diving:server:RemoveGear')
            ClearPedTasks(PlayerPedId())
            TriggerEvent('chatMessage', "DIAMONDRP", "error", "/mergulho para remover equipamento mergulho")
        end)
    else
        if currentGear.enabled then
            GearAnim()
            QBCore.Functions.Progressbar("remove_gear", "A remover equipamento mergulho..", 5000, false, true, {}, {}, {}, {}, function() -- Done
                DeleteGear()

                SetEnableScuba(PlayerPedId(), false)
                SetPedMaxTimeUnderwater(PlayerPedId(), 1.00)
                currentGear.enabled = false
                TriggerServerEvent('qb-diving:server:GiveBackGear')
                ClearPedTasks(PlayerPedId())
                QBCore.Functions.Notify('Removes-te o equipamento mergulho')
            end)
        else
            QBCore.Functions.Notify('Não estás a usar nenhum equipamento de mergulho..', 'error')
        end
    end
end)

RegisterNetEvent('qb-diving:client:RemoveGear', function()	--Add event to call externally
    TriggerEvent('qb-diving:client:UseGear', false)
end)
