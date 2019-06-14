extends VBoxContainer
var master_bus
var music_bus
var sfx_bus
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
#func _process(delta):
#	_save()
#func _load():
#	var load_ = File.new()
#	load_.open(str(documents) +"/Pixel Zone/.data/settings_audio_master.save", File.READ)
#	var loaded_volume = parse_json(load_.get_line())
#	$VolumeBar.set_value(str(loaded_volume))
#	load_.open(str(documents) +"/Pixel Zone/.data/settings_audio_music.save", File.READ)
#	var loaded_music = parse_json(load_.get_line())
#	$MusicBar.set_value(str(loaded_music))
#	load_.open(str(documents) +"/Pixel Zone/.data/settings_audio_sfxr.save", File.READ)
#	var loaded_sfx = parse_json(load_.get_line())
#	$SFXBar.set_value(str(loaded_sfx))
#func _save():
#	var save = File.new()
#	save.open(str(documents) +"/Pixel Zone/.data/settings_audio_master.save", File.WRITE)
#	save.store_line(to_json($VolumeBar.value))
#	save.open(str(documents) +"/Pixel Zone/.data/settings_audio_music.save", File.WRITE)
#	save.store_line(to_json($MusicBar.value))
#	save.open(str(documents) +"/Pixel Zone/.data/settings_audio_sfx.save", File.WRITE)
#	save.store_line(to_json($SFXBar.value))
#	save.close()
func _ready():
#	_load()
	master_bus = AudioServer.get_bus_index("Master")
	music_bus = AudioServer.get_bus_index("Music")
	sfx_bus = AudioServer.get_bus_index("SFX")
	
	set_controls_for_bus(
		master_bus, $VolumeBox/OnButton,
		$VolumeBox/OffButton, $VolumeBar
		)

	set_controls_for_bus(
		music_bus, $MusicBox/OnButton,
		$MusicBox/OffButton, $MusicBar
		)
	
	set_controls_for_bus(
		sfx_bus, $SFXBox/OnButton,
		$SFXBox/OffButton, $SFXBar
		)

	connect("visibility_changed", self, "_on_visibility_changed")

func _on_visibility_changed():
	if not visible:
		return
	
	$VolumeBar.value = get_bus_volume(master_bus)
	$MusicBar.value = get_bus_volume(music_bus)
	$SFXBar.value = get_bus_volume(sfx_bus)

func set_bus_volume(value, bus_id):
	AudioServer.set_bus_volume_db(bus_id, value)

func get_bus_volume(bus_id):
	return AudioServer.get_bus_volume_db(bus_id)

func set_controls_for_bus(bus_id, on_button, off_button, bar):
	if AudioServer.is_bus_mute(bus_id):
		off_button.pressed = true
	else:
		on_button.pressed = true
	
	on_button.connect(
		"pressed", AudioServer,
		"set_bus_mute", [bus_id, false]
	)

	off_button.connect(
		"pressed", AudioServer,
		"set_bus_mute", [bus_id, true]
	)
	
	bar.connect(
		"value_changed", self,
		"set_bus_volume", [bus_id]
	)
	

