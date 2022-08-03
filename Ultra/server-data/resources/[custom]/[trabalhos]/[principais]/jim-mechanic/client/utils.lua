
local QBCore = exports['qb-core']:GetCoreObject()
local pedInSameVehicleLast=false
local vehicle
local lastVehicle
local vehicleClass
local fCollisionDamageMult = 0.0
local fDeformationDamageMult = 0.0
local fEngineDamageMult = 0.0
local fBrakeForce = 1.0
local isBrakingForward = false
local isBrakingReverse = false
local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0
local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0
local healthPetrolTankLast = 1000.0
local healthPetrolTankCurrent = 1000.0
local healthPetrolTankNew = 1000.0
local healthPetrolTankDelta = 0.0
local healthPetrolTankDeltaScaled = 0.0
local tireBurstLuckyNumber


local function CleanVehicle(vehicle)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MAID_CLEAN", 0, true)
	QBCore.Functions.Progressbar("cleaning_vehicle", Lang:t("progress.clean_veh"), math.random(10000, 20000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		QBCore.Functions.Notify(Lang:t("success.cleaned_veh"))
		SetVehicleDirtLevel(vehicle, 0.1)
        SetVehicleUndriveable(vehicle, false)
		WashDecalsFromVehicle(vehicle, 1.0)
		TriggerServerEvent('qb-vehiclefailure:server:removewashingkit', vehicle)
		TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["cleaningkit"], "remove")
		ClearAllPedProps(ped)
		ClearPedTasks(ped)
	end, function() -- Cancel
		QBCore.Functions.Notify(Lang:t("error.failed_notification"), "error")
		ClearAllPedProps(ped)
		ClearPedTasks(ped)
	end)
end


local function RepairVehicleFull(vehicle)
    SetVehicleDoorOpen(vehicle, 4, false, false)
	
	QBCore.Functions.Progressbar("repair_vehicle", Lang:t("progress.repair_veh"), math.random(20000, 30000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
		QBCore.Functions.Notify(Lang:t("success.repaired_veh"))
		SetVehicleEngineHealth(vehicle, 1000.0)
		SetVehicleFixed(vehicle)	
		SetVehicleEngineOn(vehicle, true, false)
		SetVehicleTyreFixed(vehicle, 0)
		SetVehicleTyreFixed(vehicle, 1)
		SetVehicleTyreFixed(vehicle, 2)
		SetVehicleTyreFixed(vehicle, 3)
		SetVehicleTyreFixed(vehicle, 4)
		SetVehicleDoorShut(vehicle, 4, false)
		TriggerServerEvent('qb-vehiclefailure:removeItem', "advancedrepairkit")
	end, function() -- Cancel
		StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
		QBCore.Functions.Notify(Lang:t("error.failed_notification"), "error")
		SetVehicleDoorShut(vehicle, 4, false)
	end)
end

local function RepairVehicle(vehicle)
    SetVehicleDoorOpen(vehicle, 4, false, false)
	QBCore.Functions.Progressbar("repair_vehicle", Lang:t("progress.repair_veh"), math.random(10000, 20000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
		QBCore.Functions.Notify(Lang:t("success.repaired_veh"))
		SetVehicleEngineHealth(vehicle, 500.0)
		SetVehicleFixed(vehicle)	
		SetVehicleEngineOn(vehicle, true, false)
		SetVehicleTyreFixed(vehicle, 0)
		SetVehicleTyreFixed(vehicle, 1)
		SetVehicleTyreFixed(vehicle, 2)
		SetVehicleTyreFixed(vehicle, 3)
		SetVehicleTyreFixed(vehicle, 4)
		SetVehicleDoorShut(vehicle, 4, false)
		TriggerServerEvent('qb-vehiclefailure:removeItem', "repairkit")
	end, function() -- Cancel
		StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
		QBCore.Functions.Notify(Lang:t("error.failed_notification"), "error")
		SetVehicleDoorShut(vehicle, 4, false)
	end)
end

local function isPedDrivingAVehicle()
	local ped = PlayerPedId()
	vehicle = GetVehiclePedIsIn(ped, false)
	if IsPedInAnyVehicle(ped, false) then
		-- Check if ped is in driver seat
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			local class = GetVehicleClass(vehicle)
			-- We don't want planes, helicopters, bicycles and trains
			if class ~= 15 and class ~= 16 and class ~=21 and class ~=13 then
				return true
			end
		end
	end
	return false
end

RegisterNetEvent('qb-vehiclefailure:client:RepairVehicle', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local engineHealth = GetVehicleEngineHealth(vehicle) --This is to prevent people from "repairing" a vehicle and setting engine health lower than what the vehicles engine health was before repairing.
	if vehicle ~= nil and vehicle ~= 0 and engineHealth < 30000 then
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
				RepairVehicle(vehicle)
			else
				ShowEnginePos = true
			end
    	else
      		if #(pos - vehpos) > 4.9 then
       			QBCore.Functions.Notify(Lang:t("error.out_range_veh"), "error")
      		else
       			QBCore.Functions.Notify(Lang:t("error.inside_veh"), "error")
      		end
		end
  	else
		if vehicle == nil or vehicle == 0 then
			QBCore.Functions.Notify(Lang:t("error.not_near_veh"), "error")
		else
			QBCore.Functions.Notify(Lang:t("error.healthy_veh"), "error")
		end
	end
end)

RegisterNetEvent('qb-vehiclefailure:client:SyncWash', function(veh)
	SetVehicleDirtLevel(veh, 0.1)
	SetVehicleUndriveable(veh, false)
	WashDecalsFromVehicle(veh, 1.0)
end)

RegisterNetEvent('qb-vehiclefailure:client:CleanVehicle', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	if vehicle ~= nil and vehicle ~= 0 then
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 3.0 and not IsPedInAnyVehicle(ped) then
			CleanVehicle(vehicle)
		end
	end
end)

RegisterNetEvent('qb-vehiclefailure:client:RepairVehicleFull', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	if vehicle ~= nil and vehicle ~= 0 then
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
				RepairVehicleFull(vehicle)
			else
				ShowEnginePos = true
			end
    	else
      		if #(pos - vehpos) > 4.9 then
        		QBCore.Functions.Notify(Lang:t("error.out_range_veh"), "error")
      		else
        		QBCore.Functions.Notify(Lang:t("error.inside_veh"), "error")
      		end
		end
  	else
    	QBCore.Functions.Notify(Lang:t("error.not_near_veh"), "error")
	end
end)

RegisterNetEvent('iens:repaira', function()
	if isPedDrivingAVehicle() then
		local ped = PlayerPedId()
		vehicle = GetVehiclePedIsIn(ped, false)
		SetVehicleDirtLevel(vehicle)
		SetVehicleUndriveable(vehicle, false)
		WashDecalsFromVehicle(vehicle, 1.0)
		QBCore.Functions.Notify(Lang:t("success.repaired_veh"))
		SetVehicleFixed(vehicle)
		healthBodyLast=1000.0
		healthEngineLast=1000.0
		healthPetrolTankLast=1000.0
		SetVehicleEngineOn(vehicle, true, false )
		return
	else
	--	QBCore.Functions.Notify(Lang:t("error.inside_veh_req"))
	end
end)

RegisterNetEvent('iens:besked', function()
	QBCore.Functions.Notify(Lang:t("error.roadside_avail"))
end)

RegisterNetEvent('iens:notAllowed', function()
	QBCore.Functions.Notify(Lang:t("error.no_permission"))
end)

RegisterNetEvent('iens:repair', function()
	if isPedDrivingAVehicle() then
		local ped = PlayerPedId()
		vehicle = GetVehiclePedIsIn(ped, false)
		if IsNearMechanic() then
			return
		end
		if GetVehicleEngineHealth(vehicle) < cfg.cascadingFailureThreshold + 5 then
			if GetVehicleOilLevel(vehicle) > 0 then
				SetVehicleUndriveable(vehicle,false)
				SetVehicleEngineHealth(vehicle, cfg.cascadingFailureThreshold + 5)
				SetVehiclePetrolTankHealth(vehicle, 750.0)
				healthEngineLast=cfg.cascadingFailureThreshold +5
				healthPetrolTankLast=750.0
				SetVehicleEngineOn(vehicle, true, false )
				SetVehicleOilLevel(vehicle,(GetVehicleOilLevel(vehicle)/3)-0.5)
				QBCore.Functions.Notify(Lang:t(('fix_message_%s'):format(fixMessagePos)))
				fixMessagePos = fixMessagePos + 1
				if fixMessagePos > repairCfg.fixMessageCount then fixMessagePos = 1 end
			else 
				QBCore.Functions.Notify(Lang:t("error.veh_damaged"))
			end
		else
			QBCore.Functions.Notify(Lang:t(('nofix_message_%s'):format(noFixMessagePos)))
			noFixMessagePos = noFixMessagePos + 1
			if noFixMessagePos > repairCfg.noFixMessageCount then noFixMessagePos = 1 end
		end
	else
		QBCore.Functions.Notify(Lang:t("error.inside_veh_req"))
	end
end)
