Config = {}


Config.Locale = 'br'
    -- Set the clothes IDs, in this case, leave the ped semi naked
list_cloth = {
    {name = "Hats", type = "Prop", item = 0, male_id = 11, female_id = -1},       
    {name = "Glasses", type = "Prop", item = 1, male_id = 14, female_id = 5},         
    {name = "Hats", type = "Variation", item = 1, male_id = 0, female_id = 0},     
    {name = "Shirts", type = "Variation", item = 8, male_id = -1, female_id = -1},  
    {name = "Trunk", type = "Variation", item = 3, male_id = 15, female_id = 15},   
    {name = "Jackets", type = "Variation", item = 11, male_id = -1, female_id = 15},  
    {name = "Trunk", type = "Variation", item = 3, male_id = 15, female_id = 15},   
    {name = "Pants", type = "Variation", item = 4, male_id = 75, female_id = 15},   
    {name = "Shoes", type = "Variation", item = 6, male_id = 49, female_id = 35},   
    {name = "Vest", type = "Variation", item = 9, male_id = 0, female_id = 0},     
    {name = "Bag", type = "Variation", item = 5, male_id = 0, female_id = 0},     
}

-- Tattoos available at the store
tattoos_list = {
    {title = "Degradado de pelo", dlc = "hair_degrade", price = 5, qty = 65, acquired = 0, has = false, current = 0}, 
    
    -- ### Necessary to Build FiveM (sv_enforceGameBuild 2189) ###
    {title = "Heists2", dlc = "mpheist4_overlays", price = 100, qty = 66, acquired = 0, has = false, current = 0}, 
    {title = "Heists", dlc = "mpheist3_overlays", price = 100, qty = 90, acquired = 0, has = false, current = 0}, 
    {title = "Vinewood", dlc = "mpvinewood_overlays", price = 100, qty = 66, acquired = 0, has = false, current = 0}, 

    -- Normal
    {title = "Beach", dlc = "mpbeach_overlays", price = 100, qty = 31, acquired = 0, has = false, current = 0}, 
    {title = "Business", dlc = "mpbusiness_overlays", price = 100, qty = 26, acquired = 0, has = false, current = 0}, 
    {title = "Airraces", dlc = "mpairraces_overlays", price = 100, qty = 16, acquired = 0, has = false, current = 0}, 
    {title = "Biker", dlc = "mpbiker_overlays", price = 100, qty = 122, acquired = 0, has = false, current = 0}, 
    {title = "Christmas2", dlc = "mpchristmas2_overlays", price = 100, qty = 60, acquired = 0, has = false, current = 0}, 
    {title = "Gunrunning", dlc = "mpgunrunning_overlays", price = 100, qty = 62, acquired = 0, has = false, current = 0}, 
    {title = "Hipster", dlc = "mphipster_overlays", price = 100, qty = 98, acquired = 0, has = false, current = 0}, 
    {title = "Importexport", dlc = "mpimportexport_overlays", price = 100, qty = 24, acquired = 0, has = false, current = 0}, 
    {title = "Lowrider", dlc = "mplowrider_overlays", price = 100, qty = 34, acquired = 0, has = false, current = 0}, 
    {title = "Lowrider2", dlc = "mplowrider2_overlays", price = 100, qty = 32, acquired = 0, has = false, current = 0}, 
    {title = "Luxe", dlc = "mpluxe_overlays", price = 100, qty = 30, acquired = 0, has = false, current = 0}, 
    {title = "Luxe2", dlc = "mpluxe2_overlays", price = 100, qty = 34, acquired = 0, has = false, current = 0}, 
    {title = "Smuggler", dlc = "mpsmuggler_overlays", price = 100, qty = 52, acquired = 0, has = false, current = 0}, 
    {title = "Stunt", dlc = "mpstunt_overlays", price = 100, qty = 100, acquired = 0, has = false, current = 0}, 
    {title = "Multiplayer", dlc = "multiplayer_overlays", price = 100, qty = 132, acquired = 0, has = false, current = 0}, 
}

-- Extra settings
scale = '1.0'
pos_x = '75%'
pos_y = '25%'
AutoHideClothes = true
freetattoos = false

-- Notify lua
Texts = {
    Open_Store = "Bem-vindo a Malditos Ultra Tattoo.",                                  
    Close_Store = "Volta depois, loja fechada!",                                                  
    Without_money = "Não tens dinheiro suficiente.",          
    Spent1 = "Gastaste",                                
    Spent2 = "em tatatuagens.", 
    Money_Symbol = "€",    
    Controls = "Pressiona ENTER para tatuar e DEL para apagar a tatuagem.",                            
}


Texts_Nui = {
    Title = "MALDITOS Ultra TATTOO",                                                    
    Info1 = "",     
    Info2 = "",                                   
    Info3 = "",                                              
    Info4 = "",                                   
    Info5 = "",                                             
    ButtonRemoveTattoo = "Eliminar todas as tatuagens",                                   
    ButtonTattooRemoved = "Eliminaste todas as tatuagens",                                 
    Money_Symbol = "€",                                                            
    QtyTattoos = "Quantidade:",                                                         
    TattoosAcquired = "Tatuagem adquirida!",                                        
    TattoosRemoved = "Eliminaste uma tatuagem.",                                         
    AlreadyHaveTattoo = "Já tens esta tatuagem.",                                                   
}


