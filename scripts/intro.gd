extends Control
# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(intro_new):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/AutoSaveNotification.tscn")
	

func _on_Skip_pressed():
	$AnimationPlayer.stop()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/AutoSaveNotification.tscn")