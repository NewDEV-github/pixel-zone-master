extends Control
var logged_in = false
#var auth_mode = null
const SWLogger = preload("res://addons/silent_wolf/utils/SWLogger.gd")
var login_data_dir = str(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)) + '/Pixel Zone/.data/'
func _ready():
	var auth_node = get_tree().get_root().get_node("res://addons/silent_wolf/Auth/Auth")
	SilentWolf.Auth.connect("sw_login_succeeded", self, "_on_login_succeeded")
	SilentWolf.Auth.connect("sw_login_failed", self, "_on_login_failed")
	SilentWolf.Auth.connect("sw_registration_succeeded", self, "_on_registration_succeeded")
	SilentWolf.Auth.connect("sw_registration_failed", self, "_on_registration_failed")
#	Firebase.Auth.connect('login_succeeded', self, 'login_succeeded_firebase')
func _on_Button_pressed():
	var username = $HBoxContainer/login/VBoxContainer/LineEdit3.text
	var email = $HBoxContainer/login/VBoxContainer/LineEdit.text
	var password = $HBoxContainer/login/VBoxContainer/LineEdit2.text
#	Firebase.Auth.login_with_email_and_password(email, password)
	SilentWolf.Auth.login_player(username, password)


func _on_Button2_pressed():
	var username = $HBoxContainer/Register/VBoxContainer/email.text
	var email = $HBoxContainer/Register/VBoxContainer/email2.text
	var password = $HBoxContainer/Register/VBoxContainer/pass.text
	var confirm = $HBoxContainer/Register/VBoxContainer/confirmpass.text
#	Firebase.Auth.signup_with_email_and_password(email, password)
	SilentWolf.Auth.register_player(username, email, password, confirm)
	var save_file = File.new()
	save_file.open_encrypted_with_pass(str(login_data_dir)  + "name.save", File.WRITE, str(2345654))
	save_file.store_line(email)
func _on_registration_succeeded():
	logged_in = true
	SWLogger.info("registration succeeded: " + str(SilentWolf.Auth.logged_in_player))
	#get_tree().change_scene("res://addons/silent_wolf/Auth/Login.tscn")
	# redirect to configured scene (user is logged in after registration)
	var scene_name = 'res://addons/silent_wolf/Scores/Leaderboard.tscn'
	get_tree().change_scene(scene_name)
	
func _on_registration_failed(error):
	SWLogger.info("registration failed: " + str(error))
#	$Label.set_text(str(error))
#	$Label.popup_centered()

func _on_login_succeeded():
	var scene_name = 'res://addons/silent_wolf/Scores/Leaderboard.tscn'
	SWLogger.info("logged in as: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene(scene_name)
	
func _on_login_failed(error):
	SWLogger.info("log in failed: " + str(error))
#	$Label.set_text(str(error))
#	$Label.popup_centered()
