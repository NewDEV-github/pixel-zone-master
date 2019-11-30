extends TextureRect

func _ready():
	var auth_node = get_tree().get_root().get_node("res://addons/silent_wolf/Auth/Auth")
	SilentWolf.Auth.connect("registration_succeeded", self, "_on_registration_succeeded")
	SilentWolf.Auth.connect("registration_failed", self, "_on_registration_failed")
	
func _on_RegisterButton_pressed():
	var player_name = $"FormContainer/MainFormContainer/FormInputFields/PlayerName".text
	var email = $"FormContainer/MainFormContainer/FormInputFields/Email".text
	var password = $"FormContainer/MainFormContainer/FormInputFields/Password".text
	var confirm_password = $"FormContainer/MainFormContainer/FormInputFields/ConfirmPassword".text
	SilentWolf.Auth.register_player(player_name, email, password, confirm_password)
	
func _on_registration_succeeded():
	print("registration succeeded: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene("res://addons/silent_wolf/Auth/Login.tscn")
	
func _on_registration_failed(error):
	print("registration failed: " + str(error))
	$"FormContainer/ErrorMessage".text = error
	$"FormContainer/ErrorMessage".show()