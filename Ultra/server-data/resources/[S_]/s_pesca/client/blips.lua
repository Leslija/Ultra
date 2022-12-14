Citizen.CreateThread(function()
	LaPuertaBlip = AddBlipForCoord(Config.BoatSpawnLocation.LaPuerta)
	SetBlipSprite(LaPuertaBlip, 410)
	SetBlipDisplay(LaPuertaBlip, 4)
	SetBlipScale(LaPuertaBlip, 0.5)
	SetBlipColour(LaPuertaBlip, 74)
    SetBlipAsShortRange(LaPuertaBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Pesca")
    EndTextCommandSetBlipName(LaPuertaBlip)


	PaletoCoveBlip = AddBlipForCoord(Config.BoatSpawnLocation.PaletoCove)
	SetBlipSprite(PaletoCoveBlip, 410)
	SetBlipDisplay(PaletoCoveBlip, 4)
	SetBlipScale(PaletoCoveBlip, 0.5)
	SetBlipColour(PaletoCoveBlip, 74)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Pesca")
    EndTextCommandSetBlipName(PaletoCoveBlip)

	ElGordoBlip = AddBlipForCoord(Config.BoatSpawnLocation.ElGordo)
	SetBlipSprite(ElGordoBlip, 410)
	SetBlipDisplay(ElGordoBlip, 4)
	SetBlipScale(ElGordoBlip, 0.5)
	SetBlipColour(ElGordoBlip, 74)
    SetBlipAsShortRange(ElGordoBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Pesca")
    EndTextCommandSetBlipName(ElGordoBlip)

	PearlsSellsBlip = AddBlipForCoord(Config.PearlsSellsBlip)
	SetBlipSprite(PearlsSellsBlip, 68)
	SetBlipDisplay(PearlsSellsBlip, 4)
	SetBlipScale(PearlsSellsBlip, 0.5)
	SetBlipColour(PearlsSellsBlip, 74)
    SetBlipAsShortRange(PearlsSellsBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Venda Peixes")
    EndTextCommandSetBlipName(PearlsSellsBlip)
end)
