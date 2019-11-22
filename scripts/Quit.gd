extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scene
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Play_pressed():
		scene = get_tree().change_scene("MainMenu.tscn")


func _on_Quit_pressed():
		get_tree().quit()
