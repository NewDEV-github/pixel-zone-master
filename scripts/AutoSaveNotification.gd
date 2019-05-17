extends Control


# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_on_Button_pressed()
	if Input.is_action_just_pressed("ui_select"):
		_on_Button_pressed()
func _on_Button_pressed():
	background_load.load_scene("res://scenes/Main Menu/GUI.tscn")