local Translations = {
    error = {
        finish_work = "Primeiro termina o teu trabalho.",
        vehicle_not_correct = "Este não é o veículo certo.",
        failed = "Falhou",
        not_towing_vehicle = "Tens que ter estado num reboque primeiro",
        too_far_away = 'Estás muito longe',
        no_work_done = "Ainda não fizeste nenhum trabalho.",
        no_deposit = "%{value}€ Depósito Requerido",
    },
    success = {
        paid_with_cash = "%{value}€ Depósito pago com dinheiro",
        paid_with_bank = "%{value}€ Depósito pago pelo Banco",
        refund_to_cash = "%{value}€ Depósito pago com dinheiro",
        you_earned = "Tu ganhas-te %{value}€",
    },
    menu = {
        header = "Available Trucks",
        close_menu = "⬅ Close Menu",
    },
    mission = {
        delivered_vehicle = "Entregas-te um veículo",
        get_new_vehicle = "Um novo trabalho está disponivel",
        towing_vehicle = "A rebocar veículo...",
        goto_depot = "Leva o veículo para o Hayes Depot",
        vehicle_towed = "Veículo Rebocado",
        untowing_vehicle = "Remover o veículo",
        vehicle_takenoff = "Remover veículo",
    },
    info = {
        tow = "Coloca um veículo no reboque",
        toggle_npc = "Trabalho NPC",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
