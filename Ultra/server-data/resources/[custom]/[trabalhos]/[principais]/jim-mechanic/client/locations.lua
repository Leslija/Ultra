local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
			for k, v in pairs(Config.JobRoles) do
				if v == PlayerJob.name then havejob = true end
			end
			if havejob then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('strtunners:client:cofre', function(data)
    if onDuty and PlayerJob.name == "strtunners" then
    	TriggerEvent("inventory:client:SetCurrentStash", "strtunnerscofre")
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "strtunnerscofre", {
            maxweight = 4000000,
            slots = 500,
        })
    else
        QBCore.Functions.Notify("Não estás em serviço", "error")
    end
end)

RegisterNetEvent('bennys:client:cofre', function(data)
    if onDuty and PlayerJob.name == "strtunners" then
    	TriggerEvent("inventory:client:SetCurrentStash", "bennys")
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "bennys", {
            maxweight = 4000000,
            slots = 500,
        })
    else
        QBCore.Functions.Notify("Não estás em serviço", "error")
    end
end)


AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
		QBCore.Functions.GetPlayerData(function(PlayerData)
			PlayerJob = PlayerData.job
			for k, v in pairs(Config.JobRoles) do
				if v == PlayerJob.name then havejob = true end
			end
			if havejob then
                onDuty = PlayerJob.onduty
				injob = true
            end
		end)
    end
	Wait(500)
end)

Config.Locations = {
    [1] = {
        label = "strtunners", -- Set this to the required job
        zones = {
			vector2(155.82211303711, -3049.0134277344),
			vector2(120.81920623779, -3051.4333496094),
			vector2(120.68406677246, -3007.8579101562),
			vector2(122.86009979248, -3007.1213378906),
			vector2(153.39585876465, -3007.0812988281),
			vector2(153.28991699219, -3014.7182617188),
			vector2(157.03234863281, -3012.8505859375)
        },
		blip = vector3(140.76, -3029.87, 7.04),
		bliplabel = "6STR Tunners",
		blipcolor = 48,
    },
	[2] = {
		label = "bennys", -- Set this to the required job
        zones = {
			vector2(-244.93894958496, -1342.5454101562),
			vector2(-246.83804321289, -1252.5169677734),
			vector2(-173.21493530273, -1248.0953369141),
			vector2(-145.33396911621, -1293.0988769531),
			vector2(-155.05891418457, -1310.0799560547),
			vector2(-178.10710144043, -1342.1934814453)
        },
		blip = vector3(-204.89, -1304.1, 31.28),
		bliplabel = "Bennys",
		blipcolor = 55,
    },
    -- Add a new job like this with location
	-- Check out https://github.com/mkafrin/PolyZone/wiki/Using-the-creation-script for information on how to make polyzones, its really easy
	-- When you have the vectors, copy them into a new zone below and it should work!
	-- The name is the players Job Role eg. "mechanic", if you set Config.JobRequiredForLocation to false, this can be whatever.
    --[2] = { 
    --    label = "mechanic",
    --    zones = {
    --        vector2(-308.60556030273, -983.15423583984),
    --        vector2(-294.68597412109, -988.24194335938),
    --        vector2(-297.03381347656, -994.37298583984),
    --        vector2(-346.31329345703, -976.38232421875),
    --        vector2(-343.78552246094, -970.34112548828)
    --    },
	--		
	--SIMPLE BLIP SETUP
	--If blip info is there it will generate a blip
	--If blip label is added (can be removed) it will add the chosen blip name otherwise it will default to "Mechanic Shop"
	--Blip colours can be found here: https://docs.fivem.net/docs/game-references/blips/
	--		blip = vector3(530.48, -1336.1, 29.27),
	--		bliplabel = "Bennys",
	--		blipcolor = 8,
    --},
}
--local injob = false
CreateThread(function()
	if Config.LocationRequired then
		--if onDuty ~= true then TriggerServerEvent("QBCore:ToggleDuty") end
		for k, v in pairs(Config.Locations) do
			JobLocation = PolyZone:Create(Config.Locations[k].zones, {
				name = Config.Locations[k].label,
				debugPoly = false
			})
			JobLocation:onPlayerInOut(function(isPointInside)
				if isPointInside then
					--if onDuty ~= false then  TriggerServerEvent("QBCore:ToggleDuty") end
					if Config.JobRequiredForLocation then
						if Config.RequiresJob then
							if PlayerJob.name ~= tostring(Config.Locations[k].label) then
								if onDuty ~= false then TriggerServerEvent("QBCore:ToggleDuty") end
							else
								if onDuty ~= true then  TriggerServerEvent("QBCore:ToggleDuty") end
							end
						elseif not Config.RequiresJob then
							if onDuty ~= true then  TriggerServerEvent("QBCore:ToggleDuty") end
						end
					elseif not Config.JobRequiredForLocation then
						if onDuty ~= true then  TriggerServerEvent("QBCore:ToggleDuty") end
					end
				else
					if onDuty ~= false then  TriggerServerEvent("QBCore:ToggleDuty") end
				end
			end)
		end
	end
end)
