# SAFKY DRUGS SYSTEM
A complete system to make your ilegal part go wild! (ESX/QBCORE)
- 3 Drugs Available
- Selling System
- Wash Money System
- All Configurable: Items, Times, Amounts, Fields, Coords, Peds
- Compatible with eye-target systems
- Configurable required jobs to sell drugs and washmoney (or let it public)
- Configurable Payment Type 
- Editable Notifications
- Logs
- 0.00ms and 0.03(in use)

__PREVIEW__
[https://youtu.be/47f7wWF6rjU]



## Instalation ESX:
```
0) Download s_menu, put `ensure s_menu` to your start config and resource called `s_menu` into your resources folder
1) Put `ensure s_drugs` to your start config and resource called `s_drugs` into your resources folder
2) Open config.lua and read every config and change like u want
3) Discord Logs - server/webhook.lua
4) Enjoy!

```

## Instalation QB-CORE:
```
1) Put `ensure s_drugs` to your start config and resource called `s_drugs` into your resources folder
2) Open config.lua and read every config and change like u want
3) Discord Logs - server/webhook.lua
4) Enjoy!

```

## DEPENDECYS (ESX ONLY)
1) s_menu https://github.com/paulosafky/s_menu
2) progressbar https://github.com/quasar-scripts/progressbar


## SAFKY Discord
https://discord.gg/Rcth7Avbkm


## ITEMS

-- DROGAS
    ["weedleaf"] 				     = {["name"] = "weedleaf", 			 			["label"] = "Folhas de Erva", 		    ["weight"] = 50, 		["type"] = "item", 		["image"] = "weedleaf.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Estas folhas cheiram muito bem mesmo..."},
	['weed_brick'] 		 		     = {['name'] = 'weed_brick', 				    ['label'] = 'Erva Processada', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'weed_brick.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Erva Processada'},
	['weed_baggy'] 					 = {['name'] = 'weed_baggy', 			  	  	['label'] = 'Erva 1g', 			        ['weight'] = 10, 		['type'] = 'item', 		['image'] = 'weed_baggy.png', 		    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Erva pronta para vender'},
    ["cocaine"] 				     = {["name"] = "cocaine", 			 			["label"] = "Folhas de Cocaína", 		["weight"] = 50, 		["type"] = "item", 		["image"] = "cocaine.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Estas folhas cheiram muito bem mesmo..."},
	['coke_brick'] 		 			 = {['name'] = 'coke_brick', 					['label'] = 'Pacote Cocaina', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'coke_brick.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pacote de Cocaina'},
	['cokebaggy'] 					 = {['name'] = 'cokebaggy', 			  	  	['label'] = 'Cocaína 1g', 			    ['weight'] = 10, 		['type'] = 'item', 		['image'] = 'cocaine_baggy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'To get happy real quick'},
    ["chemicals"] 		 			 = {["name"] = "chemicals", 				    ["label"] = "Químicos", 				["weight"] = 50, 		["type"] = "item", 		["image"] = "chemicals.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Hum.. químicos?"},
    ['meth_1oz'] 			 	     = {['name'] = 'meth_1oz', 					    ['label'] = 'Onça de Meta', 			['weight'] = 100, 		['type'] = 'item', 		['image'] = 'meth_1oz.png', 			['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A ounce of the finest teeth rotting goodness!'},	
	['meth'] 			 	         = {['name'] = 'meth', 						    ['label'] = 'Metanfetamína 1g', 		['weight'] = 10, 		['type'] = 'item', 		['image'] = 'meth.png', 				['unique'] = false,    	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A gram of the finest teeth rotting goodness!'},	
    ["petroleo"] 				     = {["name"] = "petroleo", 			 			["label"] = "Barril Petróleo", 		    ["weight"] = 50, 		["type"] = "item", 		["image"] = "petroleo.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Barril de Petroleo..."},
    ["barrililegal"] 				 = {["name"] = "barrililegal", 			 	    ["label"] = "Gasolina Ilegal", 		    ["weight"] = 50, 		["type"] = "item", 		["image"] = "barrililegal.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Barril de Gasolina Ilegal..."},
    ["drug_scales"] 		 	     = {["name"] = "drug_scales", 				    ["label"] = "Balança", 					["weight"] = 1500, 	    ["type"] = "item", 		["image"] = "drug_scales.png", 		    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "A set of premium scales for weighing out decimals.."},
	['drug_cuttingkit'] 			 = {['name'] = 'drug_cuttingkit', 			    ['label'] = 'Kit de Corte', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'drug_cuttingkit.png', 	    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A mirror, a razor blade.. obviously this is a make up kit..'},
    
