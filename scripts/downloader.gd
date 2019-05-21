extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _on_Button_pressed():
	$Label.show()
	$HTTPRequest.set_download_file("user://linux32.zip")
	$HTTPRequest.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/v0.7.2.0.5/linux32.zip")
func _process(delta):
	$Label.set_text("Downloaded " + str($HTTPRequest.get_downloaded_bytes()) + " bytes of " + str($HTTPRequest.get_body_size()) + " bytes (" + (str($HTTPRequest.get_downloaded_bytes()/($HTTPRequest.get_body_size()*(0.01)))) +" %)")