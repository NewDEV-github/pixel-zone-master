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
	initialize()
#var initialized = false
#func _process(delta):
#	if initialized == false:
#		if $HTTPRequest.RESULT_SUCCESS:
#			initialize()
#			initialized = false
func initialize():
	$ProgressBar.set_value(55)
	var update = File.new()
	$ProgressBar.set_value(65)
	update.open("user://latest_version.txt", File.READ)
	latest_update = update.get_line()
	$ProgressBar.set_value(75)
	if latest_update != '':
		$ItemList.add_item(str(latest_update))
	if latest_update == '':
		$RichTextLabel.add_text('Any update is not avaliable yet...')
	
	var update_description = File.new()
	$ProgressBar.set_value(80)
	update_description.open("user://version_info.txt", File.READ)
	update_info = update_description.get_as_text()
	$ProgressBar.set_value(90)
	$RichTextLabel2.set_text(str(update_info))
	$ProgressBar.set_value(95)
	$Panel.hide()
	$ProgressBar.hide()


func _on_ItemList_item_selected(index):
	$Button.set_disabled(false)
	$RichTextLabel2.show()
	version_to_download = latest_update
	print(str(version_to_download))

func _on_Button_pressed():
	$HTTPRequest2.set_download_file(str(documents) + "/Pixel Zone/.data/updates/update.pck")
	$HTTPRequest2.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/%s/update.pck" % version_to_download)
	$RichTextLabel.add_text("Downloading... version %s" % version_to_download)