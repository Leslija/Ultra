
local QBCore = exports['qb-core']:GetCoreObject()

function BoatMenuLaPuerta()
    exports['qb-menu']:openMenu({
        {
            header = "Alugar Barco - 1",
            isMenuHeader = true
        },
        {
            header = "Barco: "..Config.RentalBoat,
            txt = "Preço: "..Config.BoatPrice.."€",
            params = {
                event = "doj:client:rentaBoat",
				args = 1
            }
        },
        {
            header = "Fechar ",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuPaletoCove()
    exports['qb-menu']:openMenu({
        {
            header = "Alugar Barco - 2",
            isMenuHeader = true
        },
        {
            header = "Barco: "..Config.RentalBoat,
            txt = "Preço: "..Config.BoatPrice.."€",
            params = {
                event = "doj:client:rentaBoat",
				args = 2
            }
        },
        {
            header = "Fechar ",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuElGordo()
    exports['qb-menu']:openMenu({
        {
            header = "Alugar Barco - 3",
            isMenuHeader = true
        },
        {
            header = "Barco: "..Config.RentalBoat,
            txt = "Preço: "..Config.BoatPrice.."€",
            params = {
                event = "doj:client:rentaBoat",
				args = 3
            }
        },
        {
            header = "Fechar ",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 


function BoatMenuActDam()
    exports['qb-menu']:openMenu({
        {
            header = "Alugar Barco - 4",
            isMenuHeader = true
        },
        {
            header = "Barco: "..Config.RentalBoat,
            txt = "Preço: "..Config.BoatPrice.."€",
            params = {
                event = "doj:client:rentaBoat",
				args = 4
            }
        },
        {
            header = "Fechar ",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuAlamoSea()
    exports['qb-menu']:openMenu({
        {
            header = "Alamo Sea Boat Rental",
            isMenuHeader = true
        },
        {
            header = "Barco: "..Config.RentalBoat,
            txt = "Preço: "..Config.BoatPrice.."€",
            params = {
                event = "doj:client:rentaBoat",
				args = 5
            }
        },
        {
            header = "Fechar ",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 
--============================================================== ReturnMenus

function ReturnBoatLaPuerta()
    exports['qb-menu']:openMenu({
		{
            header = "Arrendar Barco de Pesca",
            isMenuHeader = true
        },
		{
            header = "Devolver Barco",
            txt = "Devolver e receber "..math.floor(Config.BoatPrice/2).."€",
            params = {
                event = "doj:client:ReturnBoat",
				args = 1
            }
        },
        {
            header = "Fechar",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatPaletoCove()
    exports['qb-menu']:openMenu({
		{
            header = "Arrendar Barco de Pesca",
            isMenuHeader = true
        },
		{
            header = "Devolver Barco",
            txt = "Devolver e receber "..math.floor(Config.BoatPrice/2).."€",
            params = {
                event = "doj:client:ReturnBoat",
				args = 2
            }
        },
        {
            header = "Fechar",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatElGordo()
    exports['qb-menu']:openMenu({
		{
            header = "Arrendar Barco de Pesca",
            isMenuHeader = true
        },
		{
            header = "Devolver Barco",
            txt = "Devolver e receber "..math.floor(Config.BoatPrice/2).."€",
            params = {
                event = "doj:client:ReturnBoat",
				args = 3
            }
        },
        {
            header = "Fechar",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatActDam()
    exports['qb-menu']:openMenu({
		{
            header = "Arrendar Barco de Pesca",
            isMenuHeader = true
        },
		{
            header = "Devolver Barco",
            txt = "Devolver e receber "..math.floor(Config.BoatPrice/2).."€",
            params = {
                event = "doj:client:ReturnBoat",
				args = 4
            }
        },
        {
            header = "Fechar",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatAlamoSea()
    exports['qb-menu']:openMenu({
		{
            header = "Arrendar Barco de Pesca",
            isMenuHeader = true
        },
		{
            header = "Devolver Barco",
            txt = "Devolver e receber "..math.floor(Config.BoatPrice/2).."€",
            params = {
                event = "doj:client:ReturnBoat",
				args = 5
            }
        },
        {
            header = "Fechar",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

--============================================================== Sell/Gear Menus

RegisterNetEvent('doj:client:SellLegalFish')
AddEventHandler('doj:client:SellLegalFish', function()
    exports['qb-menu']:openMenu({
		{
            header = "Pier 45",
            isMenuHeader = true
        },
        {
            header = "Venda Peixe Cavalinha",
            txt = "Preço: "..Config.mackerelPrice.."€ cada",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 1
            }
        },
        {
            header = "Venda Bacalhau",
            txt = "Preço: "..Config.codfishPrice.."€ cada",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 2
            }
        },
		{
            header = "Venda Peixe Baixo",
            txt = "Preço: "..Config.bassPrice.."€ cada",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 3 
            }
        },
        {
            header = "Venda Peixe Linguado",
            txt = "Preço: "..Config.flounderPrice.."€ cada",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 4
            }
        },
		{
            header = "Venda Arraia",
            txt = "Preço: "..Config.stingrayPrice.."€ cada",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 5
            }
        },		
        {
            header = "Fechar",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('doj:client:buyFishingGear')
AddEventHandler('doj:client:buyFishingGear', function() 
    exports['qb-menu']:openMenu({
		{
            header = "Purchase Fishing Gear",
            isMenuHeader = true
        },
        {
            header = "Comprar Isca de Pesca",
            txt = Config.fishingBaitPrice.."€",
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 1
            }
        },
		{
            header = "Comprar Cana de Pesca",
            txt = Config.fishingRodPrice.."€",
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 2
            }
        },
        {
            header = "Âncora de Barco",
            txt = Config.BoatAnchorPrice.."€",
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 3
            }
        },
        {
            header = "Geladeira",
            txt = Config.FishingBoxPrice.."€",
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 4
            }
        },
        {
            header = "Fechar",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('doj:client:SellillegalFish')
AddEventHandler('doj:client:SellillegalFish', function() 
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
			local charinfo = QBCore.Functions.GetPlayerData().charinfo
			QBCore.Functions.Notify('Bem-vindo, '..charinfo.firstname..' '..charinfo.lastname)
			exports['qb-menu']:openMenu({
				{
					header = "Pier 45",
					isMenuHeader = true
				},
				{
					header = "Venda Golfinho",
					txt = "Preço: "..Config.dolphinPrice.."€ cada",
					params = {
						isServer = true,
						event = "fishing:server:SellillegalFish",
						args = 1
					}
				},
				{
					header = "Venda Tubarão Tigre",
					txt = "Preço: "..Config.sharktigerPrice.."€ cada",
					params = {
						isServer = true,
						event = "fishing:server:SellillegalFish",
						args = 2
					}
				},
				{
					header = "Venda Tubarão Martelo",
					txt = "Preço: "..Config.sharkhammerPrice.."€ cada",
					params = {
						isServer = true,
						event = "fishing:server:SellillegalFish",
						args = 3
					}
				},
				{
					header = "Venda Orca",
					txt = "Preço: "..Config.killerwhalePrice.."€ cada",
					params = {
						isServer = true,
						event = "fishing:server:SellillegalFish",
						args = 4
					}
				},
				{
					header = "Fechar",
					txt = "",
					params = {
						event = "qb-menu:closeMenu"
					}
				},
			})
		else
			QBCore.Functions.Notify('Você não pode vender para nós de momento, desculpe pelo inconveniente', 'error', 3500)
		end
	end, "pearlscard")
end)
