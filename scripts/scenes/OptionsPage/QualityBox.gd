extends HBoxContainer
func _process(delta):
	if $CheckButton.pressed == true:
		ProjectSettings.set_setting("rendering/quality/voxel_cone_tracing/high_quality", true)
	if $CheckButton.pressed == false:
		ProjectSettings.set_setting("rendering/quality/voxel_cone_tracing/high_quality", false)
