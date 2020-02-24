extends Control
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _on_select_pressed():
	var file = File.new()
	file.open('user://cut.dat', File.READ)
	var line = str(file.get_line())
	if bool(line) == true:
		background_load.load_scene("res://scenes/stages/pixel_adventure/stage.tscn")
	if not bool(line) == true:
		background_load.load_scene('res://animations/cutscenes/cutscene1.tscn')
func _on_select2_pressed():
	background_load.load_scene("res://scenes/stages/pixel_adventure/stage2.tscn")
func _on_select3_pressed():#
	var file = File.new()
	file.open('user://cut.dat', File.READ)
	var line = str(file.get_line())
	if bool(line) == true:
		background_load.load_scene("res://scenes/stages/ice_cap_adventure/ice_02.tscn")
	if not bool(line) == true:
		background_load.load_scene('res://animations/cutscenes/cutscene2.tscn')
func _on_select4_pressed():
	background_load.load_scene("res://scenes/stages/ice_cap_adventure/ice_02.tscn")
func _on_select5_pressed():
	background_load.load_scene("res://scenes/stages/ice_cap_adventure/ice_03.tscn")
func _on_select6_pressed():#
	var file = File.new()
	file.open('user://cut.dat', File.READ)
	var line = str(file.get_line())
	if bool(line) == true:
		background_load.load_scene("res://scenes/stages/jungle_ruins/jungle_ruins01.tscn")
	if not bool(line) == true:
		background_load.load_scene('res://animations/cutscenes/cutscene3.tscn')
func _on_select7_pressed():
	background_load.load_scene("res://scenes/stages/jungle_ruins/jungle_ruins02.tscn")
func _on_select8_pressed():
	background_load.load_scene("res://scenes/stages/jungle_ruins/jungle_ruins03.tscn")
func _on_select9_pressed():
	background_load.load_scene("res://scenes/stages/hill/hill_2.tscn")
func _ready():
	var file = File.new()
	print(str(!file.file_exists('user://sav.s3')))
	$control/PixelZone02/select2.set_disabled(!file.file_exists('user://sav.s2'))
	$control/IceCap01/select3.set_disabled(!file.file_exists('user://sav.s3'))
	$control/IceCap02/select4.set_disabled(!file.file_exists('user://sav.s4'))
	$control/IceCap03/select5.set_disabled(!file.file_exists('user://sav.s5'))
	$control/JungleRuins01/select6.set_disabled(!file.file_exists('user://sav.s6'))
	$control/JungleRuins02/select7.set_disabled(!file.file_exists('user://sav.s7'))
	$control/JungleRuins03/select8.set_disabled(!file.file_exists('user://sav.s8'))
	$control/Hill01/select10.set_disabled(!file.file_exists('user://sav.s9'))
	$control/Hill02/select9.set_disabled(!file.file_exists('user://sav.s10'))
	$control/Hill03/select11.set_disabled(!file.file_exists('user://sav.s11'))
	$control/SciFi01/select12.set_disabled(!file.file_exists('user://sav.s12'))
	$control/SciFi02/select13.set_disabled(!file.file_exists('user://sav.s13'))
	$control/SciFi03/select14.set_disabled(!file.file_exists('user://sav.s14'))
	$control/CastleMania01/select15a.set_disabled(!file.file_exists('user://sav.s15'))
	$control/CastleMania02/select15b.set_disabled(!file.file_exists('user://sav.s16'))
	$control/CastleMania03/select15c.set_disabled(!file.file_exists('user://sav.s17'))
########if game was passed
#		if str(loaded_config) == 'true':
#			$control/PixelZone02/select2.set_disabled(false)
#			$control/IceCap01/select3.set_disabled(false)
#			$control/IceCap02/select4.set_disabled(false)
#			$control/IceCap03/select5.set_disabled(false)
#			$control/JungleRuins01/select6.set_disabled(false)
#			$control/JungleRuins02/select7.set_disabled(false)
#			$control/JungleRuins03/select8.set_disabled(false)
#			$control/Hill01/select10.set_disabled(false)
#			$control/Hill02/select9.set_disabled(false)
#			$control/Hill03/select11.set_disabled(false)
#			$control/SciFi01/select12.set_disabled(false)
#			$control/SciFi02/select13.set_disabled(false)
#			$control/SciFi03/select14.set_disabled(false)
#			$control/CastleMania01/select15a.set_disabled(false)
#			$control/CastleMania02/select15b.set_disabled(false)
#			$control/CastleMania03/select15c.set_disabled(false)
func _on_VScrollBar_value_changed(value):
	$control.set_position(Vector2(0, -(value*10)))

func _on_select10_pressed():
	var file = File.new()
	file.open('user://cut.dat', File.READ)
	var line = str(file.get_line())
	if bool(line) == true:
		background_load.load_scene("res://scenes/stages/hill/hill_1.tscn")
	if not bool(line) == true:
		background_load.load_scene('res://animations/cutscenes/cutscene4.tscn')


func _on_select15_pressed():
	background_load.load_scene("res://scenes/stages/hill/hill_3.tscn")


func _on_select16_pressed():
	var file = File.new()
	file.open('user://cut.dat', File.READ)
	var line = str(file.get_line())
	if bool(line) == true:
		background_load.load_scene("res://scenes/stages/scifi/sci_fi_1.tscn")
	if not bool(line) == true:
		background_load.load_scene('res://animations/cutscenes/cutscene5.tscn')


func _on_select17_pressed():
	background_load.load_scene("res://scenes/stages/scifi/sci_fi_2.tscn")


func _on_select14_pressed():
	background_load.load_scene("res://scenes/stages/scifi/sci_fi_3.tscn")


func _on_select15a_pressed():
	var file = File.new()
	file.open('user://cut.dat', File.READ)
	var line = str(file.get_line())
	if bool(line) == true:
		background_load.load_scene("res://scenes/stages/castle_mania/castle_mania01.tscn")
	if not bool(line) == true:
		background_load.load_scene('res://animations/cutscenes/cutscene6.tscn')


func _on_select15b_pressed():
	background_load.load_scene("res://scenes/stages/castle_mania/castle_mania02.tscn")

func _on_select15c_pressed():
	background_load.load_scene("res://scenes/stages/castle_mania/castle_mania03.tscn")
