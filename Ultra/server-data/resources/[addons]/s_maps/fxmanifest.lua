fx_version 'adamant'
games { 'gta5' }

description 'SAFKY PACK MAPS'

this_is_a_map 'yes'

-- HOTEL

data_file 'TIMECYCLEMOD_FILE' 'nutt_timecycle_mods_1.xml'

files {
         "nutt_timecycle_mods_1.xml",

}

-- BENNYS

data_file 'DLC_ITYP_REQUEST' 'stream/patoche_elevatorb1.ytyp'

-- BANCO PRINCIPAL

files {
    'k4mb1_ornate_bank.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'k4mb1_ornate_bank.ytyp'

client_scripts {
  'client.lua'
}

-- ESQUADRA

data_file 'TIMECYCLEMOD_FILE' 'gabz_mrpd_timecycle.xml'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'

files {
	'gabz_mrpd_timecycle.xml',
	'interiorproxies.meta'
}

client_script {
    "gabz_mrpd_entitysets.lua"
}


