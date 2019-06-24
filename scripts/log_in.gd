extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var config = File.new()
	if config.file_exists(str(documents)  + "/Pixel Zone/.data/user_config.save"):
		config.open(str(documents)  + "/Pixel Zone/.data/user_name.save", File.READ)
		load_name = config.get_line()
#func login():
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _on_Button_pressed():
	hide()

	
export (String) var load_name

func _on_Button2_pressed():
	var email = $Control/HBoxContainer/email.text
	var password = $Control/HBoxContainer/password
	Firebase.Auth.login_with_email_and_password(email, password)
	hide()
func _on_Button3_pressed():
	$Control.hide()
	$Control2.show()
