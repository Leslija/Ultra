-- --============================================================== Exports
exports[Config.targetExport]:AddTargetModel(`a_m_m_farmer_01`, {
    options = {
        {
            event = "doj:client:BoatMenu",
            icon = "fas fa-anchor",
            label = "Alugar Barco",
            location = 1 --LaPuerta
        },
		{
            event = "doj:client:buyFishingGear",
            icon = "fas fa-fish",
            label = "Equipamento Pesca",
        },
    },
    distance = 10.0
})

exports[Config.targetExport]:AddTargetModel(`u_m_m_filmdirector`, {
    options = {
        {
            event = "doj:client:BoatMenu",
            icon = "fas fa-anchor",
            label = "Alugar Barco",
            location = 2 --PaletoCove
        },
		{
            event = "doj:client:buyFishingGear",
            icon = "fas fa-fish",
            label = "Equipamento Pesca",
        },
    },
    distance = 10.0
})

exports[Config.targetExport]:AddTargetModel(`s_m_o_busker_01`, {
    options = {
        {
            event = "doj:client:BoatMenu",
            icon = "fas fa-anchor",
            label = "Alugar Barco",
            location = 3 --ElGordo
        },
		{
            event = "doj:client:buyFishingGear",
            icon = "fas fa-fish",
            label = "Equipamento Pesca",
        },
    },
    distance = 10.0
})

exports[Config.targetExport]:AddTargetModel(`s_m_y_busboy_01`, {
    options = {
        {
            event = "doj:client:SellLegalFish",
            icon = "fa fa-fish",
            label = "Vender Peixe",
        },
		{
            event = "doj:client:SellillegalFish",
            icon = "fa fa-fish",
            label = "Vender Peixe Exótico",
        },
    },
    distance = 10.0
})
