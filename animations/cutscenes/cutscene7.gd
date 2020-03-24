extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = preload("res://bin/player.gdns").new()
# Called when the node enters the scene tree for the first time.
func _ready():
	if str(OS.get_name()) == 'OSX' or str(OS.get_name()) == 'X11':
		player = preload("res://bin/osx/libplayer.gd").new()
	if globals.scene_path == str(player.get_data()):
		$robot_demo_2.set_texture(load("res://textures/robot_demo.png"))
	if globals.play_cutscenes == false:
		get_tree().change_scene('res://scenes/Credits.tscn')
	else:
		AdvancedBackgroundLoader.preload_scene('res://scenes/Credits.tscn')
func _process(delta):
	$Button.visible = AdvancedBackgroundLoader.can_change
func _on_Button_pressed():
	AdvancedBackgroundLoader.change_scene_to_preloaded()
func _on_AnimationPlayer_animation_finished(anim_name):
	AdvancedBackgroundLoader.change_scene_to_preloaded()
