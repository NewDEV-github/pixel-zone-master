extends HBoxContainer
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _ready():
	_load()
func _save():
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/settings_hq.save", File.WRITE)
	save.store_line(to_json(str($CheckButton.pressed)))
	save.close()
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings_hq.save", File.READ)
	var loaded_settings = parse_json(load_.get_line())
	if loaded_settings == "True":
		$CheckButton.set_pressed(true)
	if loaded_settings == "False":
		$CheckButton.set_pressed(false)
func _process(delta):
	_save()
	if $CheckButton.pressed == true:
		var aa = Image.new()
		aa.set('Filter', true)
		ProjectSettings.set_setting("application/run/low_processor_mode", true)
	if $CheckButton.pressed == false:
		ProjectSettings.set_setting("application/run/low_processor_mode", false)
		var aa = Image.new()
		aa.set('Filter', false)

