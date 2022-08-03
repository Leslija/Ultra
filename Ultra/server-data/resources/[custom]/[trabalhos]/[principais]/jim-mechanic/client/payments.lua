local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
	for k, v in pairs(Config.RegisterLocations) do
		exports['s_target']:AddBoxZone("MechReceipt"..k, v.coords, v.w, v.d, { name="MechReceipt"..k, heading = v.heading, debugPoly=false, minZ=v.coords.z-0.5, maxZ=v.coords.z+0.5 }, 
			{ options = { { event = "jim-payments:client:Charge", icon = "fas fa-credit-card", label = "Charge Customer", job = v.job }, },
			  distance = 2.0
		})
	end
end)

Config.RegisterLocations = {
    --Add your box locations and job name for each payment register and it will add it to the s_target loop above
    { coords = vector3(-209.18, -1318.35, 30.89), w = 0.7, d = 0.7, heading = 0, job = "mechanic" },
    { coords = vector3(146.44, -3014.29, 6.97), w = 0.7, d = 0.7, heading = 0, job = "mechanic" },
}