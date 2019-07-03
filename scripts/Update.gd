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
#check downloaded versions of game
func _check():
	var down = File.new()
	down.open(str(documents) + "/Pixel Zone/.data/updates/version.save", File.READ)
	var downloaded_version = parse_json(down.get_line())
	if downloaded_version == "v0.7.2.0.9":
		$ItemList.set_item_disabled(0, true)
	if downloaded_version == "v0.7.2.1.0":
		$ItemList.set_item_disabled(1, true)
		$RichTextLabel.set_text("You have the nevest version of Pixel Zone")
#add items to item list
func _ready():
	$RichTextLabel2.hide()
	$ItemList.add_item("v0.7.2.1.0 - Current version")
	var config_updates = File.new()
	if config_updates.file_exists(str(documents) + "/Pixel Zone/.data/updates/config/config.ini"):
		$HTTPRequest5.set_download_file(str(documents) + "/Pixel Zone/.data/updates/version4.html")
		$HTTPRequest5.request("https://github.com/MasterPolska123/pixel-zone-master/releases/tag/v0.7.2.1.0")
#get list of updates wich are able to download
func _initialize():
	var exists = File.new()
	if exists.file_exists(str(documents) + "/Pixel Zone/.data/updates/version4.html") and exists.file_exists(str(documents) + "/Pixel Zone/.data/updates/config/config.ini"):
		$ItemList.add_item("v0.7.2.1.0")
		$RichTextLabel.add_text("\nDetected version v0.7.2.1.0 to download")
	_check()
#save name of downloaded version to file
func _process(delta):
	$RichTextLabel2.set_text("Downloaded " + str($HTTPRequest4.get_downloaded_bytes()) + " bytes of " + str($HTTPRequest4.get_body_size()))
	if $HTTPRequest4.get_downloaded_bytes() == $HTTPRequest4.get_body_size():
		var down = File.new()
		down.open(str(documents) + "/Pixel Zone/.data/updates/version.save", File.WRITE)
		down.store_line(to_json(version_to_download))
		down.close()
func _on_Timer_timeout():
	_initialize()
	$Panel.hide()
#download update from server
func _on_Button_pressed():
	$RichTextLabel2.show()
	$HTTPRequest4.set_download_file(str(documents) + "/Pixel Zone/.data/updates/update.pck")
	$HTTPRequest4.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/%s/update.pck" % version_to_download)
	$RichTextLabel.add_text("\nResolving host...\nConnecting to download server...\nReciving...\nDownloading... https://github.com/MasterPolska123/pixel-zone-master/releases/download/%s/update.pck" % version_to_download)
#select update to download
func _on_ItemList_item_selected(index):
	if index == 0:
		return
	if index == 1:
		version_to_download = "v0.7.2.1.0"
	$RichTextLabel.add_text("\nSelected version %s" % version_to_download)
