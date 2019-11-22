extends HSlider
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _ready():
	_load()
func _save():
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/settings/settings_audio_sfx.save", File.WRITE)
	save.store_line(to_json(str(value)))
	save.close()
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings/settings_audio_sfx.save", File.READ)
	var loaded_settings = str(parse_json(load_.get_line()))
	AudioServer.set_bus_volume_db(2, float(str(loaded_settings)))


func _on_SFXBar_value_changed(value):
	_save()
	value = value
