extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
	$ProgressBar.set_value(0)
	$HTTPRequest.set_download_file("user://latest_version.txt")
	$HTTPRequest2.set_download_file("user://version_info.txt")
	$ProgressBar.set_value(1)
	$HTTPRequest.request("https://github.com/MasterPolska123/home/raw/master/updates_info/latest_version.txt")
	$HTTPRequest2.request("https://github.com/MasterPolska123/home/raw/master/updates_info/version_info.txt")
	$ProgressBar.set_value(50)
	initialize()
func initialize():
	$ProgressBar.set_value(75)
	var update = File.new()
	update.open("user://latest_version.txt", File.READ)
	latest_update = update.get_line()
	$ItemList.add_item(str(latest_update))
	
	
	var update_description = File.new()
	update_description.open("user://version_info.txt", File.READ)
	update_info = update_description.get_as_text()
	$RichTextLabel2.set_text(str(update_info))

func _on_Timer_timeout():
	$Panel.hide()
	$ProgressBar.hide()


func _on_ItemList_item_selected(index):
	$RichTextLabel2.show()
	version_to_download = latest_update
	print(str(version_to_download))

func _on_Button_pressed():
	$HTTPRequest2.set_download_file(str(documents) + "/Pixel Zone/.data/updates/update.pck")
	$HTTPRequest2.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/%s/update.pck" % version_to_download)
	$RichTextLabel.add_text("Downloading... version %s" % version_to_download)