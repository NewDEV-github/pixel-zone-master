extends CheckButton
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _ready():
	_load()
func _save():
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/settings/settings_advanced.save", File.WRITE)
	save.store_line(to_json(str(pressed)))
	save.close()
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings/settings_advanced.save", File.READ)
	var loaded_settings = parse_json(load_.get_line())
	if loaded_settings == "True":
		set_pressed(true)
	if loaded_settings == "False":
		set_pressed(false)



func _on_Advanced_pressed():
#	_save()
	$Window
