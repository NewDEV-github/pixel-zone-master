extends Control

# Declare member variables here. Examples:
# var a = 2

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.




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
func _on_3D_pressed():
	$WindowDialog3.popup_centered()


func _on_VScrollBar_value_changed(value):
	$control.set_position(Vector2(0, -(value*10)))