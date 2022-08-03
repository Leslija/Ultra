local Translations = {
    error = {
        no_deposit = "$%{value} Depósito Obrigatório",
        cancelled = "Cancelado",
        vehicle_not_correct = "Não é o veiculo certo!",
        no_driver = "Tens que ser o condutor..",
        no_work_done = "Não fizeste nenhum trabalho ainda..",
    },
    success = {
        paid_with_cash = "$%{value} Depósito pago com dinheiro",
        paid_with_bank = "$%{value} Depósito pago pelo banco",
        refund_to_cash = "$%{value} Depósito pago com dinheiro",
        you_earned = "Tu ganhas-te %{value}€",
        payslip_time = "Foste a todas as lojas .. Hora do pagamento!",
    },
    menu = {
        header = "Camiões disponiveis",
        close_menu = "⬅ Fechar Menu",
    },
    mission = {
        store_reached = "Apanha uma caixa no camião [E] e entrega",
        take_box = "Tira uma caixa de produtos",
        deliver_box = "Entrega caixa de produtos",
        another_box = "Tirar outra caixa de produtos",
        goto_next_point = "Entregas-te todos os produtos, Para o próximo ponto",
    },
    info = {
        deliver_e = "~g~E~w~ - Entregar Produtos",
        deliver = "Entregar Produtos",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
