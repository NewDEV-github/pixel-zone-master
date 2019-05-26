extends Control

func _on_window_size_changeds(prev, now):
	rect_size = now
	$Viewport.size = now
func _on_AnimationPlayer_animation_finished(intro_new):
	get_tree().change_scene("res://scenes/AutoSaveNotification.tscn")
	

func _on_Skip_pressed():
	$AnimationPlayer.stop()
	get_tree().change_scene("res://scenes/AutoSaveNotification.tscn")