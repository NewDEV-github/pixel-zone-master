extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	AdvancedBackgroundLoader.preload_scene('res://scenes/stages/pixel_adventure/stage.tscn')
	var file = File.new()
	file.open('user://cut.dat', File.WRITE)
	file.store_line(str(true))
func _process(delta):
	$Button.visible = AdvancedBackgroundLoader.can_change
func _on_Button_pressed():
	AdvancedBackgroundLoader.change_scene_to_preloaded()
func _on_AnimationPlayer_animation_finished(anim_name):
	AdvancedBackgroundLoader.change_scene_to_preloaded()
