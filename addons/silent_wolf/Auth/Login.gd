extends TextureRect
func _process(_delta):
	var file = File.new()
	file.open('user://auth/data/name.dat', File.WRITE)
	file.store_line(str($FormContainer/CheckBox.pressed))
func _ready():
	var can_keep
	var file = File.new()
	if file.file_exists('user://auth/data/name.dat'):
		file.open('user://auth/data/name.dat', File.READ)
		var name = str(file.get_line())
		can_keep = bool(str(name))
		$FormContainer/CheckBox.pressed = can_keep
	if file.file_exists('user://auth/data/user.dat') and can_keep == true:
		file.open('user://auth/data/user.dat', File.READ)
		var name = str(file.get_line())
		$FormContainer/UsernameContainer/Username.set_text(str(name))
	if file.file_exists('user://auth/data/email.dat') and can_keep == true:
		file.open('user://auth/data/email.dat', File.READ)
		var name = str(file.get_line())
		$FormContainer/UsernameContainer2/Email.set_text(str(name))
	if file.file_exists('user://auth/data/pass.dat') and can_keep == true:
		file.open('user://auth/data/pass.dat', File.READ)
		var name = str(file.get_line())
		$FormContainer/PasswordContainer/Password.set_text(str(name))
	var auth_node = get_tree().get_root().get_node("res://addons/silent_wolf/Auth/Auth")
	SilentWolf.Auth.connect("login_succeeded", self, "_on_login_succeeded")
	SilentWolf.Auth.connect("login_failed", self, "_on_login_failed")

func _on_LoginButton_pressed():
	var username = $"FormContainer/UsernameContainer/Username".text
	var email = $FormContainer/UsernameContainer2/Email.text
	var password = $"FormContainer/PasswordContainer/Password".text
	SilentWolf.Auth.login_player(username, password)
	Firebase.Auth.login_with_email_and_password(email, password)
	
func _on_login_succeeded():
	var file = File.new()
	file.open('user://auth/data/user.dat', File.WRITE)
	file.store_line(str(SilentWolf.Auth.logged_in_player))
	file.open('user://auth/data/email.dat', File.WRITE)
	file.store_line(str($FormContainer/UsernameContainer2/Email.text))
	file.open('user://auth/data/pass.dat', File.WRITE)
	file.store_line(str($FormContainer/PasswordContainer/Password.text))
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	print("logged in as: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene(scene_name)
	
func _on_login_failed(error):
	print("log in failed: " + str(error))
	$"FormContainer/ErrorMessage".text = error
	$"FormContainer/ErrorMessage".show()
