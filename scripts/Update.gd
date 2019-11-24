extends Control
export (float) var file_name
export (String) var Update_server = "https://masterpolska123.github.io/home/updates/"
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
	$HTTPRequest.set_download_file('user://%s.txt' % [str(file_name)])
	print(str("https://masterpolska123.github.io/home/updates_info/%s.txt" % [str(file_name)]))
	$HTTPRequest.request("https://masterpolska123.github.io/home/updates_info/%s.txt" % [str(file_name)], [], true)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == HTTPClient.RESPONSE_OK :
		print('Update avaliable')
		$AcceptDialog.connect("confirmed", self, '_ok')
		$AcceptDialog.set_text('Update found.\nClick ok to go to download website.')
		$AcceptDialog.popup_centered()
#	if response_code == HTTPClient.RESPONSE_NOT_FOUND :
#		print('Update not found')
#		$AcceptDialog.connect("confirmed", self, '_failed')
#		$AcceptDialog.set_text('Update not found.\n Click ok or "x" to close.')
#		$AcceptDialog.popup_centered()
#	if response_code == HTTPClient.RESPONSE_BAD_GATEWAY :
#		print('Sorry... Bad gateway')
#		$AcceptDialog.connect("confirmed", self, '_failed')
#		$AcceptDialog.set_text('Update not found.\n Click ok or "x" to close.')
#		$AcceptDialog.popup_centered()
	
	print(str(response_code))
func _ok():
	OS.shell_open('https://masterpolska123.github.io/home/pixel-zone/')
	hide()
func _failed():
	$AcceptDialog.hide()
	hide()


func _on_Button_pressed():
	_ready()


func _on_AcceptDialog_popup_hide():
	hide()
