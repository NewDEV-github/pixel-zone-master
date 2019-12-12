extends Control

func _ready():
	var auth_node = get_tree().get_root().get_node("res://addons/silent_wolf/Auth/Auth")
	SilentWolf.Auth.connect("login_succeeded", self, "_on_login_succeeded")
	SilentWolf.Auth.connect("login_failed", self, "_on_login_failed")

func _on_LoginButton_pressed():
	var username = $"FormContainer/UsernameContainer/Username".text
	var email = $"FormContainer/UsernameContainer2/Username".text
	var password = $"FormContainer/PasswordContainer/Password".text
	SilentWolf.Auth.login_player(username, password)
#	Firebase.Auth.login_with_email_and_password(email, password)
	show_processing_label()
	
func _on_login_succeeded():
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	print("logged in as: " + str(SilentWolf.Auth.logged_in_player))
	get_tree().change_scene(scene_name)
	
func _on_login_failed(error):
	hide_processing_label()
	print("log in failed: " + str(error))
	$"FormContainer/ErrorMessage".text = error
	$"FormContainer/ErrorMessage".show()

func _on_BackButton_pressed():
	get_tree().change_scene(SilentWolf.auth_config.redirect_to_scene)
	
func show_processing_label():
	$"FormContainer/ProcessingLabel".show()
	
func hide_processing_label():
	$"FormContainer/ProcessingLabel".hide()
