local Translations = {
    notify = {
        ["no_money"] = "Não tens dinhero suficiente",
        ["refuel_cancel"] = "Cancelado",
        ["jerrycan_full"] = "Jerry Can esta cheio",
        ["jerrycan_empty"] = "Jerry Can esta vazio",
        ["vehicle_full"] = "Tanque já esta cheio",
        ["already_full"] = "Já esta cheio",
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
