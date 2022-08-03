fx_version 'adamant'
game 'gta5'

client_script "names.lua"
 
files {
    'data/**/*.meta'
}

data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.meta'

files {
	'audioconfig/r34sound_game.dat151.rel',
	'audioconfig/r34sound_sounds.dat54.rel',
	'sfx/dlc_r34sound/r34sound.awc',
	'sfx/dlc_r34sound/r34sound_npc.awc'
}

data_file 'AUDIO_GAMEDATA' 'audioconfig/r34sound_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/r34sound_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_r34sound'