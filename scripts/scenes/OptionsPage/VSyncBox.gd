extends HBoxContainer

func _process(delta):
	if $CheckButton.pressed == true:
		ProjectSettings.set("display/window/vsync/use_vsync", 1)
	if $CheckButton.pressed == false:
		ProjectSettings.set("display/window/vsync/use_vsync", 0)