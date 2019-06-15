extends HBoxContainer

func _process(delta):
	if $CheckButton.pressed == true:
		ProjectSettings.set_setting("display/window/vsync/use_vsync", 1)
	if $CheckButton.pressed == false:
		ProjectSettings.set_setting("display/window/vsync/use_vsync", 0)