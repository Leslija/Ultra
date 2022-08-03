-- Variables

local alcoholCount = 0
local ParachuteEquiped = false
local currentVest = nil
local currentVestTexture = nil
local healing = false

-- Functions

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function EquipParachuteAnim()
    loadAnimDict("clothingshirt")
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

function HealOxy()
    if not healing then
        healing = true
    else
        return
    end

    local count = 9
    while count > 0 do
        Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 6)
    end
    healing = false
end

function MethBagEffect()
    local startStamina = 8
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            TrevorEffect()
        end
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end
end

function CrackBaggyEffect()
    local startStamina = 8
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 60 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 2000), math.random(1000, 2000), 3, 0, 0, 0)
        end
        if math.random(1, 100) < 51 then
            AlienEffect()
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function CokeBaggyEffect()
    local startStamina = 20
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            AlienEffect()
            Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

-- Events
--- LOJA PORN

RegisterNetEvent('consumables:client:porn1', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("porn1", "A aliviar o stress..", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "misscarsteal2peeing",
        anim = "peeing_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "misscarsteal2peeing", "peeing_loop", 1.0)
        TriggerServerEvent('hud:server:RelieveStress', math.random(10, 20))
    end, function() -- Cancel
        StopAnimTask(ped, "misscarsteal2peeing", "peeing_loop", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:porn2', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("porn2", "A aliviar o stress..", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "misscarsteal2peeing",
        anim = "peeing_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "misscarsteal2peeing", "peeing_loop", 1.0)
        TriggerServerEvent('hud:server:RelieveStress', math.random(10, 20))
    end, function() -- Cancel
        StopAnimTask(ped, "misscarsteal2peeing", "peeing_loop", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:vibrador', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("vibrador", "A aliviar o stress..", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "misscarsteal2peeing",
        anim = "peeing_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "misscarsteal2peeing", "peeing_loop", 1.0)
        TriggerServerEvent('hud:server:RelieveStress', math.random(10, 20))
    end, function() -- Cancel
        StopAnimTask(ped, "misscarsteal2peeing", "peeing_loop", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

--- WEEDSHOP

RegisterNetEvent('consumables:client:ganza', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("ganza", "A fumar uma..", 10000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_smoking@male@male_a@enter",
        anim = "enter",
        flags = 49,
        
    }, {
        model = "p_cs_joint_02",
        bone = 47419,
        coords = { x = 0.015, y = -0.009, z = 0.003 },
        rotation = { x = 55.0, y = 0.0, z = 110.0 }, 
    }, {}, function() -- Done
        StopAnimTask(ped, "amb@world_human_smoking@male@male_a@enter", "enter", 1.0)
            SetTimecycleModifier("spectator5")
            SetPedMotionBlur(playerPed, true)
            SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
            SetPedIsDrunk(playerPed, true)
            TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
                Wait(60000)
            ClearTimecycleModifier()
	        ResetScenarioTypesEnabled()
	        ResetPedMovementClipset(playerPed, 0)
	        SetPedIsDrunk(playerPed, false)
	        SetPedMotionBlur(playerPed, false)
            JointEffect()
        TriggerServerEvent('hud:server:RelieveStress', math.random(10, 20))
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_smoking@male@male_a@enter", "enter", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)


RegisterNetEvent('consumables:client:bongo', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("ganza", "A fumar..", 10000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@safehouse@bong",
        anim = "bong_stage3",
        flags = 49,
        
    }, {
        model = "hei_heist_sh_bong_01",
        bone = 18905,
        coords = { x = 0.10, y = -0.25, z = 0.0 },
        rotation = { x = 95.0, y = 190.0, z = 180.0 },
    }, {}, function() -- Done
        StopAnimTask(ped, "amb@world_human_smoking@male@male_a@enter", "enter", 1.0)
            SetTimecycleModifier("spectator5")
            SetPedMotionBlur(playerPed, true)
            SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
            SetPedIsDrunk(playerPed, true)
            TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
                Wait(60000)
            ClearTimecycleModifier()
	        ResetScenarioTypesEnabled()
	        ResetPedMovementClipset(playerPed, 0)
	        SetPedIsDrunk(playerPed, false)
	        SetPedMotionBlur(playerPed, false)
            JointEffect()
        TriggerServerEvent('hud:server:RelieveStress', math.random(10, 20))
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_smoking@male@male_a@enter", "enter", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:cigarro', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("cigarro", "A fumar..", 10000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_aa_smoke@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {
        model = "prop_cs_ciggy_01",
        bone = 28422,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    }, {}, function() -- Done
        StopAnimTask(ped, "amb@world_human_aa_smoke@male@idle_a", "idle_c", 1.0)
        TriggerServerEvent('hud:server:RelieveStress', math.random(5, 10))
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_aa_smoke@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)


--- COMIDA 

RegisterNetEvent('consumables:client:burger', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("burger", "A comer..", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_player_inteat@burger",
        anim = "mp_player_int_eat_burger",
        flags = 49,
        
    }, {
        model = "prop_cs_burger_01",
        bone = 18905,
        coords = { x = 0.13, y = 0.05, z = 0.02 },
        rotation = { x = -50.0, y = 16.0, z = 60.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesBurger[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
    end, function() -- Cancel
        StopAnimTask(ped, "mp_player_inteat@burger", "mp_player_int_eat_burger", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:donuts', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("donuts", "Delicioso..", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_player_inteat@burger",
        anim = "mp_player_int_eat_burger",
        flags = 49,
        
    }, {
        model = "prop_amb_donut",
        bone = 18905,
        coords = { x = 0.13, y = 0.05, z = 0.02 },
        rotation = { x = -50.0, y = 16.0, z = 60.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesDonuts[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
    end, function() -- Cancel
        StopAnimTask(ped, "mp_player_inteat@burger", "mp_player_int_eat_burger", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:sandes', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("donuts", "A comer..", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_player_inteat@burger",
        anim = "mp_player_int_eat_burger",
        flags = 49,
        
    }, {
        model = "prop_sandwich_01",
        bone = 18905,
        coords = { x = 0.13, y = 0.05, z = 0.02 },
        rotation = { x = -50.0, y = 16.0, z = 60.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesSandes[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
    end, function() -- Cancel
        StopAnimTask(ped, "mp_player_inteat@burger", "mp_player_int_eat_burger", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:twerk_candy', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("twerk_candy", "Delicioso..", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_player_inteat@burger",
        anim = "mp_player_int_eat_burger",
        flags = 49,
        
    }, {
        model = "prop_choc_ego",
        bone = 60309,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesChocolates[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(6, 8))
    end, function() -- Cancel
        StopAnimTask(ped, "mp_player_inteat@burger", "mp_player_int_eat_burger", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

---- BEBIDAS

RegisterNetEvent('consumables:client:aguas', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("aguas", "A beber..", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_player_intdrink",
        anim = "loop_bottle",
        flags = 49,
        
    }, {
        model = "prop_ld_flow_bottle",
        bone = 18905,
        coords = { x = 0.12, y = 0.028, z = 0.001 },
        rotation = { x = 10.0, y = 175.0, z = 0.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesAguas[itemName])
    end, function() -- Cancel
        StopAnimTask(ped, "mp_player_intdrink", "loop_bottle", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:sumos', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("sumos", "A beber..", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_drinking@coffee@male@idle_a",
        anim = "idle_c",
        flags = 49,
        
    }, {
        model = "prop_ecola_can",
        bone = 28422,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 130.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesSumos[itemName])
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:copos', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("copos", "A beber..", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_drinking@coffee@male@idle_a",
        anim = "idle_c",
        flags = 49,
        
    }, {
        model = "prop_plastic_cup_02",
        bone = 28422,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesCopos[itemName])
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:cafes', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("cafes", "A beber..", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_drinking@coffee@male@idle_a",
        anim = "idle_c",
        flags = 49,
        
    }, {
        model = "p_amb_coffeecup_01",
        bone = 28422,
        coords = { x = 0.0, y = -0.0, z = -0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesCafes[itemName])
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:energeticos', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("energeticos", "Redbull dá-te asas..", 5000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_drinking@coffee@male@idle_a",
        anim = "idle_c",
        flags = 49,
        
    }, {
        model = "prop_plastic_cup_02",
        bone = 28422,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesEnergeticos[itemName])
        EfeitoCorrer()
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

function EfeitoCorrer()
    local startStamina = 8
    local ped = PlayerPedId()
  --  AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 51 then
          --  AlienEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

--- BEBIDAS ALCÓLICAS

RegisterNetEvent('consumables:client:whiskeys', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("whiskeys", "A beber...", 10000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_drinking@coffee@male@idle_a",
        anim = "idle_c",
        flags = 49,
        
    }, {
        model = "prop_drink_whisky",
        bone = 28422,
        coords = { x = 0.01, y = -0.01, z = -0.06 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesWhiskeys[itemName])
        SetTimecycleModifier("spectator5")
            SetPedMotionBlur(playerPed, true)
            SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
            SetPedIsDrunk(playerPed, true)
            Wait(60000)
            ClearTimecycleModifier()
	        ResetScenarioTypesEnabled()
            ResetPedMovementClipset(playerPed, 0)
            SetPedIsDrunk(playerPed, false)
	        SetPedMotionBlur(playerPed, false)
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:coposalcool', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("coposalcool", "A beber...", 10000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_drinking@coffee@male@idle_a",
        anim = "idle_c",
        flags = 49,
        
    }, {
        model = "prop_plastic_cup_02",
        bone = 28422,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesCoposalcool[itemName])
        SetTimecycleModifier("spectator5")
            SetPedMotionBlur(playerPed, true)
            SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
            SetPedIsDrunk(playerPed, true)
            Wait(60000)
            ClearTimecycleModifier()
	        ResetScenarioTypesEnabled()
            ResetPedMovementClipset(playerPed, 0)
            SetPedIsDrunk(playerPed, false)
	        SetPedMotionBlur(playerPed, false)
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:cervejas', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("cervejas", "A beber...", 10000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@world_human_drinking@coffee@male@idle_a",
        anim = "idle_c",
        flags = 49,
        
    }, {
        model = "prop_amb_beer_bottle",
        bone = 28422,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    }, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesCervejas[itemName])
        SetTimecycleModifier("spectator5")
            SetPedMotionBlur(playerPed, true)
            SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
            SetPedIsDrunk(playerPed, true)
            Wait(60000)
            ClearTimecycleModifier()
	        ResetScenarioTypesEnabled()
            ResetPedMovementClipset(playerPed, 0)
            SetPedIsDrunk(playerPed, false)
	        SetPedMotionBlur(playerPed, false)
    end, function() -- Cancel
        StopAnimTask(ped, "amb@world_human_drinking@coffee@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)


RegisterNetEvent('consumables:client:DrinkAlcohol', function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    QBCore.Functions.Progressbar("snort_coke", "A beber..", math.random(3000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesAlcohol[itemName])
        alcoholCount = alcoholCount + 1
        if alcoholCount > 1 and alcoholCount < 4 then
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then
            TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        end

    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)



--- DROGAS

RegisterNetEvent('consumables:client:Cokebaggy', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("snort_coke", "Cheiro rápido..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
        CokeBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:Crackbaggy', function(itemName)
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("snort_coke", "A fumar crack..", math.random(7000, 10000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        CrackBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
    end)
end)

RegisterNetEvent('consumables:client:EcstasyBaggy', function(itemName)
    QBCore.Functions.Progressbar("use_ecstasy", "Hum....", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        EcstasyEffect()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Falhou", "error")
    end)
end)

RegisterNetEvent('consumables:client:oxy', function(itemName)
    QBCore.Functions.Progressbar("use_oxy", "A curar...", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        ClearPedBloodDamage(PlayerPedId())
		HealOxy()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Cancelado", "error")
    end)
end)

RegisterNetEvent('consumables:client:meth', function(itemName)
    QBCore.Functions.Progressbar("snort_meth", "Fumar metanfetamina", math.random(7000, 10000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
		TriggerEvent("evidence:client:SetStatus", "agitated", 300)
        MethBagEffect()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Cancelado..", "error")
	end)
end)


-- LOJA LAZER

RegisterNetEvent('consumables:client:UseParachute', function()
    EquipParachuteAnim()
    QBCore.Functions.Progressbar("use_parachute", "A equipar paraquedas..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local ped = PlayerPedId()
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "remove")
        GiveWeaponToPed(ped, `GADGET_PARACHUTE`, 1, false)
        local ParachuteData = {
            outfitData = {
                ["bag"]   = { item = 7, texture = 0},  -- Adding Parachute Clothing
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', ParachuteData)
        ParachuteEquiped = true
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end)
end)

RegisterNetEvent('consumables:client:ResetParachute', function()
    if ParachuteEquiped then
        EquipParachuteAnim()
        QBCore.Functions.Progressbar("reset_parachute", "A arrumar paraquedas..", 40000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            local ped = PlayerPedId()
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "add")
            local ParachuteRemoveData = {
                outfitData = {
                    ["bag"] = { item = 0, texture = 0} -- Removing Parachute Clothing
                }
            }
            TriggerEvent('qb-clothing:client:loadOutfit', ParachuteRemoveData)
            TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            TriggerServerEvent("qb-smallpenis:server:AddParachute")
            ParachuteEquiped = false
        end)
    else
        QBCore.Functions.Notify("Não tens nenhum paraquedas!", "error")
    end
end)

RegisterNetEvent('consumables:client:UseArmor', function()
    if GetPedArmour(PlayerPedId()) >= 75 then QBCore.Functions.Notify('Já tens colete em ti!', 'error') return end
    QBCore.Functions.Progressbar("use_armor", "A colocar colete..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["armor"], "remove")
        TriggerServerEvent('hospital:server:SetArmor', 75)
        TriggerServerEvent("QBCore:Server:RemoveItem", "armor", 1)
        SetPedArmour(PlayerPedId(), 75)
    end)
end)

RegisterNetEvent('consumables:client:UseHeavyArmor', function()
    if GetPedArmour(PlayerPedId()) == 100 then QBCore.Functions.Notify('Já tens colete em ti!', 'error') return end
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("use_heavyarmor", "A colocar colete pesado..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        if PlayerData.charinfo.gender == 0 then
            currentVest = GetPedDrawableVariation(ped, 9)
            currentVestTexture = GetPedTextureVariation(ped, 9)
            if GetPedDrawableVariation(ped, 9) == 7 then
                SetPedComponentVariation(ped, 9, 19, GetPedTextureVariation(ped, 9), 2)
            else
                SetPedComponentVariation(ped, 9, 5, 2, 2) -- Blue
            end
        else
            currentVest = GetPedDrawableVariation(ped, 30)
            currentVestTexture = GetPedTextureVariation(ped, 30)
            SetPedComponentVariation(ped, 9, 30, 0, 2)
        end
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["heavyarmor"], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", "heavyarmor", 1)
        SetPedArmour(ped, 100)
    end)
end)

RegisterNetEvent('consumables:client:ResetArmor', function()
    local ped = PlayerPedId()
    if currentVest ~= nil and currentVestTexture ~= nil then
        QBCore.Functions.Progressbar("remove_armor", "A remover colete..", 2500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            SetPedComponentVariation(ped, 9, currentVest, currentVestTexture, 2)
            SetPedArmour(ped, 0)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["heavyarmor"], "add")
            TriggerServerEvent("QBCore:Server:AddItem", "heavyarmor", 1)
        end)
    else
        QBCore.Functions.Notify("Não estás a usar colete..", "error")
    end
end)

-- RegisterNetEvent('consumables:client:UseRedSmoke', function()
--     if ParachuteEquiped then
--         local ped = PlayerPedId()
--         SetPlayerParachuteSmokeTrailColor(ped, 255, 0, 0)
--         SetPlayerCanLeaveParachuteSmokeTrail(ped, true)
--         TriggerEvent("inventory:client:Itembox", QBCore.Shared.Items["smoketrailred"], "remove")
--     else
--         QBCore.Functions.Notify("You need to have a paracute to activate smoke!", "error")
--     end
-- end)

--Threads

CreateThread(function()
    while true do
        Wait(10)
        if alcoholCount > 0 then
            Wait(1000 * 60 * 15)
            alcoholCount = alcoholCount - 1
        else
            Wait(2000)
        end
    end
end)
