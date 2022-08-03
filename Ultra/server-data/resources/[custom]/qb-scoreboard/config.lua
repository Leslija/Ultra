Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 'HOME' -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

Config.Toggle = true -- If this is false the scoreboard stays open only when you hold the OpenKey button, if this is true the scoreboard will be openned and closed with the OpenKey button

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 200) -- It returns 48 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ["casas"] = {
        minimumPolice = 0,
        busy = false,
        label = "Casas",
    },
    ["raptos"] = {
        minimumPolice = 0,
        busy = false,
        label = "Raptos",
    },
    ["arte"] = {
        minimumPolice = 0,
        busy = false,
        label = "Arte",
    },
    ["Comboios"] = {
        minimumPolice = 1,
        busy = false,
        label = "Comboios"
    },
    ["lojas"] = {
        minimumPolice = 4,
        busy = false,
        label = "Lojas"
    },
    ["bancos"] = {
        minimumPolice = 5,
        busy = false,
        label = "Bancos"
    },
    ["joalharia"] = {
        minimumPolice = 7,
        busy = false,
        label = "Joalharia"
    },
    ["principal"] = {
        minimumPolice = 10,
        busy = false,
        label = "Banco Principal"
    },

    
}

-- Show ID's for all players or Opted in Staff
Config.ShowIDforALL = false
