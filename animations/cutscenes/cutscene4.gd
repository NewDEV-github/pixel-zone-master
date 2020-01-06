extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	if globals.play_cutscenes == false:
		get_tree().change_scene('res://scenes/stages/hill/hill_1.tscn')
	else:
		AdvancedBackgroundLoader.preload_scene('res://scenes/stages/hill/hill_1.tscn')
func _process(delta):
	$Button.visible = AdvancedBackgroundLoader.can_change
func _on_Button_pressed():
	AdvancedBackgroundLoader.change_scene_to_preloaded()
func _on_AnimationPlayer_animation_finished(anim_name):
	AdvancedBackgroundLoader.change_scene_to_preloaded()
