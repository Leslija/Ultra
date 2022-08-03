local Translations = {
    error = {
        not_in_range = 'Estás muito longe do centro de emprego'
    },
    success = {
        recived_license = 'Tu recebes-te %{value}'
    },
    info = {
        bilp_text = 'Centro de Emprego',
        city_services_menu = '~g~E~w~ - Centro de Emprego',
        id_card = 'Cartão de Cidadão',
        driver_license = 'Carta de Condução',
        weaponlicense = 'Porte de Arma',
        new_job = 'Parabéns pelo o teu novo emprego! (%{job})'
    },
    email = {
        mr = 'Sr',
        mrs = 'Sra',
        sender = 'Ultra RP',
        subject = 'Carta de Condução',
        message = 'Olá %{gender} %{lastname}<br /><br />Acabamos de receber a informação de que alguém precisa de umas aulas de condução<br />Alguma coisa contata-nos:<br />Nome: <strong>%{firstname} %{lastname}</strong><br />Nº Telemóvel: <strong>%{phone}</strong><br/><br/>Cumprimentos,<br />ULTRA RP'
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
