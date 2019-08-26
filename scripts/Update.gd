extends Control

export (String) var Update_server = "masterpolska123.github.io/home/updates/"
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var desktop = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
var dcim = OS.get_system_dir(OS.SYSTEM_DIR_DCIM)
var downloads = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)
var movies = OS.get_system_dir(OS.SYSTEM_DIR_MOVIES)
var music = OS.get_system_dir(OS.SYSTEM_DIR_MUSIC)
var version_to_download
var latest_update
var update_info
func _ready():
	$Panel.show()
	$ProgressBar.show()
	$ProgressBar.set_value(0)
	$HTTPRequest.set_download_file("user://latest_version.txt")
	$HTTPRequest2.set_download_file("user://version_info.txt")
	$ProgressBar.set_value(20)
	$HTTPRequest.request("masterpolska123.github.io/home/updates_info/latest_version.txt")
	$ProgressBar.set_value(45)
	$HTTPRequest2.request("masterpolska123.github.io/home/updates_info/version_info.txt")
	$ProgressBar.set_value(50)
func _on_Button_pressed():
	$HTTPRequest2.set_download_file(str(documents) + "/Pixel Zone/.data/updates/update.pck")
	$HTTPRequest2.request(str(Update_server) + "update.pck")
	$RichTextLabel2.add_text("\n\nDebug Output:\npgrading game.")
