local QBCore = exports['qb-core']:GetCoreObject()


isLoggedIn = true
PlayerJob = {}

local onDuty = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "burgershot" then
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

Citizen.CreateThread(function()
    BurgerShot = AddBlipForCoord(-1197.32, -897.655, 13.995)
    SetBlipSprite (BurgerShot, 106)
    SetBlipDisplay(BurgerShot, 4)
    SetBlipScale  (BurgerShot, 0.5)
    SetBlipAsShortRange(BurgerShot, true)
    SetBlipColour(BurgerShot, 75)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("BurgerShot")
    EndTextCommandSetBlipName(BurgerShot)
end) 

RegisterNetEvent("qb-burgershot:BleederBurger")
AddEventHandler("qb-burgershot:BleederBurger", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "A fazer Hamburger..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "carneh", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "tomato", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-bleeder", 1)
                    QBCore.Functions.Notify("Fizes-te um Bleeder", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Não tens todos os ingredientes necessarios", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Não estas de serviço", "error")
	end
end)

RegisterNetEvent("qb-burgershot:MoneyShot")
AddEventHandler("qb-burgershot:MoneyShot", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "A fazer Hamburger..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "carneh", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "tomato", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-moneyshot", 1)
                    QBCore.Functions.Notify("Fizes-te um MoneyShot", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Não tens todos os ingredientes necessarios", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Não estas de serviço", "error")
	end
end)

RegisterNetEvent("qb-burgershot:HeartStopper")
AddEventHandler("qb-burgershot:HeartStopper", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientBurger', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "A fazer um Stooper..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "carneh", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "tomato", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-heartstopper", 1)
                    QBCore.Functions.Notify("Fizes-te um Stopper", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Não tens todos os ingredientes necessarios", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Não estas de serviço", "error")
	end
end)


RegisterNetEvent("qb-burgershot:Torpedo")
AddEventHandler("qb-burgershot:Torpedo", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientTorpedo', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "A fazer um Torpedo..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "carneh", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "burger-torpedo", 1)
                    QBCore.Functions.Notify("You made a Torpedo Roll", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelled..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Não tens todos os ingredientes necessarios", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Não estas de serviço", "error")
	end  
end)

RegisterNetEvent("qb-burgershot:MeatFree")
AddEventHandler("qb-burgershot:MeatFree", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-burgershot:server:get:ingredientMeatfree', function(HasItems)  
    		if HasItems then
				Working = true
				TriggerEvent('inventory:client:busy:status', true)
				QBCore.Functions.Progressbar("pickup_sla", "A fazer um vegetariano..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = false,
					disableMouse = false,
					disableCombat = false,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					Working = false
					TriggerEvent('inventory:client:busy:status', false)
					TriggerServerEvent('QBCore:Server:RemoveItem', "tomato", 1)
                    TriggerServerEvent('QBCore:Server:RemoveItem', "lettuce", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "burger-bun", 1)
					--TriggerServerEvent('QBCore:Server:AddItem', "carnehfree", 1)
                    QBCore.Functions.Notify("Fizes-te um vegetariano", "success")
				end, function()
					TriggerEvent('inventory:client:busy:status', false)
					QBCore.Functions.Notify("Cancelado..", "error")
					Working = false
				end)
			else
   				QBCore.Functions.Notify("Não tens todos os ingredientes necessarios", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("Não estas de serviço", "error")
	end  
end)



RegisterNetEvent("qb-burgershot:SoftDrink")
AddEventHandler("qb-burgershot:SoftDrink", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeSoftDrink()
        else
            QBCore.Functions.Notify("Não tens o xarope..", "error")
        end
      end, 'burger-sodasyrup')
    else
        QBCore.Functions.Notify("Não estas de serviço", "error")
    end
end)

RegisterNetEvent("qb-burgershot:mShake")
AddEventHandler("qb-burgershot:mShake", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeMShake()
        else
            QBCore.Functions.Notify("Não tens a formula..", "error")
        end
      end, 'burger-mshakeformula')
    else
        QBCore.Functions.Notify("Não estas de serviço", "error")
    end
end)

RegisterNetEvent("qb-burgershot:Fries")
AddEventHandler("qb-burgershot:Fries", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeFries()
        else
            QBCore.Functions.Notify("Não tens batatas..", "error")
        end
      end, 'burger-potato' )
    else
        QBCore.Functions.Notify("Não estas de serviço", "error")
    end
end)


RegisterNetEvent("qb-burgershot:PattyFry")
AddEventHandler("qb-burgershot:PattyFry", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakePatty()
        else
            QBCore.Functions.Notify("Não tens o que é preciso..", "error")
        end
      end, 'carneh')
    else
        QBCore.Functions.Notify("Não estas de serviço", "error")
    end
end)



RegisterNetEvent("qb-burgershot:DutyB")
AddEventHandler("qb-burgershot:DutyB", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("qb-burgershot:Tray1")
AddEventHandler("qb-burgershot:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Tray4")
AddEventHandler("qb-burgershot:Tray4", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray4")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray4", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Tray3")
AddEventHandler("qb-burgershot:Tray3", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray3")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray3", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Storage")
AddEventHandler("qb-burgershot:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerstorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerstorage", {
        maxweight = 250000,
        slots = 40,
    })
end)

RegisterNetEvent("qb-burgershot:Storage2")
AddEventHandler("qb-burgershot:Storage2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerstorage2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerstorage2", {
        maxweight = 250000,
        slots = 40,
    })
end)

-- Functions --
function MakeFries()
TriggerServerEvent('QBCore:Server:RemoveItem', "burger-potato", 1)
QBCore.Functions.Progressbar("pickup", "A fritar batatas..", 4000, false, true, {
    disableMovement = true,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = false,
},{
    animDict = "amb@prop_human_bbq@male@base",
    anim = "base",
    flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = { x = -0.005, y = 0.00, z = 0.00 },
        rotation = { x = 175.0, y = 160.0, z = 0.0 },
    }
)
Citizen.Wait(4000)
TriggerServerEvent('QBCore:Server:AddItem', "burger-fries", 4)
QBCore.Functions.Notify("You made 4 fries", "success")
StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end


function MakePatty()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-raw", 1)
    QBCore.Functions.Progressbar("pickup", "A fazer carne..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },{
        animDict = "amb@prop_human_bbq@male@base",
        anim = "base",
        flags = 8,
    }, {
        model = "prop_cs_fork",
        bone = 28422,
        coords = { x = -0.005, y = 0.00, z = 0.00 },
        rotation = { x = 175.0, y = 160.0, z = 0.0 },
    }    
)
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "carneh", 1)
    QBCore.Functions.Notify("Fizes-te a carne", "success")
    StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)
end

function MakeSoftDrink()

    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-sodasyrup", 1)
    QBCore.Functions.Progressbar("pickup", "A encher..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-softdrink", 1)
    QBCore.Functions.Notify("Fizes-te um sumo", "success")
    end  


function MakeMShake()

    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-mshakeformula", 1)
    QBCore.Functions.Progressbar("pickup", "A encher..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-mshake", 1)
    QBCore.Functions.Notify("Fizes-te um Milkshake", "success")
    end  
   

-- bt target -

Citizen.CreateThread(function()
    

    exports['s_target']:AddBoxZone("Duty", vector3(-1196.95, -902.69, 14.0), 1, 1.2, {
        name = "Serviço",
        heading = 32,
        debugPoly = false,
        minZ=14.0,
        maxZ=18.0,
    }, {
        options = {
            {  
                event = "qb-burgershot:DutyB",
                icon = "far fa-clipboard",
                label = "Entrar / Sair ",
                job = "burgershot",
            },
        },
        distance = 1.5
    })

    exports['s_target']:AddBoxZone("burger_tray_1", vector3(-1195.29, -892.31, 14.0), 1.05, 1.0, {
        name = "burger_tray_1",
        heading = 35.0,
        debugPoly = false,
        minZ=13.8,
        maxZ=14.3,
    }, {
        options = {
            {
                event = "qb-burgershot:Tray1",
                icon = "far fa-clipboard",
                label = "Tabuleiro 1",
            },
        },
        distance = 1.5
    })

    exports['s_target']:AddBoxZone("burger_tray_2", vector3(-1193.87, -894.38, 14.0), 0.5, 0.7, {
        name="burger_tray_2",
        heading=318,
        debugPoly=false,
        minZ=14.0,
        maxZ=14.4,
    }, {
        options = {
            {
                event = "qb-burgershot:Tray4",
                icon = "far fa-clipboard",
                label = "Tabuleiro 2",
				-- job = "all",
            },
        },
        distance = 1.5
    })
    exports['s_target']:AddBoxZone("burger_tray_3", vector3(-1193.88, -906.98, 14.0), 1, 1, {
        name="burger_tray_3",
        heading=350,
        debugPoly=false,
        minZ=13.2,
        maxZ=14.2,
    }, {
        options = {
            {
                event = "qb-burgershot:Tray3",
                icon = "far fa-clipboard",
                label = "Tabuleiro 3",
				-- job = "all",
            },
        },
        distance = 3.5
    })


 exports['s_target']:AddBoxZone("burgershotcooker", vector3(-1200.54, -900.92, 14.0), 1.8, 1.0, {
    name="burgershotcooker",
    heading=34,
    debugPoly=false,
    minZ=13.0,
    maxZ=14.4,
    }, {
        options = {
            {
                event = "qb-burgershot:PattyFry",
                icon = "fas fa-hamburger",
                label = "Mesa de Cozinha",
                job = "burgershot",
            },
        },
        distance = 1.5
    })

    exports['s_target']:AddBoxZone("burgershotcooker2 ", vector3(-1202.94, -897.38, 14.0), 1.7, 1, {
        name="burgershotcooker2 ",
        heading=34,
        debugPoly=false,
        minZ=13.0,
        maxZ=14.3,
        }, {
            options = {
                {
                    event = "qb-burgershot:PattyFry",
                    icon = "fas fa-hamburger",
                    label = "Mesa de Cozinha 2",
                    job = "burgershot",
                },
            },
            distance = 1.5
        })
    



    exports['s_target']:AddBoxZone("burgershotfryer", vector3(-1202.01, -899.27, 14.0), 2.5, 1.5, {
        name="burgershotfryer",
        heading=35,
        debugPoly=false,
        minZ=13.0,
        maxZ=14.4,
        }, {
            options = {
                {
                    event = "qb-burgershot:Fries",
                    icon = "fas fa-box",
                    label = "Fritar batatas",
                    job = "burgershot",
                },
            },
            distance = 1.5
        })


        exports['s_target']:AddBoxZone("burgershotdrinks", vector3(-1199.54, -895.52, 14.0), 2.2, 0.6, {
            name="burgershotdrinks",
            heading=34,
            debugPoly=false,
            minZ=13.8,
            maxZ=14.8,
            }, {
                options = {
                    {
                        event = "nh-context:DrinkMenu",
                        icon = "fas fa-filter",
                        label = "Tirar bebidas",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })

        exports['s_target']:AddBoxZone("burgershotdrinks2", vector3(-1189.08, -905.28, 14.0), 1.15, 0.7, {
            name="burgershotdrinks2",
            heading=33,
            debugPoly=false,
            minZ=13.8,
            maxZ=14.8,
            }, {
                options = {
                    {
                        event = "nh-context:DrinkMenu",
                        icon = "fas fa-filter",
                        label = "Fazer bebidas",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


         exports['s_target']:AddBoxZone("burgerfridge", vector3(-1203.71, -895.86, 14.0), 1.6, 1, {
            name="burgerfridge",
            heading=35,
            debugPoly=false,
            minZ=13.0,
            maxZ=15.6,
        }, {
                options = {
                    {
                        event = "nh-context:OrderMenu",
                        icon = "fas fa-laptop",
                        label = "Frigorifico!",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })

        exports['s_target']:AddBoxZone("burgershotdisplay", vector3(-1197.78, -894.45, 14.0), 4.6, 1.2, {
            name="burgershotdisplay",
            heading=34,
            debugPoly=false,
            minZ=13.0,
            maxZ=14.8,
        }, {
                options = {
                    {
                        event = "qb-burgershot:Storage",
                        icon = "fas fa-box",
                        label = "Armazem",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


        exports['s_target']:AddBoxZone("craftburger", vector3(-1197.57, -899.41, 14.0), 1.8, 0.7, {
            name="craftburger",
            heading=304,
            debugPoly=false,
            minZ=13.0,
            maxZ=14.4,
        }, {
                options = {
                    {
                        event = "nh-context:Burgers",
                        icon = "fas fa-cheeseburger",
                        label = "Mesa Cozinha",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })


        exports['s_target']:AddBoxZone("BurgerShot_register_1", vector3(-1196.01, -891.34, 14.0), 0.5, 0.4, {
            name="BurgerShot_register_1",
            debugPoly=false,
            heading=125,
            minZ=14.0,
            maxZ=14.5,
        }, {
                options = {
                    {
                        event = "qb-burgershot:bill",
                        parms = "1",
                        icon = "fas fa-credit-card",
                        label = "Fatura",
                        job = "burgershot",
                    },
                },
                distance = 1.5
            })

        exports['s_target']:AddBoxZone("BurgerShot_register_2", vector3(-1194.65, -893.3, 14.0), 0.6, 0.5, {
            name="BurgerShot_register_2",
            debugPoly=false,
            heading=302,
            minZ=14.1,
            maxZ=14.5,
            }, {
                    options = {
                        {
                            event = "qb-burgershot:bill",
                            parms = "2",
                            icon = "fas fa-credit-card",
                            label = "Fatura",
                            job = "burgershot",
                        },
                    },
                    distance = 1.5
                })  


        exports['s_target']:AddBoxZone("BurgerShot_register_3", vector3(-1193.39, -895.22, 14.0), 0.6, 0.4, {
            name="BurgerShot_register_3",
            debugPoly=false,
            heading=125,
            minZ=14.0,
            maxZ=14.4,
                    }, {
                            options = {
                                {
                                    event = "qb-burgershot:bill",
                                    parms = "3",
                                    icon = "fas fa-credit-card",
                                    label = "Fatura",
                                    job = "burgershot",
                                },
                            },
                            distance = 1.5
                        })  




        exports['s_target']:AddBoxZone("BurgerShot_register_4", vector3(-1192.52, -906.65, 14.0), 0.5, 0.5, {
            name="BurgerShot_register_4",
            heading=0,
            debugPoly=false,
            minZ=13.8,
            maxZ=14.2,
            }, 
            {
                options = {
                    {
                        event = "qb-burgershot:bill",
                        parms = "4",
                        icon = "fas fa-credit-card",
                        label = "Fatura",
                        job = "burgershot",
                    },
                },
            distance = 1.5
            }
        )
end)


-- NH - Context --

RegisterNetEvent('nh-context:Burgers', function(data)
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 0,
            header = "| Hamburguers |",
            txt = "",
        },
        {
            id = 1,
            header = "• Moneyshot",
            txt = "Pão , Carne , Tomate , Alface",
            params = {
                event = "qb-burgershot:MoneyShot"
            }
        },
        {
            id = 2,
            header = "• Vegetariano",
            txt = "Pão , Tomate , Alface",
            params = {
                event = "qb-burgershot:MeatFree"
            }
        },
        {
            id = 3,
            header = "• Bleeder",
            txt = "Pão , Carne , Tomate , Alface",
            params = {
                event = "qb-burgershot:BleederBurger"
            }
        },
        {
            id = 4,
            header = "• Stopper",
            txt = "Pão , Carne , Tomate , Alface",
            params = {
                event = "qb-burgershot:HeartStopper"
            }
        },
        {
            id = 5,
            header = "• Torpedo",
            txt = "Pão , Carne",
            params = {
                event = "qb-burgershot:Torpedo"
            }
        },
        {
            id = 6,
            header = "Fechar",
            txt = "",
        },
    })
end)


RegisterNetEvent('nh-context:OrderMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "Frigorifico",
            txt = '',
        },
        {
            header = "• Comprar ingredientes",
            txt = "",
            params = {
                event = "qb-burgershot:shop"
            }
        },
        {
            header = "• Abrir frigorifico",
            txt = "",
            params = {
                event = "qb-burgershot:Storage2"
            }
        },
        {

            header = "Fechar",
            txt = "",
        },
    })
end)

RegisterNetEvent('nh-context:DrinkMenu', function(data)
    exports['qb-menu']:openMenu({
        {
    
            header = "| Menu de Bebidas |",
            txt = "",
        },
        {
    
            header = "• Bebidas",
            txt = "",
            params = {
                event = "qb-burgershot:SoftDrink"
            }
        },
        {
    
            header = "• Milkshake",
            txt = "",
            params = {
                event = "qb-burgershot:mShake"
            }
        },
        {
     
            header = "Fechar",
            txt = "",
        },
    })
end)


-- Till Stuff --
RegisterNetEvent("qb-burgershot:bill")
AddEventHandler("qb-burgershot:bill", function()
    local bill = exports["qb-input"]:KeyboardInput({
        header = "Criar Fatura",
        rows = {
            {
                id = 0,
                txt = "ID"
            },
            {
                id = 1,
                txt = "Montante"
            }
        }
    })
    if bill ~= nil then
        if bill[1].input == nil or bill[2].input == nil then 
            return 
        end
        TriggerServerEvent("qb-burgershot:bill:player", bill[1].input, bill[2].input)
    end
end)



RegisterNetEvent("qb-burgershot:shop")
AddEventHandler("qb-burgershot:shop", function()


    TriggerServerEvent("inventory:server:OpenInventory", "shop", "burgershot", Config.Items)


end)



