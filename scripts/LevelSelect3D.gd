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
	background_load.load_scene("res://scenes/stages/hill/hill_2.tscn")
func _process(delta):
	var unlock = File.new()
	if unlock.file_exists("user://2.save"):
		$control/PixelZone02/select2.set_disabled(false)
	if not unlock.file_exists("user://2.save"):
		$control/PixelZone02/select2.set_disabled(true)
	if unlock.file_exists("user://3.save"):
		$control/IceCap01/select3.set_disabled(false)
	if not unlock.file_exists("user://3.save"):
		$control/IceCap01/select3.set_disabled(true)
	if unlock.file_exists("user://4.save"):
		$control/IceCap02/select4.set_disabled(false)
	if not unlock.file_exists("user://4.save"):
		$control/IceCap02/select4.set_disabled(true)
	if unlock.file_exists("user://5.save"):
		$control/IceCap03/select5.set_disabled(false)
	if not unlock.file_exists("user://5.save"):
		$control/IceCap03/select5.set_disabled(true)
	if unlock.file_exists("user://6.save"):
		$control/JungleRuins01/select6.set_disabled(false)
	if not unlock.file_exists("user://6.save"):
		$control/JungleRuins01/select6.set_disabled(true)
	if unlock.file_exists("user://7.save"):
		$control/JungleRuins02/select7.set_disabled(false)
	if not unlock.file_exists("user://7.save"):
		$control/JungleRuins02/select7.set_disabled(true)
	if unlock.file_exists("user://8.save") :
		$control/JungleRuins03/select8.set_disabled(false)
	if not unlock.file_exists("user://8.save") :
		$control/JungleRuins03/select8.set_disabled(true)
	if unlock.file_exists("user://9.save") :
		$control/Hill01/select10.set_disabled(false)
	if not unlock.file_exists("user://9.save") :
		$control/Hill01/select10.set_disabled(true)
	if unlock.file_exists("user://10.save"):
		$control/Hill02/select9.set_disabled(false)
	if not unlock.file_exists("user://10.save") :
		$control/Hill02/select9.set_disabled(true)
	if unlock.file_exists("user://11.save") :
		$control/Hill03/select15.set_disabled(false)
	if not unlock.file_exists("user://11.save"): 
		$control/Hill03/select15.set_disabled(true)
	if unlock.file_exists("user://12.save"):
		$control/SciFi01/select16.set_disabled(false)
	if not unlock.file_exists("user://12.save"):
		$control/SciFi01/select16.set_disabled(true)
	if unlock.file_exists("user://13.save"):
		$control/SciFi02/select17.set_disabled(false)
	if not unlock.file_exists("user://13.save") :
		$control/SciFi02/select17.set_disabled(true)
	
func _on_VScrollBar_value_changed(value):
	$control.set_position(Vector2(0, -(value*10)))

func _on_select10_pressed():
	background_load.load_scene("res://scenes/stages/hill/hill_1.tscn")


func _on_select15_pressed():
	background_load.load_scene("res://scenes/stages/hill/hill_3.tscn")


func _on_select16_pressed():
	background_load.load_scene("res://scenes/stages/scifi/sci_fi_1.tscn")


func _on_select17_pressed():
	background_load.load_scene("res://scenes/stages/scifi/sci_fi_2.tscn")
