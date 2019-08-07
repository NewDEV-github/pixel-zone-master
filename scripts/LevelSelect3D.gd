extends Control


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
	unlock.open_encrypted_with_pass("user://save_data.1", File.READ, str(34567865))
	var decrypted_sav_1 = unlock.get_line()
	unlock.close()
	unlock.open_encrypted_with_pass("user://save_data.2", File.READ, str(34567865))
	var decrypted_sav_2 = unlock.get_line()
	unlock.close()
	if decrypted_sav_1 == decrypted_sav_2:
		if decrypted_sav_1 >= "2":
			$control/PixelZone02/select2.set_disabled(false)
		if decrypted_sav_1 >= "3":
			$control/IceCap01/select3.set_disabled(false)
		if decrypted_sav_1 >= "4":
			$control/IceCap02/select4.set_disabled(false)
		if decrypted_sav_1 >= "5":
			$control/IceCap03/select5.set_disabled(false)
		if decrypted_sav_1 >= "6":
			$control/JungleRuins01/select6.set_disabled(false)
		if decrypted_sav_1 >= "7":
			$control/JungleRuins02/select7.set_disabled(false)
		if decrypted_sav_1 >= "8":
			$control/JungleRuins03/select8.set_disabled(false)
		if decrypted_sav_1 >= "9":
			$control/Hill01/select10.set_disabled(false)
		if decrypted_sav_1 >= "10":
			$control/Hill02/select9.set_disabled(false)
		if decrypted_sav_1 >= "11":
			$control/Hill03/select11.set_disabled(false)
		if decrypted_sav_1 >= "12":
			$control/SciFi01/select12.set_disabled(false)
		if decrypted_sav_1 >= "13":
			$control/SciFi02/select13.set_disabled(false)
		if decrypted_sav_1 >= "14":
			$control/SciFi03/select14.set_disabled(false)
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


func _on_select14_pressed():
	background_load.load_scene("res://scenes/stages/scifi/sci_fi_3.tscn")
