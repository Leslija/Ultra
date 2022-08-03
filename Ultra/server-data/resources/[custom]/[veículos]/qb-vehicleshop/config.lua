Config = {}
Config.UsingTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Commission = 0.10 -- Percent that goes to sales person from a full car sale 10%
Config.FinanceCommission = 0.05 -- Percent that goes to sales person from a finance sale 5%
Config.FinanceZone = vector3(-29.53, -1103.67, 26.42) -- Where the finance menu is located
Config.PaymentWarning = 10 -- time in minutes that player has to make payment before repo
Config.PaymentInterval = 24 -- time in hours between payment being due
Config.MinimumDown = 10 -- minimum percentage allowed down
Config.MaximumPayments = 24 -- maximum payments allowed
Config.Shops = {
    ['pdm'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-56.727394104004, -1086.2325439453),
                vector2(-60.612808227539, -1096.7795410156),
                vector2(-58.26834487915, -1100.572265625),
                vector2(-35.927803039551, -1109.0034179688),
                vector2(-34.427627563477, -1108.5111083984),
                vector2(-32.02657699585, -1101.5877685547),
                vector2(-33.342102050781, -1101.0377197266),
                vector2(-31.292987823486, -1095.3717041016)
            },
            ['minZ'] = 25.0,  -- min height of the shop zone
            ['maxZ'] = 28.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Premium Deluxe Motorsport', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 326,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['Categoria1'] = '0-500K',
            ['Categoria2'] = '500K-1M',
            ['Categoria3'] = '1M-2M',
            ['Categoria4'] = '2M-4M',
            ['Categoria5'] = '4M-5M',
            ['VIP'] = 'VIP'
        },
        ['TestDriveTimeLimit'] = 0.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-45.67, -1098.34, 26.42), -- Blip Location
        ['ReturnLocation'] = vector3(-44.74, -1082.58, 26.68), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-56.79, -1109.85, 26.43, 71.5), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(-56.79, -1109.85, 26.43, 71.5), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-45.65, -1093.66, 25.44, 69.5), -- where the vehicle will spawn on display
                defaultVehicle = 'polo2018', -- Default display vehicle
                chosenVehicle = 'polo2018', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-48.27, -1101.86, 25.44, 294.5),
                defaultVehicle = 'supra2',
                chosenVehicle = 'supra2',
            },
            [3] = {
                coords = vector4(-39.6, -1096.01, 25.44, 66.5),
                defaultVehicle = 'nissantitan17',
                chosenVehicle = 'nissantitan17',
            },
            [4] = {
                coords = vector4(-51.21, -1096.77, 25.44, 254.5),
                defaultVehicle = 'bmws',
                chosenVehicle = 'bmws',
            },
            [5] = {
                coords = vector4(-40.18, -1104.13, 25.44, 338.5),
                defaultVehicle = 'macanturbo',
                chosenVehicle = 'macanturbo',
            },
            [6] = {
                coords = vector4(-43.31, -1099.02, 25.44, 52.5),
                defaultVehicle = '18performante',
                chosenVehicle = '18performante',
            },
            [7] = {
                coords = vector4(-50.66, -1093.05, 25.44, 222.5),
                defaultVehicle = 'rmodsian',
                chosenVehicle = 'rmodsian',
            },
            [8] = {
                coords = vector4(-44.28, -1102.47, 25.44, 298.5),
                defaultVehicle = 'h2carb',
                chosenVehicle = 'h2carb',
            }
        },
    },
    ['boats'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a vehicle
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-729.39, -1315.84),
                vector2(-766.81, -1360.11),
                vector2(-754.21, -1371.49),
                vector2(-716.94, -1326.88),
            },
            ['minZ'] = 0.0,  -- min height of the shop zone
            ['maxZ'] = 5.0,  -- max height of the shop zone
            ['size'] = 6.2, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Loja de Barcos', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 410,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['boats'] = 'Barcos',
        },
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-738.25, -1334.38, 1.6), -- Blip Location
        ['ReturnLocation'] = vector3(-714.34, -1343.31, 0.0), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-727.87, -1353.1, -0.17, 137.09), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-727.05, -1326.59, 0.00, 229.5), -- where the vehicle will spawn on display
                defaultVehicle = 'seashark', -- Default display vehicle
                chosenVehicle = 'seashark', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-737.84, -1340.83, -0.50, 229.5),
                defaultVehicle = 'speeder',
                chosenVehicle = 'speeder',
            },
            [3] = {
                coords = vector4(-741.53, -1349.7, -2.00, 229.5),
                defaultVehicle = 'marquis',
                chosenVehicle = 'marquis',
            },
        },
    },
}
