extends HBoxContainer

func _process(delta):
	if $CheckButton.pressed == true:
		ProjectSettings.set("rendering/quality/2d/use_pixel_snap", 1)
	if $CheckButton.pressed == false:
		ProjectSettings.set("rendering/quality/2d/use_pixel_snap", 0)