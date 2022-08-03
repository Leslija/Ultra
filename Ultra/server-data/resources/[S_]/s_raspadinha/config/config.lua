Config = {}
Config.Locale = 'en'

 -- You don't have to sum to sum the chances of all of the prices to 100. The totel will be decided based on the
 -- <chance of one price>/<total of all prices>. e.g. Price: 'Common' has a chance of '50' and the total of all chances is 100, so 50/100 (50%)
 -- chance of packing common. You may add as many prices as you want. Follow the preset logic.
 Config.Prices = {
  Nothing = {
    chance = 50,
    message = 'Tenta outra vez!',
    price = {
      price_money = 0,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Common = {
    chance = 20,
    message = 'Ganhas-te uma raspadinha nova, será desta vez?',
    price = {
      price_money = 0,
      item = {
        price_is_item = true,
        item_name = 'raspadinha',
        item_label = 'Raspadinha',
        item_amount = 1
      }
    }
  },
  Rare = {
    chance = 15,
    message = 'Bem... dá para o gasto! Ganhas-te 250€!',
    price = {
      price_money = 250,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Epic = {
    chance = 9,
    message = 'Que espetáculo! Ganhas-te 750€!',
    price = {
      price_money = 750,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Legendary = {
    chance = 1,
    message = '1º PRÉMIO, oh meu deus! Ganhas-te 10,000€!',
    price = {
      price_money = 1000,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  }
}

Config.Webhooks = {
  webhooksEnabled = true, -- enable/disable webhooks. Place your 'Discord WEBHOOK URL' in server/s_webhooks.lua:1
  logProperties = {
    possibleCheatingAttempt = true, -- will trigger on possible cheating attempt
    winMessages = true, -- will trigger on win (both money and item)
    loseMessages = false, -- will trigger on lose
    earlyMessage = false -- will trigger if person doesn't fully scratch ticket
  },
}

Config.ScratchCooldownInSeconds = 3 -- Cooldown in SECONDS, when will player be able to scratch another ticket? If below 30 will show notification until timer finished
Config.ShowCooldownNotifications = true -- Show a notification to player with the remaining cooldown timer
Config.ShowUsedTicketNotification = false  -- Show a notification to player whenever a ticket is used
Config.ShowResultTicketNotification = true  -- Show a notification with message of price ticket. See Config.Prices.message
Config.ScratchAmount = 80    -- Percentage of the ticket that needs to be scrapped away for the price to be 'seen'