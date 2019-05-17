extends HBoxContainer
func _process(delta):
	if $CheckButton.pressed == true:
		ProjectSettings.set("rendering/quality/voxel_cone_tracing/high_quality", 1)
	if $CheckButton.pressed == false:
		ProjectSettings.set("rendering/quality/voxel_cone_tracing/high_quality", 0)
