extends Control

func _on_Play_pressed():
	return get_tree().change_scene("res://Levels/Desert.tscn");

func _on_Exit_pressed():
	return get_tree().quit();