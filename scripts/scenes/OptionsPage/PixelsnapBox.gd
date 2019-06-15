extends HBoxContainer

func _process(delta):
	if $CheckButton.pressed == true:
		ProjectSettings.set_setting("rendering/quality/2d/use_pixel_snap", 1)
	if $CheckButton.pressed == false:
		ProjectSettings.set_setting("rendering/quality/2d/use_pixel_snap", 0)