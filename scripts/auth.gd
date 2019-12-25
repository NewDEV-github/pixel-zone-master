extends Control
var logged_in = false
var login_data_dir = str(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)) + '/Pixel Zone/.data/'
signal login_succeeded(auth_result)
signal logged_in(username)
func _ready():
	SilentWolf.Auth.connect('login_succeeded', self, 'login_succeeded')
	SilentWolf.Auth.connect('login_failed', self, 'login_failed')
	SilentWolf.Auth.connect('registration_succeeded', self, 'registration_succeeded')
	SilentWolf.Auth.connect('registration_failed', self, 'registration_failed')
	Firebase.Auth.connect('login_succeeded', self, 'login_succeeded_firebase')
func _on_Button_pressed():
	var username = $HBoxContainer/login/VBoxContainer/LineEdit3.text
	var email = $HBoxContainer/login/VBoxContainer/LineEdit.text
	var password = $HBoxContainer/login/VBoxContainer/LineEdit2.text
	Firebase.Auth.login_with_email_and_password(email, password)
	SilentWolf.Auth.login_player(username, password)


func _on_Button2_pressed():
	var username = $HBoxContainer/Register/VBoxContainer/email2.text
	var email = $HBoxContainer/Register/VBoxContainer/email.text
	var password = $HBoxContainer/Register/VBoxContainer/pass.text
	var confirm = $HBoxContainer/Register/VBoxContainer/confirmpass.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	SilentWolf.Auth.register_player(username, email, password, confirm)
	var save_file = File.new()
	save_file.open_encrypted_with_pass(str(login_data_dir)  + "name.save", File.WRITE, str(2345654))
	save_file.store_line(email)
func registration_succeeded():
	logged_in = true
	var username = $HBoxContainer/Register/VBoxContainer/email2.text
	emit_signal("logged_in", username)
	$HBoxContainer/Register/VBoxContainer/Label.set_text('Succeess')
func registration_failed():
	$HBoxContainer/Register/VBoxContainer/Label.set_text('Failed')
func login_succeeded():
	logged_in = true
	var username = $HBoxContainer/login/VBoxContainer/LineEdit.text
	emit_signal("logged_in", username)
	$HBoxContainer/login/VBoxContainer/Label.set_text('Succeess')
func login_failed():
	$HBoxContainer/login/VBoxContainer/Label.set_text('Failed')
func login_succeeded_firebase():
	var username = $HBoxContainer/login/VBoxContainer/LineEdit.text
	emit_signal("logged_in", username)
	logged_in = true
