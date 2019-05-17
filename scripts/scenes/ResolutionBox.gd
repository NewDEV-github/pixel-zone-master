extends "OptionsPage/CollapsedList.gd"

func _ready():
	connect("visibility_changed", self, "_on_visibility_changed")
	## taken from https://freegamedev.net/wiki/Screen_Resolutions
	options_list = [
		Vector2(640, 480),
		Vector2(800, 480),
		Vector2(1024, 600),
		Vector2(1024, 768),
		Vector2(1200, 900),
		Vector2(1280, 720),
		Vector2(1280, 1024),
	]

func _on_visibility_changed():
	update_label(OS.window_size)

func update_label(size = options_list[current_choice_id]):
	$HBox/Label.text = str(size.x) + "x" + str(size.y)
	if not (size in options_list):
		options_list.append(size)

	settings.temp_window_size = size