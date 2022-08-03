Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use s_target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.Cityhalls = {
    { -- Cityhall 1
        coords = vec3(-265.0, -963.6, 31.2),
        showBlip = true,
        blipData = {
            sprite = 487,
            display = 4,
            scale = 0.65,
            colour = 0,
            title = "Centro de Emprego"
        },
        licenses = {
            ["id_card"] = {
                label = "Cartão de Cidadão",
                cost = 5000,
            },
            ["driver_license"] = {
                label = "Carta de Condução",
                cost = 5000,
                metadata = "driver"
            },
            ["weaponlicense"] = {
                label = "Porte de Arma",
                cost = 75000,
                metadata = "weapon"
            },
        }
    },
}


Config.Peds = {
    -- Cityhall Ped
    {
        model = 'a_m_m_hasjew_01',
        coords = vec4(-262.79, -964.18, 30.22, 181.71),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        cityhall = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    },
    -- Driving School Ped
    {
        model = 'a_m_m_eastsa_02',
        coords = vec4(240.91, -1379.2, 32.74, 138.96),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        drivingschool = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0
        }
    }
}
