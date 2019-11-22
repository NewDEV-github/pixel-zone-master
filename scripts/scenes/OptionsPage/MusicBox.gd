extends VBoxContainer
var master_bus
var music_bus
var sfx_bus
var custom
var visibility_connect
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
	music_bus = AudioServer.get_bus_index("Music") #and AudioServer.get_bus_index("Custom")
	sfx_bus = AudioServer.get_bus_index("SFX")
	custom = AudioServer.get_bus_index("Custom Music")
	
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
	set_controls_for_bus(
		custom, $MusicBox2/OnButton,
		$MusicBox2/OffButton, $MusicBar2
		)

	visibility_connect = connect("visibility_changed", self, "_on_visibility_changed")

func _on_visibility_changed():
	if not visible:
		return
	
	$VolumeBar.value = get_bus_volume(master_bus)
	$MusicBar.value = get_bus_volume(music_bus)
	$SFXBar.value = get_bus_volume(sfx_bus)
	$MusicBar2.value = get_bus_volume(custom)

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
	

