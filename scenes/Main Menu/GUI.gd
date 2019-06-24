extends Control
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var desktop = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
var dcim = OS.get_system_dir(OS.SYSTEM_DIR_DCIM)
var downloads = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)
var movies = OS.get_system_dir(OS.SYSTEM_DIR_MOVIES)
var music = OS.get_system_dir(OS.SYSTEM_DIR_MUSIC)

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
	$HTTPRequest.set_download_file(str(OS.get_executable_path()) + ".data/3d.pck")
	$HTTPRequest.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/v0.7.2.0.5/3d.pck")

func _on_Licenses_pressed():
	$TextureRect/LicenseSelector.popup_centered()
	
func _ready():
	$TextureRect/Label.hide()
	var dlc = File.new()
	if dlc.file_exists(str(OS.get_executable_path()) + ".data/3d.pck"):
		ProjectSettings.load_resource_pack(str(OS.get_executable_path()) + ".data/3d.pck")
		get_tree().change_scene("res://scenes/Main Menu/GUI3D.tscn")
		if FAILED:
			log_file.error()
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


func _on_Update_pressed():
	background_load.load_scene("res://scenes/Update.tscn")


func _on_VScrollBar_value_changed(value):
	$Control.set_position(Vector2(0, -(value*10)))


func _on_Timer_timeout():
	_on_Play_pressed()