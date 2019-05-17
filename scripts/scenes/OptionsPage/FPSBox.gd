extends HBoxContainer
signal fps_show
signal fps_show2
signal fps_hide
signal fps_hide2
func _process(delta):
	if $CheckButton.pressed == true:
		emit_signal("fps_show")
		emit_signal("fps_show2")
	if $CheckButton.pressed == false:
		emit_signal("fps_hide")
		emit_signal("fps_hide2")