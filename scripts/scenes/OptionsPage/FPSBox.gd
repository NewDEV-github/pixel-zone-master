extends HBoxContainer
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
signal fps_show
signal fps_show2
signal fps_hide
signal fps_hide2
func _process(delta):
	_save()
	if $CheckButton.pressed == true:
		emit_signal("fps_show")
		emit_signal("fps_show2")
	if $CheckButton.pressed == false:
		emit_signal("fps_hide")
		emit_signal("fps_hide2")
func _ready():
	_load()
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings_fps.save", File.READ)
	var loaded_settings = parse_json(load_.get_line())
	if loaded_settings == "True":
		$CheckButton.set_pressed(true)
func _save():
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/settings_fps.save", File.WRITE)
	save.store_line(to_json(str($CheckButton.pressed)))
	save.close()