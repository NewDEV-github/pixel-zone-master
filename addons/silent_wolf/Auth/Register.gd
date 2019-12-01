extends TextureRect
func _process(_delta):
	var file = File.new()
	file.open('user://auth/data/name.dat', File.WRITE)
	file.store_line(str($FormContainer/CheckBox.pressed))
func _ready():
	var auth_node = get_tree().get_root().get_node("res://addons/silent_wolf/Auth/Auth.gd")
	SilentWolf.Auth.connect("registration_succeeded", self, "_on_registration_succeeded")
	SilentWolf.Auth.connect("registration_failed", self, "_on_registration_failed")
	
func _on_RegisterButton_pressed():
	var player_name = $"FormContainer/MainFormContainer/FormInputFields/PlayerName".text
	var email = $"FormContainer/MainFormContainer/FormInputFields/Email".text
	var password = $"FormContainer/MainFormContainer/FormInputFields/Password".text
	var confirm_password = $"FormContainer/MainFormContainer/FormInputFields/ConfirmPassword".text
	SilentWolf.Auth.register_player(player_name, email, password, confirm_password)
	Firebase.Auth.signup_with_email_and_password(email, password)
	
func _on_registration_succeeded():
	print("registration succeeded: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene("res://addons/silent_wolf/Auth/Login.tscn")
	
func _on_registration_failed(error):
	print("registration failed: " + str(error))
	$"FormContainer/ErrorMessage".text = error
	$"FormContainer/ErrorMessage".show()
