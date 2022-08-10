local Translations = {
     error = {
          failed_to_open_menu = 'Falha a abrir menu',
          withdraw_failed = 'Levantamento falhou:',
          bad_input = 'Numero errado',
          money_amount_more_than_zero = 'Montante acima de 0',
          can_not_withdraw_much = 'Não podes levantar tanto: '
     },
     success = {
          successful_withdraw = 'Levantamento feito: '
     },
     info = {
          no_money_in_account = 'Sem dinheiro na conta'
     },
     mail = {

     },
     menu = {
          back = 'Voltar',
          leave = 'Sair',

          -- qb-target
          qb_target_label = 'Pagamentos',

          -- qb-input / withdraw amount
          withdraw_amount = {
               header = 'Montante dinheiro',
               submitText = 'Levantar',
               textbox = 'Maximo: '
          },
          -- withdraw_menu
          withdraw_menu = {
               header = 'Banco (Pagamentos)',
               account_Information = 'Informações Conta',
               withdraw_all = 'Levantar Tudo',
               withdraw_amount = 'Levantar Montante',
               transaction_history = 'Historico',
               money_string = 'Dinheiro: %s€'
          },

          -- logs_menu
          logs_menu = {
               paycheck_logs = 'Logs Pagamentos',
               before = 'Antes : %s€',
               after = 'Depois : %s€',
               recived = 'Recebido %s€',
               withdraw = 'Levantado %s€',
               to = ' | para: ',
               from = ' | de: '
          }
     }
}

Lang = Locale:new({
     phrases = Translations,
     warnOnMissing = true
})
