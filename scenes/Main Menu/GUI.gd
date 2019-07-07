extends Control
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var desktop = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
var dcim = OS.get_system_dir(OS.SYSTEM_DIR_DCIM)
var downloads = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)
var movies = OS.get_system_dir(OS.SYSTEM_DIR_MOVIES)
var music = OS.get_system_dir(OS.SYSTEM_DIR_MUSIC)
var mod_path = ""
var load_mod = "false"
func _on_Play_pressed():
	$AnimationPlayer.play("new")

func _on_Quit_pressed():
	get_tree().quit()

func _process(delta):
	$TextureRect/Label.set_text("Downloaded " + str($HTTPRequest.get_downloaded_bytes()) + " bytes of " + str($HTTPRequest.get_body_size()) + " bytes (" + (str($HTTPRequest.get_downloaded_bytes()/($HTTPRequest.get_body_size()*(0.01)))) +" %)")
	
func _on_Play7_pressed():
	OS.shell_open("mailto:karoltomaszewskimusic@gmail.com;olo2tom@o2.pl;?subject=I Found a Bug in Pixel Zone")

func _on_Play6_pressed():
	$TextureRect/WindowDialog.popup_centered()

func _on_PP_pressed():
	$TextureRect/DownloadNot.popup_centered()
	$TextureRect/Label.show()
	globals.dlc_name == "3D DLC"
	$HTTPRequest.set_download_file("user://dlc_loops.pck")
	$HTTPRequest.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/v0.7.2.1.0/dlc_loops.pck")

func _on_Licenses_pressed():
	$TextureRect/LicenseSelector.popup_centered()
	
func _ready():
	var mod = File.new()
	var mod_path = File.new()
	mod_path.open(str(documents) + "/Pixel Zone/.data/mod_path.save", File.READ)
	var load_mod_path = mod_path.get_line()
	ProjectSettings.load_resource_pack(load_mod_path)
	get_tree().change_scene("res://mod.tscn")
	$TextureRect/Label.hide()
	var dlc = File.new()
	if dlc.file_exists("user://dlc_loops.pck"):
		ProjectSettings.load_resource_pack("user://dlc_loops.pck")
		get_tree().change_scene("res://scenes/Main Menu/GUI_loops.tscn")
func _on_Play8_pressed():
	get_tree().change_scene("res://dlcs/multi/lobby.tscn")



func _on_WindowDialog3_popup_hide():
	$TextureRect/WindowDialog2.hide()

func _on_close_pressed():
	$TextureRect/WindowDialog2.hide()


func _on_ImportMod_pressed():
	$ModSelector.popup()
	$CheckBox.show()



func _on_WindowDialog3_about_to_show():
	$TextureRect/WindowDialog2.hide()


func _on_Update_pressed():
	background_load.load_scene("res://scenes/Update.tscn")


func _on_VScrollBar_value_changed(value):
	$Control.set_position(Vector2(0, -(value*10)))


func _on_Timer_timeout():
	_on_Play_pressed()

func _on_ModSelector_file_selected(path):
	var mod = File.new()
	var mod_path = File.new()
	if $CheckBox.pressed == true:
		mod_path.open(str(documents) + "/Pixel Zone/.data/mod_path.save", File.WRITE)
		mod_path.store_line(path)
	ProjectSettings.load_resource_pack(path)
	get_tree().change_scene("res://mod.tscn")

func _on_ModSelector_popup_hide():
	$CheckBox.hide()


func _on_ModSelector_about_to_show():
	$Timer.stop()
