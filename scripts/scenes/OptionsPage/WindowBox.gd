extends "CollapsedList.gd"

func _ready():
	options_list = [
		"KEY_WINDOWED",
		"KEY_FULLSCREEN",
		"KEY_MAXIMIZED"
	]

	connect("visibility_changed", self, "_on_visibility_changed")

func _on_visibility_changed():
	if not visible:
		return
		
	if OS.window_fullscreen:
		current_choice_id = 1
	elif OS.window_maximized:
		current_choice_id = 2
	else:
		current_choice_id = 0
	
	update_label()

func update_label(choice = options_list[current_choice_id]):
	.update_label(choice)
	settings.temp_window_type_id = current_choice_id
