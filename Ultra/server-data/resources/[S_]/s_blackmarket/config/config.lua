Config = {}
--##FRAMEWORK
Config.Framework = 'ESX' -- 'ESX' or 'QBCore'.
Config.getSharedObject = "esx:getSharedObject" --Change if you use an ESX Custom or ignore it.
--##TARGET
Config.Target = true -- Enable eye-target system
Config.TargetType = 's_target' -- For QBCore use s_target

Config.Blip = { enabled = true, sprite = 362, display = 6, scale = 0.5, colour = 1, label = "Black Market"}
Config.Fee = 0.1 -- Comission to blackmarket when buying
Config.SellFee = 0.2 --- Pay a comission to announce

Config.Location = {
    coords = vector3(2120.703, 4784.635, 40.97039), 
    heading = 291.7271,
    model = "a_m_m_og_boss_01",

}

Config.BlackMarketItems = { -- Put here the items u want to players be able to sale on blackmarket
    "rubber",
    "plastic",
    "metalscrap",
    "armor",
    "heavyarmor",
    "handcuffs",
    "pistol_suppressor",
    "pistol_extendedclip",
    "pistol_flashlight",
    "smg_extendedclip",
    "smg_flashlight",
    "smg_scope",
    "smg_grip",
    "smg_drummag",
    "rifle_extendedclip",
    "rifle_drummag",
    "rifle_flashlight",
    "rifle_scope",
    "rifle_grip",
    "rifle_suppressor",
    "pecadearma",
    "handcuffs",
    "lockpick",
    "hack_usb",
    "gasmask",
    "cutter",
    "c4_bomb",
    "thermite_bomb",
    "bag",
    "drill",
    "laptop",
    "big_drill",
    "drug_scales",
    "drug_cuttingkit",
   
}


translate = {
    CURRENCY_SYMBOL = " €",
    BLACK = "Black",
    MARKET = "Market",
    COMMISION = "Comission",
    SORTBY = "Sort By",
    SEARCH = "Search for a product",
    NAME = "Name",
    BUY = "BUY",
    CONFIRM = "Confirm",
    BACK = "Back",
    AMOUNT = "Total",
    FINAL_PRICE = "Final Price",
    CONFIRM_BUY = "Confirm",
    REMOVE = "REMOVE",
    COLLECT = "Receive",
    ANNOUNCE = "Announce",
    MESSAGE_REMOVE = "You will not pay nothing to remove.",
    PRICE_PER_UNIT = "Price unit",
    ANONYMOUS = "Anonymous",
    PRICE_FEE = "To announce you will pay a comission of",
    VALUE_RECEIVE = "When you sale everything you will receive",
    LOADING_PRODUCTS = "Loading products...",
    LOADING_MYADS = "Loading blackmarket...",
    LOADING_NEWAD = "Loading Inventory...",
    LOADING_SOLD = "Loading Sales...",
    TRANSACTION = "Making the transaction...",
    LOOKING = "Search for a product...",
    DONT_HAVE_ITEM = "You dont have that quantity",
    DONT_HAVE_MONEY = "You dont have enough money",
    CANT_CARRY_ITEM = "You dont have enough space",
    NO_SALE = "This product is not on sale anymore",
    NO_EXIST = "This product dont exist",
    CANT_OWNER = "You can't buy your items.",
    CANT_ITEM = "This product cant be sold.",
    NOT_OWNER = "This product is not yours",
    NOT_AMOUNT = "That amount is more than what is selling",
    CANT_SAME = "You cant announce the same product twice",
    BUY_SUCCESSFULL = "Bought successfull",
    ADVERTISE_SUCCESSFULL = "Announce successfull",
    REMOVE_SUCCESSFULL = "Removed successfull",
    RECEIVED_SUCCESSFULL = "Received successfull",
    SELL_SUCCESSFULL = "Sell successfull",
    
}