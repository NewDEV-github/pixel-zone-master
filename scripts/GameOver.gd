extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _game_over():
	show()
	$AnimationPlayer.play("game_over")


func _on_Button2_pressed():
	background_load.load_scene("scenes/Main Menu/GUI.tscn")
func _on_Button_pressed():
	get_tree().quit()