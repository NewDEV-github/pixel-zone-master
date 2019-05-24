extends Control
func _on_Play_pressed():
	if $TextureRect/VBoxContainer/CheckBox.pressed == true:
		$TextureRect/WindowDialog2.hide()
		$TextureRect/WindowDialog3.popup_centered()
	if $TextureRect/VBoxContainer/CheckBox.pressed == false:
		background_load.load_scene("res://scenes/stages/pixel_adventure/stage.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _process(delta):
	var b = File.new()
	if b.file_exists("user://report_bug/BugReporter.tscn"):
		$TextureRect/VBoxContainer/Play7.disabled = false
	if not b.file_exists("user://report_bug/BugReporter.tscn"):
		$TextureRect/VBoxContainer/Play7.disabled = true
	if b.file_exists("user://multi/lobby.tscn"):
		$TextureRect/VBoxContainer/Play8.disabled = false
	if not b.file_exists("user://multi/lobby.tscn"):
		$TextureRect/VBoxContainer/Play8.disabled = true
	if b.file_exists("user://1.save"):
		$TextureRect/VBoxContainer/Continue.disabled = false
	if not b.file_exists("user://1.save"):
		$TextureRect/VBoxContainer/Continue.disabled = true
	
	settings.connect("window_size_changed", self, "_on_window_size_changeds")
	var c = File.new()
	if c.file_exists("user://multi/lobby.tscn"):
		$TextureRect/WindowDialog/ItemList.add_item("MultiPlayer Mode")
	if c.file_exists("user://dlc_2/Drum & Bass.ogg"):
		$TextureRect/WindowDialog/ItemList.add_item("Custom Music")
	if c.file_exists("user://dlc_1/stage_dlc1.tscn"):
		$TextureRect/WindowDialog/ItemList.add_item("Power Up!")
	if c.file_exists("user://report_bug/BugReporter.tscn"):
		$TextureRect/WindowDialog/ItemList.add_item("Report a Bug")
	if c.file_exists("user://dlc_3/stage.tscn"):
		$TextureRect/WindowDialog/ItemList.add_item("Character Selection")


func _on_Play7_pressed():
	OS.shell_open("mailto:karoltomaszewskimusic@gmail.com;olo2tom@o2.pl;?subject=I Found a Bug in Pixel Zone")

func _on_Play6_pressed():
	$TextureRect/WindowDialog.popup_centered()

func _on_PP_pressed():
	OS.shell_open("https://masterpolska.pl.tl/Polityka--Prywatno%26%23347%3Bci.htm")

func _on_License_pressed():
	$TextureRect/WindowDialog.hide()
	$TextureRect/PixelZoneLicense.popup_centered()
	$TextureRect/MITLicense.hide()
	$TextureRect/GodotEngineLicense.hide()


func _on_GELicense_pressed():
	$TextureRect/WindowDialog.hide()
	$TextureRect/PixelZoneLicense.hide()
	$TextureRect/MITLicense.hide()
	$TextureRect/GodotEngineLicense.popup_centered()


func _on_MITLicense_pressed():
	$TextureRect/WindowDialog.hide()
	$TextureRect/PixelZoneLicense.hide()
	$TextureRect/MITLicense.popup_centered()
	$TextureRect/GodotEngineLicense.hide()


func _on_Licenses_pressed():
	$TextureRect/LicenseSelector.popup_centered()


func _on_Continue_pressed():
	var con = File.new()
	if not con.file_exists("user://1.save") and not con.file_exists("user://2.save") and not con.file_exists("user://3.save") and not con.file_exists("user://4.save") and not con.file_exists("user://5.save") and not con.file_exists("user://6.save") and not con.file_exists("user://7.save") and not con.file_exists("user://8.save"):
		return
	if con.file_exists("user://1.save") and not con.file_exists("user://2.save") and not con.file_exists("user://3.save") and not con.file_exists("user://4.save") and not con.file_exists("user://5.save") and not con.file_exists("user://6.save") and not con.file_exists("user://7.save") and not con.file_exists("user://8.save"):
		background_load.load_scene("scenes/stages/pixel_adventure/stage.tscn")
	if con.file_exists("user://1.save") and con.file_exists("user://2.save") and not con.file_exists("user://3.save") and not con.file_exists("user://4.save") and not con.file_exists("user://5.save") and not con.file_exists("user://6.save") and not con.file_exists("user://7.save") and not con.file_exists("user://8.save"):
		background_load.load_scene("scenes/stages/pixel_adventure/stage2.tscn")
	if con.file_exists("user://1.save") and con.file_exists("user://2.save") and con.file_exists("user://3.save") and not con.file_exists("user://4.save") and not con.file_exists("user://5.save") and not con.file_exists("user://6.save") and not con.file_exists("user://7.save") and not con.file_exists("user://8.save"):
		background_load.load_scene("scenes/stages/ice_cap_adventure/ice_01.tscn")
	if con.file_exists("user://1.save") and con.file_exists("user://2.save") and con.file_exists("user://3.save") and con.file_exists("user://4.save") and not con.file_exists("user://5.save") and not con.file_exists("user://6.save") and not con.file_exists("user://7.save") and not con.file_exists("user://8.save"):
		background_load.load_scene("scenes/stages/ice_cap_adventure/ice_02.tscn")
	if con.file_exists("user://1.save") and con.file_exists("user://2.save") and con.file_exists("user://3.save") and con.file_exists("user://4.save") and con.file_exists("user://5.save") and not con.file_exists("user://6.save") and not con.file_exists("user://7.save") and not con.file_exists("user://8.save"):
		background_load.load_scene("scenes/stages/ice_cap_adventure/ice_03.tscn")
	if con.file_exists("user://1.save") and con.file_exists("user://2.save") and con.file_exists("user://3.save") and con.file_exists("user://4.save") and con.file_exists("user://5.save") and con.file_exists("user://6.save") and not con.file_exists("user://7.save") and not con.file_exists("user://8.save"):
		background_load.load_scene("scenes/stages/jungle_ruins/jungle_ruins01.tscn")
	if con.file_exists("user://1.save") and con.file_exists("user://2.save") and con.file_exists("user://3.save") and con.file_exists("user://4.save") and con.file_exists("user://5.save") and con.file_exists("user://6.save") and con.file_exists("user://7.save") and not con.file_exists("user://8.save"):
		background_load.load_scene("scenes/stages/jungle_ruins/jungle_ruins02.tscn")
	if con.file_exists("user://1.save") and con.file_exists("user://2.save") and con.file_exists("user://3.save") and con.file_exists("user://4.save") and con.file_exists("user://5.save") and con.file_exists("user://6.save") and con.file_exists("user://7.save") and con.file_exists("user://8.save"):
		background_load.load_scene("scenes/stages/jungle_ruins/jungle_ruins03.tscn")

func _on_Play8_pressed():
	get_tree().change_scene("user://multi/lobby.tscn")



func _on_WindowDialog3_popup_hide():
	$TextureRect/WindowDialog2.hide()

func _on_close_pressed():
	$TextureRect/WindowDialog2.hide()


func _on_ImportMod_pressed():
	$ModeSelect.popup_centered()


func _on_ModeSelect_file_selected(path):
	ProjectSettings.load_resource_pack(path)
	get_tree().change_scene("res://mod.tscn")


func _on_WindowDialog3_about_to_show():
	$TextureRect/WindowDialog2.hide()

