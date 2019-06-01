extends Control


func _on_Play_pressed():
	var exists = File.new()
	if not exists.file_exists(str(OS.get_executable_path()) + ".tut.data0"):
		background_load.load_scene("res://scenes/stages/tutorial.tscn")
	if exists.file_exists(str(OS.get_executable_path()) + ".tut.data0"):
		background_load.load_scene("res://scenes/LevelSelect.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _process(delta):
	$TextureRect/Label.set_text("Downloaded " + str($HTTPRequest.get_downloaded_bytes()) + " bytes of " + str($HTTPRequest.get_body_size()) + " bytes (" + (str($HTTPRequest.get_downloaded_bytes()/($HTTPRequest.get_body_size()*(0.01)))) +" %)")
	var b = File.new()
	if b.file_exists("user://1.save"):
		$TextureRect/VBoxContainer/Continue.disabled = false
	if not b.file_exists("user://1.save"):
		$TextureRect/VBoxContainer/Continue.disabled = true
	
func _on_Play7_pressed():
	OS.shell_open("mailto:karoltomaszewskimusic@gmail.com;olo2tom@o2.pl;?subject=I Found a Bug in Pixel Zone")

func _on_Play6_pressed():
	$TextureRect/WindowDialog.popup_centered()

func _on_PP_pressed():
	$TextureRect/DownloadNot.popup_centered()
	$TextureRect/Label.show()
	globals.dlc_name == "3D DLC"
	$HTTPRequest.set_download_file("user://3d.pck")
	$HTTPRequest.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/v0.7.2.0.5/3d.pck")

func _on_Licenses_pressed():
	$TextureRect/LicenseSelector.popup_centered()
	
func _ready():
	$TextureRect/Label.hide()
	var dlc = File.new()
	if dlc.file_exists("user://3d.pck"):
		ProjectSettings.load_resource_pack("user://3d.pck")
		get_tree().change_scene("res://scenes/Main Menu/GUI3D.tscn")
		if FAILED:
			log_file.error()
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
	get_tree().change_scene("res://dlcs/multi/lobby.tscn")



func _on_WindowDialog3_popup_hide():
	$TextureRect/WindowDialog2.hide()

func _on_close_pressed():
	$TextureRect/WindowDialog2.hide()


func _on_ImportMod_pressed():
	$ModSelector.popup_centered()


func _on_ModeSelect_file_selected(path):
	ProjectSettings.load_resource_pack(path)
	get_tree().change_scene("res://mod.tscn")
	if FAILED:
		log_file.error()


func _on_WindowDialog3_about_to_show():
	$TextureRect/WindowDialog2.hide()
