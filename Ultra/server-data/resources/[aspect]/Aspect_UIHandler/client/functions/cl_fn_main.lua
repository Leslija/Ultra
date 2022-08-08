Framework = nil

ASPT.HandlerName = GetCurrentResourceName()

ASPT.PlayerData = {}

ASPT.Zones = Config.ScriptZones

ASPT.CurrentZone = nil
ASPT.IsInZone = nil
ASPT.WasInZone = nil

ASPT.DrawTexts = {}

ASPT.PedData = {
	Id = nil,
	Ped = nil,
	Coords = nil,
	Heading = nil,
	Alive = false,
	Health = nil,
	Armour = nil,
	Sprinting = false,
	IsRunning = false,
	Stamina = nil,
	UnderWater = false,
	IsSwimming = false,
	UnderwaterTime = nil,
	Talking = false,
	CameraRotation = nil,
	OnFoot = false,
	WasOnFoot = false,
	Reycast = nil,
	InVehicle = false,
	IsEnteringVehicle = false,
	CurrentVehicle = nil,
	Speed = 0,
	PrevSpeed = 0,
	RPM = 0,
	Engine = false,
	VehicleClass = nil,
	RPMScale = nil,
	Talking = false,
	IsTalking = false,
	Velocity = nil,
	PrevVelocity = nil,
	SpeedVector = nil,
	Acceleration = nil,
	Zone = nil,
	StreetLabel = {
		Zone = nil,
		Direction = nil,
		Street = nil
	}
}

ASPT.ClientTick = 0

ASPT.Functions.GetSharedObject = function()
	return ASPT
end

ASPT.Functions.HasChanged = function(value1, value2)
	if value1 == nil then
		return true
	end
	if value1 ~= value2 then
		return true
	end
	return false
end

ASPT.Functions.GetPedData = function()
	return ASPT.PedData
end

ASPT.Functions.GetCurrentZone = function()
	return ASPT.CurrentZone
end

ASPT.Functions.AddZones = function(zones)
	for k, v in pairs(zones) do
		if not ASPT.Zones[k] then
			ASPT.Zones[k] = zones[k]
		end
	end
end

ASPT.Functions.GetStreetName = function(coords)
	local StreetHash1, StreetHash2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
	local Street1 = GetStreetNameFromHashKey(StreetHash1)
	local Street2 = GetStreetNameFromHashKey(StreetHash2)
	return Street1..(Street2 ~= '' and ' '..' | '..' '..Street2 or '')
end

ASPT.Functions.GetPedDataThread = function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(Config.PedDataRefreshInterval)
			ASPT.ClientTick = ASPT.ClientTick + 1
			ASPT.PedData.Id = PlayerId()
			ASPT.PedData.Ped = PlayerPedId()
			ASPT.PedData.Coords = GetEntityCoords(ASPT.PedData.Ped)
			ASPT.PedData.Heading = GetEntityHeading(ASPT.PedData.Ped)
			ASPT.PedData.Alive = not IsEntityDead(ASPT.PedData.Ped)
			ASPT.PedData.Health = GetEntityHealth(ASPT.PedData.Ped)
			ASPT.PedData.Armour = GetPedArmour(ASPT.PedData.Ped)
			ASPT.PedData.Sprinting = IsPedSprinting(ASPT.PedData.Ped)
			ASPT.PedData.Stamina = GetPlayerSprintStaminaRemaining(ASPT.PedData.Id)
			ASPT.PedData.UnderWater = IsPedSwimmingUnderWater(ASPT.PedData.Ped)
			ASPT.PedData.UnderWaterTime = GetPlayerUnderwaterTimeRemaining(ASPT.PedData.Id)
			ASPT.PedData.Talking = NetworkIsPlayerTalking(ASPT.PedData.Id)
			if ASPT.PedData.UnderWaterTime < 0.0 then
				ASPT.PedData.UnderWaterTime = 0.0
			end
			ASPT.PedData.CameraRotation = GetGameplayCamRot(2)[3]
			if ASPT.PedData.CameraRotation < 0 then
				ASPT.PedData.CameraRotation = 360.0 + ASPT.PedData.CameraRotation
			end
			ASPT.PedData.OnFoot = IsPedOnFoot(ASPT.PedData.Ped)
			ASPT.PedData.Reycast = ASPT.Functions.GetReycast(ASPT.PedData.Ped, Config.ReycastDistance)
			if ASPT.PedData.InVehicle then
				ASPT.PedData.PrevSpeed = ASPT.PedData.Speed
				ASPT.PedData.PrevVelocity = ASPT.PedData.Velocity
				ASPT.PedData.Engine = GetIsVehicleEngineRunning(ASPT.PedData.CurrentVehicle)
				ASPT.PedData.Speed = GetEntitySpeed(ASPT.PedData.CurrentVehicle)
				ASPT.PedData.RPM = GetVehicleCurrentRpm(ASPT.PedData.CurrentVehicle)
				ASPT.PedData.Velocity = GetEntityVelocity(ASPT.PedData.CurrentVehicle)
				ASPT.PedData.SpeedVector = GetEntitySpeedVector(ASPT.PedData.CurrentVehicle, true).y
				ASPT.PedData.Acceleration = (ASPT.PedData.PrevSpeed - ASPT.PedData.Speed) / GetFrameTime()
				if ASPT.PedData.SpeedVector > 1.0 and ASPT.PedData.Acceleration >= Config.MinimumCrashForce and ASPT.PedData.PrevSpeed >= Config.MinimumCrashSpeed then
					TriggerEvent(ASPT.HandlerName..':OnVehicleHit', ASPT.PedData.Ped, ASPT.PedData.PrevVelocity, ASPT.PedData.Coords, ASPT.PedData.CurrentVehicle)
				end
			end
			if ASPT.ClientTick >= 10 then
				ASPT.ClientTick = 0
				--[[
				ASPT.DrawTexts = {}
				for k, v in pairs(ASPT.Zones) do
					for k2, v2 in pairs(v.Positions) do
						local Distance = GetDistanceBetweenCoords(ASPT.PedData.Coords, v2.x, v2.y, v2.z, true)
						if Distance < v.TextDistance then
							table.insert(ASPT.DrawTexts, {v2.x, v2.y, v2.z, v.DrawText})
							if Distance < v.InteractDistance then
								ASPT.IsInZone = true
								ASPT.CurrentZone = v
							end
						end
					end
				end
				if ASPT.IsInZone and not ASPT.WasInZone then
					ASPT.WasInZone = true
					TriggerEvent(ASPT.HandlerName..':HasEnteredZone', ASPT.CurrentZone)
				--elseif ASPT.IsInZone and ASPT.WasInZone then
				elseif not ASPT.IsInZone and ASPT.WasInZone then
					ASPT.WasInZone = false
					ASPT.CurrentZone = nil
					TriggerEvent(ASPT.HandlerName..':HasLeftZone')
				end
				]]--
				if ASPT.PedData.Talking and not ASPT.PedData.IsTalking then
					ASPT.PedData.IsTalking = true
					TriggerEvent(ASPT.HandlerName..':IsTalking')
				elseif not ASPT.PedData.Talking and ASPT.PedData.IsTalking then
					ASPT.PedData.IsTalking = false
					TriggerEvent(ASPT.HandlerName..':IsNotTalking')
				end
				if ASPT.PedData.UnderWater and not ASPT.PedData.IsSwimming then
					ASPT.PedData.IsSwimming = true
					TriggerEvent(ASPT.HandlerName..':IsUnderWater')
				elseif not ASPT.PedData.UnderWater and ASPT.PedData.IsSwimming then
					ASPT.PedData.IsSwimming = false
					TriggerEvent(ASPT.HandlerName..':IsNotUnderWater')
				end
				if ASPT.PedData.Sprinting and not ASPT.PedData.IsRunning then
					ASPT.PedData.IsRunning = true
					TriggerEvent(ASPT.HandlerName..':IsSprinting')
				elseif not ASPT.PedData.Sprinting and ASPT.PedData.IsRunning then
					ASPT.PedData.IsRunning = false
					TriggerEvent(ASPT.HandlerName..':IsNotSprinting')
				end
				if Config.AutoHideRadar then
					if ASPT.PedData.OnFoot and not ASPT.PedData.WasOnFoot then
						ASPT.PedData.WasOnFoot = true
						DisplayRadar(false)
						TriggerEvent(ASPT.HandlerName..':IsOnFoot')
					elseif not ASPT.PedData.OnFoot and ASPT.PedData.WasOnFoot then
						ASPT.PedData.WasOnFoot = false
						DisplayRadar(true)
						TriggerEvent(ASPT.HandlerName..':IsNotOnFoot')
					end
				end
				if not ASPT.PedData.InVehicle and ASPT.PedData.Alive then
					if DoesEntityExist(GetVehiclePedIsTryingToEnter(ASPT.PedData.Ped)) and not ASPT.PedData.IsEnteringVehicle then
						ASPT.PedData.IsEnteringVehicle = true
					elseif not DoesEntityExist(GetVehiclePedIsTryingToEnter(ASPT.PedData.Ped)) and not IsPedInAnyVehicle(ASPT.PedData.Ped, true) and ASPT.PedData.IsEnteringVehicle then
						ASPT.PedData.IsEnteringVehicle = false
					elseif IsPedInAnyVehicle(ASPT.PedData.Ped, false) then
						ASPT.PedData.IsEnteringVehicle = false
						ASPT.PedData.InVehicle = true
						ASPT.PedData.CurrentVehicle = GetVehiclePedIsUsing(ASPT.PedData.Ped)
						ASPT.PedData.VehicleClass = GetVehicleClass(ASPT.PedData.CurrentVehicle)
						if (ASPT.PedData.VehicleClass >= 0 and ASPT.PedData.VehicleClass <= 5) or (ASPT.PedData.VehicleClass >= 9 and ASPT.PedData.VehicleClass <= 12) or ASPT.PedData.VehicleClass == 17 or ASPT.PedData.VehicleClass == 18 or ASPT.PedData.VehicleClass == 20 then
							ASPT.PedData.RPMScale = 7000
						elseif ASPT.PedData.VehicleClass == 6 then
							ASPT.PedData.RPMScale = 7500
						elseif ASPT.PedData.VehicleClass == 7 then
							ASPT.PedData.RPMScale = 8000
						elseif ASPT.PedData.VehicleClass == 8 then
							ASPT.PedData.RPMScale = 11000
						elseif ASPT.PedData.VehicleClass == 15 or ASPT.PedData.VehicleClass == 16 then
							ASPT.PedData.RPMScale = -1
						end
						if Config.AutoHideRadar then
							DisplayRadar(true)
						end
						TriggerEvent(ASPT.HandlerName..':OnVehicleEnter', ASPT.PedData.CurrentVehicle)
					end
				elseif ASPT.PedData.InVehicle then
					ASPT.PedData.Zone = GetNameOfZone(ASPT.PedData.Coords.x, ASPT.PedData.Coords.y, ASPT.PedData.Coords.z)
					for k, v in pairs(Config.Directions) do
						if math.abs(ASPT.PedData.Heading - k) < 22.5 then
							ASPT.PedData.StreetLabel.Direction = v
							break
						end
					end
					ASPT.PedData.StreetLabel.Zone = (Config.Zones[ASPT.PedData.Zone:upper()] or ASPT.PedData.Zone:upper())
					ASPT.PedData.StreetLabel.Street = ASPT.Functions.GetStreetName(ASPT.PedData.Coords)
					if not IsPedInAnyVehicle(ASPT.PedData.Ped, false) or not ASPT.PedData.Alive then
						ASPT.PedData.InVehicle = false
						if Config.AutoHideRadar then
							DisplayRadar(false)
						end
						TriggerEvent(ASPT.HandlerName..':OnVehicleExit', ASPT.PedData.CurrentVehicle)
						ASPT.PedData.CurrentVehicle = 0
						ASPT.PedData.RPMScale = 0
						ASPT.PedData.VehicleClass = nil
					end
				end
			end
		end
	end)
end

ASPT.Functions.GetReycast = function(ped, distance)
	if ped and distance then
		local CameraRotation = (math.pi / 180.0) * GetGameplayCamRot(2)
		local CameraCoords = GetGameplayCamCoord()
	    local TargetCoords = CameraCoords + (vector3(-math.sin(CameraRotation.z) * math.abs(math.cos(CameraRotation.x)), math.cos(CameraRotation.z) * math.abs(math.cos(CameraRotation.x)), math.sin(CameraRotation.x)) * distance)
	    local TestShapeHandle = StartExpensiveSynchronousShapeTestLosProbe(CameraCoords, TargetCoords, -1, ped, 1)
	    local ShapeTestHandle, Hit, Coords, Surface, Entity = GetShapeTestResult(TestShapeHandle)
		return {ShapeTestHandle = ShapeTestHandle, Hit = Hit, Coords = Coords, Surface = Surface, Entity = Entity}
	end
end

exports('GetSharedObject', function()
	return ASPT.Functions.GetSharedObject()
end)

exports('GetFrameworkStatus', function()
	return ASPT.Functions.GetFrameworkStatus()
end)

exports('GetTalking', function()
	return ASPT.PedData.IsTalking
end)

exports('GetUnderWater', function()
	return ASPT.PedData.IsSwimming
end)

exports('GetSprinting', function()
	return ASPT.PedData.IsRunning
end)

exports('GetInVehilce', function()
	return ASPT.PedData.InVehicle
end)

exports('GetPedData', function()
	return ASPT.PedData
end)

exports('GetConfig', function()
	return Config
end)