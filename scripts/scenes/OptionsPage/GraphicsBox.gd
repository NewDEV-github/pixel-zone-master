extends VBoxContainer
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _ready():
	$ApplyButton.connect("pressed", self, "_on_apply")
	_load()

func set_window_options(fullscreen, maximized):
	settings.window_fullscreen = fullscreen
	settings.window_maximized = maximized
func _save():
	var pixel_snap = $VBoxContainer/PixelSnapBox/CheckButton.pressed
	var VSync = $VBoxContainer/VSyncBox/CheckButton.pressed
	var FPS = $VBoxContainer/FPSBox/CheckButton.pressed
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/settings_graphics.save", File.WRITE)
	save.store_line(to_json(str(pixel_snap) + str(VSync) + str(FPS)))
	save.close()
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings_graphics.save", File.READ)
	var loaded_graphics = parse_json(load_.get_line())
	if loaded_graphics == "FalseFalseFalse":
		$VBoxContainer/PixelSnapBox/CheckButton.set_pressed(false)
		$VBoxContainer/VSyncBox/CheckButton.set_pressed(false)
		$VBoxContainer/FPSBox/CheckButton.set_pressed(false)
	if loaded_graphics == "TrueTrueTrue":
		$VBoxContainer/PixelSnapBox/CheckButton.set_pressed(true)
		$VBoxContainer/VSyncBox/CheckButton.set_pressed(true)
		$VBoxContainer/FPSBox/CheckButton.set_pressed(true)
func _process(delta):
	_save()
func _on_apply():
	match settings.temp_window_type_id:
		0: # Windowed
			set_window_options(false, false)
		1: # Fullscreen
			set_window_options(true, false)
		2: # Maximized
			set_window_options(false, true)
		
	settings.window_size = settings.temp_window_size
	
	if settings.window_size != settings.default_window_size:
		var width = settings.default_window_size.x
		settings.camera_zoom = width / settings.window_size.x * settings.default_camera_zoom

	OS.vsync_enabled = settings.temp_vsync_enabled