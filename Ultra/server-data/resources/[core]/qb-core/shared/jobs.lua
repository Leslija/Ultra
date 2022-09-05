QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civil',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Desempregado',
                payment = 50
            },
        },
	},
    ['staff'] = {
		label = 'STAFF',
		defaultDuty = true,
		offDutyPay = true,
		grades = {
            ['0'] = {
                name = 'Staff',
                payment = 1000
            },
        },
	},
	['police'] = {
		label = 'PSP',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 1500
            },
			['1'] = {
                name = 'Agente',
                payment = 1750
            },
			['2'] = {
                name = 'Chefe',
                payment = 1750
            },
			['3'] = {
                name = 'Chefe Coordenador',
                payment = 2000
            },
			['4'] = {
                name = 'Oficial',
                payment = 2000
            },
            ['5'] = {
                name = 'Oficial Coordenador',
                payment = 2250
            },
			['6'] = {
                name = 'Sub-Diretor Nacional',
                payment = 2250
            },
			['7'] = {
                name = 'Diretor Nacional',
				isboss = true,
                payment = 2500
            },
        },
	},
	['ambulance'] = {
		label = 'INEM',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Estagiário',
                payment = 1250
            },
			['1'] = {
                name = 'Enfermeiro',
                payment = 1500
            },
			['2'] = {
                name = 'Médico',
                payment = 1750
            },
			['3'] = {
                name = 'Cirurgião',
                payment = 2000
            },
			['4'] = {
                name = 'Sub-Diretor Nacional',
				isboss = true,
                payment = 2250
            },
            ['5'] = {
                name = 'Diretor Nacional',
				isboss = true,
                payment = 2500
            },
        },
	},
    ['strtunners'] = {
		label = '6STR Tunners',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 400
            },
			['1'] = {
                name = 'Mecânico',
                payment = 400
            },
			['2'] = {
                name = 'Experiente',
                payment = 400
            },
			['3'] = {
                name = 'Dono',
				isboss = true,
                payment = 400
            },
        },
	},
    ['bennys'] = {
		label = 'Bennys',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 400
            },
			['1'] = {
                name = 'Mecânico',
                payment = 400
            },
			['2'] = {
                name = 'Experiente',
                payment = 400
            },
			['3'] = {
                name = 'Dono',
				isboss = true,
                payment = 400
            },
        },
	},
	['realestate'] = {
		label = 'Imobiliária',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 400
            },
			['1'] = {
                name = 'Agente',
                payment = 400
            },
			['2'] = {
                name = 'Gerente',
                payment = 400
            },
			['3'] = {
                name = 'Dono',
				isboss = true,
                payment = 400
            },
        },
	},
    -- CRAFT DE ARMAS
	['soa'] = {
		label = 'Sons Of Anarchy',
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 200
            },
			['1'] = {
                name = 'Membro',
                payment = 200
            },
			['2'] = {
                name = 'Sub-Chefe',
                payment = 200
            },
			['3'] = {
                name = 'Chefe',
                payment = 200,
				isboss = true
            },
        },
	},
    -- CRAFT DE ACESSÓRIOS
    ['thelost'] = {
		label = 'The Lost',
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 200
            },
			['1'] = {
                name = 'Membro',
                payment = 200
            },
			['2'] = {
                name = 'Sub-Chefe',
                payment = 200
            },
			['3'] = {
                name = 'Chefe',
                payment = 200,
				isboss = true
            },
        },
	},
    -- LAVAGEM DE DINHEIRO
    ['vanilla'] = {
		label = 'Vanilla',
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 200
            },
			['1'] = {
                name = 'Membro',
                payment = 200
            },
			['2'] = {
                name = 'Sub-Chefe',
                payment = 200
            },
			['3'] = {
                name = 'Chefe',
                payment = 200,
				isboss = true
            },
        },
	},
    -- BAIRROS / DROGA
    ['ballas'] = {
		label = 'Ballas',
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 200
            },
			['1'] = {
                name = 'Membro',
                payment = 200
            },
			['2'] = {
                name = 'Sub-Chefe',
                payment = 200
            },
			['3'] = {
                name = 'Chefe',
                payment = 200,
				isboss = true
            },
        },
	},
    ['families'] = {
		label = 'Families',
		grades = {
            ['0'] = {
                name = 'Recruta'
            },
			['1'] = {
                name = 'Membro',
                payment = 200
            },
			['2'] = {
                name = 'Sub-Chefe',
                payment = 200
            },
			['3'] = {
                name = 'Chefe',
                payment = 200,
				isboss = true
            },
        },
	},
    --
    ['trucker'] = {
		label = 'Entregas',
		grades = {
            ['0'] = {
                name = 'Condutor',
                payment = 200
            },
        },
	},
	['tow'] = {
		label = 'Reboques',
		grades = {
            ['0'] = {
                name = 'Condutor',
                payment = 200
            },
        },
	},
	['garbage'] = {
		label = 'Lixeiro',
		grades = {
            ['0'] = {
                name = 'Trabalhador',
                payment =200
            },
        },
	},
    ['bus'] = {
		label = 'Autocarros',
		grades = {
            ['0'] = {
                name = 'Condutor',
                payment = 200
            },
		},
	},
    ['mineiro'] = {
		label = 'Mineiro',
		grades = {
            ['0'] = {
                name = 'Trabalhador',
                payment = 200
            },
		},
	},
    ['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 200
            },
			['1'] = {
                name = 'Condutor',
                payment = 200
            },
			['2'] = {
                name = 'Gerente',
                payment = 200
            },
			['3'] = {
                name = 'Patrão',
				isboss = true,
                payment = 200
            },
        },
	},
    ['burgershot'] = {
		label = 'BurgerShot',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruta',
                payment = 200
            },
			['1'] = {
                name = 'Trabalhador',
                payment = 200
            },
			['2'] = {
                name = 'Gerente',
                payment = 200
            },
			['3'] = {
                name = 'Patrão',
				isboss = true,
                payment = 200
            },
        },
	}
}

