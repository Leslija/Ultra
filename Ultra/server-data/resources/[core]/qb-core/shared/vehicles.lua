QBShared = QBShared or {}
QBShared.VehicleHashes = {}

QBShared.Vehicles = {
	--- CATEGORIA 1
	['polo2018'] = {
		['name'] = 'Volkswagen Polo R-Line 2018',
		['brand'] = 'Volkswagen',
		['model'] = 'polo2018',
		['price'] = 120000,
		['category'] = 'Categoria1',
		['hash'] = `polo2018`,
		['shop'] = 'pdm',
	},

	['blista'] = {
		['name'] = 'Audi A3 1999',
		['brand'] = 'Audi',
		['model'] = 'blista',
		['price'] = 100000,
		['category'] = 'Categoria1',
		['hash'] = `blista`,
		['shop'] = 'pdm',
	},

	['supra2'] = {
		['name'] = 'Toyota Supra',
		['brand'] = 'Toyota',
		['model'] = 'supra2',
		['price'] = 500000,
		['category'] = 'Categoria1',
		['hash'] = `supra2`,
		['shop'] = 'pdm',
	},

	['evoque'] = {
		['name'] = 'Range Rover Evoque',
		['brand'] = 'Range Rover',
		['model'] = 'evoque',
		['price'] = 500000,
		['category'] = 'Categoria1',
		['hash'] = `evoque`,
		['shop'] = 'pdm',
	},

	

	['cp9a'] = {
		['name'] = 'Mitsubishi Evo VI',
		['brand'] = 'Mitsubishi',
		['model'] = 'cp9a',
		['price'] = 600000,
		['category'] = 'Categoria1',
		['hash'] = `cp9a`,
		['shop'] = 'pdm',
	},

	['a45amg'] = {
		['name'] = 'Mercedes-Benz Classe A45 AMG',
		['brand'] = 'Mercedes',
		['model'] = 'a45amg',
		['price'] = 400000,
		['category'] = 'Categoria1',
		['hash'] = `a45amg`,
		['shop'] = 'pdm',
	},

	['HDIron883'] = {
		['name'] = 'Harley Davidson 883',
		['brand'] = 'Harley',
		['model'] = 'HDIron883',
		['price'] = 500000,
		['category'] = 'Categoria1',
		['hash'] = `HDIron883`,
		['shop'] = 'pdm',
	},

	-- CATEGORIA 2

	['focusrs'] = {
		['name'] = 'Ford Focus 2017 RS',
		['brand'] = 'Ford',
		['model'] = 'focusrs',
		['price'] = 600000,
		['category'] = 'Categoria2',
		['hash'] = `focusrs`,
		['shop'] = 'pdm',
	},

	['jeepg'] = {
		['name'] = 'Jeep Gladiator',
		['brand'] = 'Jeep',
		['model'] = 'jeepg',
		['price'] = 750000,
		['category'] = 'Categoria2',
		['hash'] = `jeepg`,
		['shop'] = 'pdm',
	},

	['raptor150'] = {
		['name'] = 'Ford Raptor',
		['brand'] = 'Ford',
		['model'] = 'raptor150',
		['price'] = 650000,
		['category'] = 'Categoria2',
		['hash'] = `raptor150`,
		['shop'] = 'pdm',
	},

	['nissantitan17'] = {
		['name'] = 'Nissan Titan',
		['brand'] = 'Nissan',
		['model'] = 'nissantitan17',
		['price'] = 600000,
		['category'] = 'Categoria2',
		['hash'] = `nissantitan17`,
		['shop'] = 'pdm',
	},

	['rmodmk7'] = {
		['name'] = 'Volkswagen Golf MK7 Widebody',
		['brand'] = 'Volkswagen',
		['model'] = 'rmodmk7',
		['price'] = 700000,
		['category'] = 'Categoria2',
		['hash'] = `rmodmk7`,
		['shop'] = 'pdm',
	},

	['giuliagtam'] = {
		['name'] = 'Alfa Romeo Giulia',
		['brand'] = 'Alfa Romeo',
		['model'] = 'giuliagtam',
		['price'] = 850000,
		['category'] = 'Categoria2',
		['hash'] = `giuliagtam`,
		['shop'] = 'pdm',
	},
	['rs52021'] = {
		['name'] = 'Audi RS5 2021',
		['brand'] = 'Audi',
		['model'] = 'rs52021',
		['price'] = 900000,
		['category'] = 'Categoria2',
		['hash'] = `rs52021`,
		['shop'] = 'pdm',
	},
	['e63w213'] = {
		['name'] = 'Mercedes E63 AMG',
		['brand'] = 'Mercedes',
		['model'] = 'e63w213',
		['price'] = 1000000,
		['category'] = 'Categoria2',
		['hash'] = `e63w213`,
		['shop'] = 'pdm',
	},
	
	['m2f22'] = {
		['name'] = 'Bmw M2F22',
		['brand'] = 'BMW',
		['model'] = 'm2f22',
		['price'] = 1000000,
		['category'] = 'Categoria2',
		['hash'] = `m2f22`,
		['shop'] = 'pdm',
	},

	['m3e36'] = {
		['name'] = 'Bmw E36',
		['brand'] = 'BMW',
		['model'] = 'm3e36',
		['price'] = 900000,
		['category'] = 'Categoria2',
		['hash'] = `m3e36`,
		['shop'] = 'pdm',
	},

	-- CATEGORIA 3

	['22m5'] = {
		['name'] = 'BMW M5',
		['brand'] = 'BMW',
		['model'] = '22m5',
		['price'] = 1200000,
		['category'] = 'Categoria3',
		['hash'] = `22m5`,
		['shop'] = 'pdm',
	},

	['rmodrs6'] = {
		['name'] = 'Audi RS6 C8',
		['brand'] = 'Audi',
		['model'] = 'rmodrs6',
		['price'] = 1800000,
		['category'] = 'Categoria3',
		['hash'] = `rmodrs6`,
		['shop'] = 'pdm',
	},

	['rs7'] = {
		['name'] = 'Audi RS7',
		['brand'] = 'Audi',
		['model'] = 'rs7',
		['price'] = 1900000,
		['category'] = 'Categoria3',
		['hash'] = `rs7`,
		['shop'] = 'pdm',
	},

	['m4lb'] = {
		['name'] = 'Bmw M4 GT',
		['brand'] = 'BMW',
		['model'] = 'm4lb',
		['price'] = 1400000,
		['category'] = 'Categoria3',
		['hash'] = `m4lb`,
		['shop'] = 'pdm',
	},

	['bmwm8'] = {
		['name'] = 'Bmw M8',
		['brand'] = 'BMW',
		['model'] = 'bmwm8',
		['price'] = 2000000,
		['category'] = 'Categoria3',
		['hash'] = `bmwm8`,
		['shop'] = 'pdm',
	},

	['mlmansory'] = {
		['name'] = 'Maserati Levante',
		['brand'] = 'Maserati',
		['model'] = 'mlmansory',
		['price'] = 1600000,
		['category'] = 'Categoria3',
		['hash'] = `mlmansory`,
		['shop'] = 'pdm',
	},

	['bmws'] = {
		['name'] = 'Bmw S1000',
		['brand'] = 'BMW',
		['model'] = 'bmws',
		['price'] = 1500000,
		['category'] = 'Categoria3',
		['hash'] = `bmws`,
		['shop'] = 'pdm',
	},

	['rmodgt63'] = {
		['name'] = 'Mercedes GT63S',
		['brand'] = 'Mercedes',
		['model'] = 'rmodgt63',
		['price'] = 1800000,
		['category'] = 'Categoria3',
		['hash'] = `rmodgt63`,
		['shop'] = 'pdm',
	},

	['skyline'] = {
		['name'] = 'Nissan Skyline R34',
		['brand'] = 'Nissan',
		['model'] = 'skyline',
		['price'] = 1500000,
		['category'] = 'Categoria3',
		['hash'] = `skyline`,
		['shop'] = 'pdm',
	},

	['skyline'] = {
		['name'] = 'Nissan Skyline R34',
		['brand'] = 'Nissan',
		['model'] = 'skyline',
		['price'] = 1500000,
		['category'] = 'Categoria3',
		['hash'] = `skyline`,
		['shop'] = 'pdm',
	},

	['wraith19'] = {
		['name'] = 'Rolls Wraith',
		['brand'] = 'RollsRoyce',
		['model'] = 'wraith19',
		['price'] = 1300000,
		['category'] = 'Categoria3',
		['hash'] = `wraith19`,
		['shop'] = 'pdm',
	},

	['slr'] = {
		['name'] = 'Mercedes SLR',
		['brand'] = 'Mercedes',
		['model'] = 'slr',
		['price'] = 1500000,
		['category'] = 'Categoria3',
		['hash'] = `slr`,
		['shop'] = 'pdm',
	},

	['z1000'] = {
		['name'] = 'Kawasaki Z1000',
		['brand'] = 'Kawasaki',
		['model'] = 'z1000',
		['price'] = 1500000,
		['category'] = 'Categoria3',
		['hash'] = `z1000`,
		['shop'] = 'pdm',
	},

	-- CATEGORIA 4

	['q8prior'] = {
		['name'] = 'Audi Q8 Prime Edition',
		['brand'] = 'Audi',
		['model'] = 'q8prior',
		['price'] = 2400000,
		['category'] = 'Categoria4',
		['hash'] = `q8prior`,
		['shop'] = 'pdm',
	},

	['r8spyder20'] = {
		['name'] = 'Audi R8 Sypder',
		['brand'] = 'Audi',
		['model'] = 'r8spyder20',
		['price'] = 3000000,
		['category'] = 'Categoria4',
		['hash'] = `r8spyder20`,
		['shop'] = 'pdm',
	},

	['rmodx6'] = {
		['name'] = 'Bmw X6',
		['brand'] = 'BMW',
		['model'] = 'rmodx6',
		['price'] = 2500000,
		['category'] = 'Categoria4',
		['hash'] = `rmodx6`,
		['shop'] = 'pdm',
	},

	['bmwx7'] = {
		['name'] = 'BMW X7',
		['brand'] = 'BMW',
		['model'] = 'bmwx7',
		['price'] = 2300000,
		['category'] = 'Categoria4',
		['hash'] = `bmwx7`,
		['shop'] = 'pdm',
	},

	['g63amg6x6'] = {
		['name'] = 'Mercedes G63 6x6',
		['brand'] = 'Mercedes',
		['model'] = 'g63amg6x6',
		['price'] = 2100000,
		['category'] = 'Categoria4',
		['hash'] = `g63amg6x6`,
		['shop'] = 'pdm',
	},

	['g63m'] = {
		['name'] = 'Mercedes G63 Mansory',
		['brand'] = 'Mercedes',
		['model'] = 'g63m',
		['price'] = 2300000,
		['category'] = 'Categoria4',
		['hash'] = `g63m`,
		['shop'] = 'pdm',
	},

	['19gt500'] = {
		['name'] = 'Ford Mustang Shelby',
		['brand'] = 'Ford',
		['model'] = '19gt500',
		['price'] = 2600000,
		['category'] = 'Categoria4',
		['hash'] = `19gt500`,
		['shop'] = 'pdm',
	},

	['urus'] = {
		['name'] = 'Lamborghini Urus',
		['brand'] = 'Lamborghini',
		['model'] = 'urus',
		['price'] = 2600000,
		['category'] = 'Categoria4',
		['hash'] = `urus`,
		['shop'] = 'pdm',
	},

	['g63m'] = {
		['name'] = 'Mercedes G63 Mansory',
		['brand'] = 'Mercedes',
		['model'] = 'g63m',
		['price'] = 2300000,
		['category'] = 'Categoria4',
		['hash'] = `g63m`,
		['shop'] = 'pdm',
	},

	['tr22'] = {
		['name'] = 'Tesla Roadster ',
		['brand'] = 'Tesla',
		['model'] = 'tr22',
		['price'] = 4000000,
		['category'] = 'Categoria4',
		['hash'] = `tr22`,
		['shop'] = 'pdm',
	},

	['rocket'] = {
		['name'] = 'Rocket',
		['brand'] = 'Rocket',
		['model'] = 'rocket',
		['price'] = 3000000,
		['category'] = 'Categoria4',
		['hash'] = `rocket`,
		['shop'] = 'pdm',
	},

	['gtr'] = {
		['name'] = 'Nissan GTR',
		['brand'] = 'Nissan',
		['model'] = 'gtr',
		['price'] = 3100000,
		['category'] = 'Categoria4',
		['hash'] = `gtr`,
		['shop'] = 'pdm',
	},

	['911turbos'] = {
		['name'] = 'Porsche 911 TurboS',
		['brand'] = 'Porsche',
		['model'] = '911turbos',
		['price'] = 3500000,
		['category'] = 'Categoria4',
		['hash'] = `911turbos`,
		['shop'] = 'pdm',
	},

	['pistas'] = {
		['name'] = 'Ferrari 488 Pista Spider',
		['brand'] = 'Ferrari',
		['model'] = 'pistas',
		['price'] = 3600000,
		['category'] = 'Categoria4',
		['hash'] = `pistas`,
		['shop'] = 'pdm',
	},

	['f5095'] = {
		['name'] = 'Ferrari F50',
		['brand'] = 'Ferrari',
		['model'] = 'f5095',
		['price'] = 3000000,
		['category'] = 'Categoria4',
		['hash'] = `f5095`,
		['shop'] = 'pdm',
	},

	['panamera17turbo'] = {
		['name'] = 'Porsche Panamera Turbo',
		['brand'] = 'Porsche',
		['model'] = 'panamera17turbo',
		['price'] = 3700000,
		['category'] = 'Categoria4',
		['hash'] = `panamera17turbo`,
		['shop'] = 'pdm',
	},

	['rmodmartin'] = {
		['name'] = 'Aston Martin Superleggera',
		['brand'] = 'Aston Martin',
		['model'] = 'rmodmartin',
		['price'] = 3700000,
		['category'] = 'Categoria4',
		['hash'] = `rmodmartin`,
		['shop'] = 'pdm',
	},

	['992c'] = {
		['name'] = 'Porsche 911 Carrera S Cabriolet',
		['brand'] = 'Porsche',
		['model'] = '2200000',
		['price'] = 3700000,
		['category'] = 'Categoria4',
		['hash'] = `992c`,
		['shop'] = 'pdm',
	},

	['gle21'] = {
		['name'] = 'Mercedes Benz GLE63s AMG 2021',
		['brand'] = 'Mercedes',
		['model'] = 'gle21',
		['price'] = 2100000,
		['category'] = 'Categoria4',
		['hash'] = `gle21`,
		['shop'] = 'pdm',
	},

	['macanturbo'] = {
		['name'] = 'Porsche Macan',
		['brand'] = 'Porsche',
		['model'] = 'macanturbo',
		['price'] = 2500000,
		['category'] = 'Categoria4',
		['hash'] = `macanturbo`,
		['shop'] = 'pdm',
	},

	['r6'] = {
		['name'] = 'Yamaha YZF R6',
		['brand'] = 'Yamaha',
		['model'] = 'r6',
		['price'] = 2200000,
		['category'] = 'Categoria4',
		['hash'] = `r6`,
		['shop'] = 'pdm',
	},

	-- CATEGORIA 5

	['rmodlp750'] = {
		['name'] = 'Lamborghini Aventador SVJ',
		['brand'] = 'Lamborghini',
		['model'] = 'rmodlp750',
		['price'] = 4000000,
		['category'] = 'Categoria5',
		['hash'] = `rmodlp750`,
		['shop'] = 'pdm',
	},

	['18performante'] = {
		['name'] = 'Lamborghini Huracan Performance',
		['brand'] = 'Lamborghini',
		['model'] = '18performante',
		['price'] = 4100000,
		['category'] = 'Categoria5',
		['hash'] = `18performante`,
		['shop'] = 'pdm',
	},

	['p1'] = {
		['name'] = 'McLaren P1',
		['brand'] = 'McLaren',
		['model'] = 'p1',
		['price'] = 4200000,
		['category'] = 'Categoria5',
		['hash'] = `p1`,
		['shop'] = 'pdm',
	},

	['divo'] = {
		['name'] = 'Bugatti Divo',
		['brand'] = 'Bugatti',
		['model'] = 'divo',
		['price'] = 5000000,
		['category'] = 'Categoria5',
		['hash'] = `divo`,
		['shop'] = 'pdm',
	},

	['vulcan'] = {
		['name'] = 'Aston Martin Vulcan',
		['brand'] = 'Aston Martin',
		['model'] = 'vulcan',
		['price'] = 4500000,
		['category'] = 'Categoria5',
		['hash'] = `vulcan`,
		['shop'] = 'pdm',
	},

	['victorhirot'] = {
		['name'] = 'Aston Martin Victor Animated',
		['brand'] = 'Aston Martin',
		['model'] = 'victorhirot',
		['price'] = 4600000,
		['category'] = 'Categoria5',
		['hash'] = `victorhirot`,
		['shop'] = 'pdm',
	},

	-- VIP

	['mi8'] = {
		['name'] = 'BMW I8',
		['brand'] = 'BMW',
		['model'] = 'mi8',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `mi8`,
		['shop'] = 'pdm',
	},

	['sclgt63s'] = {
		['name'] = 'Mercedes SCL Diamant GT63S',
		['brand'] = 'Mercedes',
		['model'] = 'sclgt63s',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `sclgt63s`,
		['shop'] = 'pdm',
	},

	['bdivo'] = {
		['name'] = 'Bugatti Divo Prezmo',
		['brand'] = 'Bugatti',
		['model'] = 'bdivo',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `bdivo`,
		['shop'] = 'pdm',
	},


	['aperta'] = {
		['name'] = 'Ferrari La Ferrari',
		['brand'] = 'Ferrari',
		['model'] = 'aperta',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `aperta`,
		['shop'] = 'pdm',
	},


	['roma20'] = {
		['name'] = 'Ferrari Roma',
		['brand'] = 'Ferrari',
		['model'] = 'roma20',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `roma20`,
		['shop'] = 'pdm',
	},

	['h2carb'] = {
		['name'] = 'Kawasaki H2',
		['brand'] = 'Kawasaki',
		['model'] = 'h2carb',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `h2carb`,
		['shop'] = 'pdm',
	},

	['jes'] = {
		['name'] = 'Koenigsegg Jesko',
		['brand'] = 'Koenigsegg',
		['model'] = 'jes',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `jes`,
		['shop'] = 'pdm',
	},

	['rmodskyline34'] = {
		['name'] = 'Nissan Skyline R34',
		['brand'] = 'Nissan',
		['model'] = 'rmodskyline34',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `rmodskyline34`,
		['shop'] = 'pdm',
	},

	['rmodveneno'] = {
		['name'] = 'Lamborghini Veneno',
		['brand'] = 'Lamborghini',
		['model'] = 'rmodveneno',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `rmodveneno`,
		['shop'] = 'pdm',
	},

	['pandemraptor'] = {
		['name'] = 'Pandem Raptor',
		['brand'] = 'Ford',
		['model'] = 'pandemraptor',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `pandemraptor`,
		['shop'] = 'pdm',
	},

	['pgt3'] = {
		['name'] = 'Porsche GT3',
		['brand'] = 'Porsche',
		['model'] = 'pgt3',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `pgt3`,
		['shop'] = 'pdm',
	},

	['defenderoffp'] = {
		['name'] = 'Range Rover Defender',
		['brand'] = 'Range Rover',
		['model'] = 'defenderoffp',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `defenderoffp`,
		['shop'] = 'pdm',
	},

	['812mnsry'] = {
		['name'] = 'Ferrari 812 Mansory',
		['brand'] = 'Ferrari',
		['model'] = '812mnsry',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `812mnsry`,
		['shop'] = 'pdm',
	},

	['sto'] = {
		['name'] = 'Lamborghini STO',
		['brand'] = 'Lamborghini',
		['model'] = 'sto',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `sto`,
		['shop'] = 'pdm',
	},

	['lamks'] = {
		['name'] = 'Lamborghini Aventador KS AL',
		['brand'] = 'Lamborghini',
		['model'] = 'lamks',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `lamks`,
		['shop'] = 'pdm',
	},

	['casup'] = {
		['name'] = 'Toyota Supra MKV',
		['brand'] = 'Toyota',
		['model'] = 'casup',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `casup`,
		['shop'] = 'pdm',
	},

	['brz'] = {
		['name'] = 'Rocket Bunny V3 BRZ',
		['brand'] = 'Subaru',
		['model'] = 'brz',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `brz`,
		['shop'] = 'pdm',
	},

	['bugvr'] = {
		['name'] = 'Bugatti Veyron Grand Sport',
		['brand'] = 'Bugatti',
		['model'] = 'bugvr',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `bugvr`,
		['shop'] = 'pdm',
	},

	['rmodsian'] = {
		['name'] = 'Lamborghini Sian',
		['brand'] = 'Lamborghini',
		['model'] = 'rmodsian',
		['price'] = 100000000,
		['category'] = 'VIP',
		['hash'] = `rmodsian`,
		['shop'] = 'pdm',
	},

	-- BARCOS

	['seashark'] = {
		['name'] = 'SeaShark',
		['brand'] = 'Barcos',
		['model'] = 'seashark',
		['price'] = 40000,
		['category'] = 'boats',
		['hash'] = `seashark`,
		['shop'] = 'boats',
	},

	['speeder'] = {
		['name'] = 'Speeder',
		['brand'] = 'Barcos',
		['model'] = 'speeder',
		['price'] = 350000,
		['category'] = 'boats',
		['hash'] = `speeder`,
		['shop'] = 'boats',
	},

	['marquis'] = {
		['name'] = 'Marquis',
		['brand'] = 'Barcos',
		['model'] = 'marquis',
		['price'] = 350000,
		['category'] = 'boats',
		['hash'] = `marquis`,
		['shop'] = 'boats',
	},




	
}

for _, v in pairs(QBShared.Vehicles) do
	QBShared.VehicleHashes[v.hash] = v
end
