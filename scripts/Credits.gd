extends TextureRect
var scene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'credits':
		scene = get_tree().change_scene("res://scenes/Main Menu/GUI.tscn")
