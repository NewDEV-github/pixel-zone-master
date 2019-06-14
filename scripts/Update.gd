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
func _ready():
	$ItemList.add_item("v0.7.2.0.8 - Current version")
	var config_updates = File.new()
	if config_updates.file_exists(str(documents) + "/Pixel Zone/.data/updates/config/config.ini"):
		$HTTPRequest5.set_download_file(str(documents) + "/Pixel Zone/.data/updates/version4.html")
		$HTTPRequest5.request("https://github.com/MasterPolska123/pixel-zone-master/releases/tag/v0.7.2.0.9")
func _initialize():
	var exists = File.new()
#	if exists.file_exists(str(documents) + "/Pixel Zone/.data/updates/version.html"):
#		$ItemList.add_item("v0.7.2.0.5")
#		$RichTextLabel.add_text("Detected version v0.7.2.0.5 to download")
#	if exists.file_exists(str(documents) + "/Pixel Zone/.data/updates/version2.html"):
#		$ItemList.add_item("v0.7.2.0.6")
#		$RichTextLabel.add_text("\nDetected version v0.7.2.0.6 to download")
#	if exists.file_exists(str(documents) + "/Pixel Zone/.data/updates/version3.html"):
#		$ItemList.add_item("v0.7.2.0.7")
#		$RichTextLabel.add_text("\nDetected version v0.7.2.0.7 to download")
	if exists.file_exists(str(documents) + "/Pixel Zone/.data/updates/version4.html") and exists.file_exists(str(documents) + "/Pixel Zone/.data/updates/config/config.ini"):
		$ItemList.add_item("v0.7.2.0.9")
		$RichTextLabel.add_text("\nDetected version v0.7.2.0.9 to download")

func _on_Timer_timeout():
	_initialize()
	$Panel.hide()


func _on_Button_pressed():
	$HTTPRequest4.set_download_file(str(documents) + "/Pixel Zone/.data/updates/update.pck")
	$HTTPRequest4.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/%s/update.pck" % version_to_download)
	$RichTextLabel.add_text("\nResolving host...\nConnecting to download server...\nReciving...\nDownloading... https://github.com/MasterPolska123/pixel-zone-master/releases/download/%s/3d.pck" % version_to_download)
func _on_ItemList_item_selected(index):
	if index == 0:
		return
	if index == 1:
		version_to_download = "v0.7.2.0.9"
	if index == 2:
		version_to_download = "v0.7.2.1.0"
	if index == 3:
		version_to_download = "v0.7.2.1.1"
	if index == 4:
		version_to_download = "v0.7.2.1.2"
	$RichTextLabel.add_text("\nSelected version %s" % version_to_download)
