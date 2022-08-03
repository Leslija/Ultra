local Translations = {
    notify = {
        ["no_money"] = "Não tens dinheiro em mão suficiente",
        ["refuel_cancel"] = "Abastecimento cancelado",
        ["jerrycan_full"] = "O galão já está cheio",
        ["vehicle_full"] = "O depósito já está cheio",
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
