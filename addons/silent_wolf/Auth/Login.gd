extends TextureRect

func _ready():
	var auth_node = get_tree().get_root().get_node("res://addons/silent_wolf/Auth/Auth")
	SilentWolf.Auth.connect("login_succeeded", self, "_on_login_succeeded")
	SilentWolf.Auth.connect("login_failed", self, "_on_login_failed")

func _on_LoginButton_pressed():
	var username = $"FormContainer/UsernameContainer/Username".text
	var password = $"FormContainer/PasswordContainer/Password".text
	SilentWolf.Auth.login_player(username, password)
	
func _on_login_succeeded():
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	print("logged in as: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene(scene_name)
	
func _on_login_failed(error):
	print("log in failed: " + str(error))
	$"FormContainer/ErrorMessage".text = error
	$"FormContainer/ErrorMessage".show()
