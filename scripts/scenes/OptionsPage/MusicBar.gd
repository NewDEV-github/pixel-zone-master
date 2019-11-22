extends HSlider
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _ready():
	_load()
func _save():
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/settings/settings_audio_usr_music.save", File.WRITE)
	save.store_line(to_json(str(value)))
	save.close()
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings/settings_audio_usr_music.save", File.READ)
	var loaded_settings = str(parse_json(load_.get_line()))
	AudioServer.set_bus_volume_db(1, float(str(loaded_settings)))
func _on_MusicBar_value_changed(value):
	_save()
	value = value
