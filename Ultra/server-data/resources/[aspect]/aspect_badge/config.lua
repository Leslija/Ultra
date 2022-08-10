Config = {}
Config.Data = {}

Config.Data.DisplayTimer = 3
Config.Data.DisplayDistance = 4.0
Config.Data.Departments = { 
    ["police"] = {
        label = "Departamento Policia Los Santos",
        background_image = "https://static.wikia.nocookie.net/gtawiki/images/2/21/Lossantos_seal.png",
        background_color = "rgb(38, 42, 78)",
        description = "<h3>Departamento Policia Los Santos</h3><p>A pessoa a mostrar este distintivo é um agente da autoridade.</p><p>Los Santos, CA</p>",
        colors= {
            text = "white",
            underline = "white",
            photo = "black",
        }
    },
    ["bcso"] = {
        label = "Departamento Sherrif's Los Santos",
        background_image = "https://static.wikia.nocookie.net/gtawiki/images/3/32/LSSD.png",
        background_color = "rgb(200, 78, 0)",
        description = "<h3>Departamento Sherrif's Los Santos</h3><p>A pessoa a mostrar este distintivo é um agente da autoridade.</p><p>Los Santos, CA</p>",
        colors = {
            text = "white",
            underline = "white",
            photo = "white",
        }
    },
    ["ambulance"] = {
        label = "SAM",
        background_image = "https://nremt.org/icon.png",
        background_color = "rgb(40, 40, 60)",
        description = "<h3>SAM</h3><p>A pessoa a mostrar este destintivo é um profissional da saude.</p><p>Los Santos, CA</p>",
        colors = {
            text = "white",
            underline = "white",
            photo = "white",
        }
    },
}
Config.Functions = {}

Config.Functions.CanDisplayIdentity = function() -- Client Check to see if the player can show their identity
    --[[ Example:
        if (PlayerData.job.name ~= "police") then
            return false 
        else 
            return true
        end
    ]] 
    return true
end

Config.Functions.CanEditIdentity = function() -- Client Check to see if the player can edit their identity
    return true
end

Config.Functions.OnEditSubmit = function(data) -- Client handler for when the player submits their edited identity
    --[[ Example: I dont want to allow the player to edit their name
    if (CurrentData.name ~= data.name) then 
        data.name = CurrentData.name
    end
    ]]--
    return data
end