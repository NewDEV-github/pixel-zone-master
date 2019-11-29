extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open('user://cut.dat', File.WRITE)
	file.store_line(str(true))
func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene('res://scenes/stages/pixel_adventure/stage.tscn')
