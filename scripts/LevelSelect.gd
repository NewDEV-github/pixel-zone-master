extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $PixelZone01/select.focus_mode:
		$AnimationPlayer.play("PA_01")
	if $PixelZone02/select2.focus_mode:
		$AnimationPlayer.play("PA_02")
	if $IceCap01/select3.focus_mode:
		$AnimationPlayer.play("IC_01")



func _on_select_pressed():
	background_load.load_scene("res://scenes/stages/pixel_adventure/stage.tscn")
func _on_select2_pressed():
	background_load.load_scene("res://scenes/stages/pixel_adventure/stage2.tscn")
func _on_select3_pressed():
	background_load.load_scene("res://scenes/stages/ice_cap_adventure/ice_01.tscn")
func _on_select4_pressed():
	background_load.load_scene("res://scenes/stages/ice_cap_adventure/ice_02.tscn")
func _on_select5_pressed():
	background_load.load_scene("res://scenes/stages/ice_cap_adventure/ice_03.tscn")
func _on_select6_pressed():
	background_load.load_scene("res://scenes/stages/jungle_ruins/jungle_ruins01.tscn")
func _on_select7_pressed():
	background_load.load_scene("res://scenes/stages/jungle_ruins/jungle_ruins02.tscn")
func _on_select8_pressed():
	background_load.load_scene("res://scenes/stages/jungle_ruins/jungle_ruins03.tscn")
func _on_select9_pressed():
	background_load.load_scene("res://scenes/stages/tutorial.tscn")

