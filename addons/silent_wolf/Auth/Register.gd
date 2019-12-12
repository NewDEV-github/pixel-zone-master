extends Control

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
	show_processing_label()
#	Firebase.Auth.signup_with_email_and_password(email, password)
	
func _on_registration_succeeded():
	print("registration succeeded: " + str(SilentWolf.Auth.logged_in_player))
	#get_tree().change_scene("res://addons/silent_wolf/Auth/Login.tscn")
	# redirect to configured scene (user is logged in after registration)
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	get_tree().change_scene(scene_name)
	
func _on_registration_failed(error):
	hide_processing_label()
	print("registration failed: " + str(error))
	$"FormContainer/ErrorMessage".text = error
	$"FormContainer/ErrorMessage".show()

func _on_BackButton_pressed():
	get_tree().change_scene(SilentWolf.auth_config.redirect_to_scene)
	
func show_processing_label():
	$"FormContainer/ProcessingLabel".show()
	
func hide_processing_label():
	$"FormContainer/ProcessingLabel".hide()

func _on_ToolButton_mouse_entered():
	$"FormContainer/InfoBox".show()

func _on_ToolButton_mouse_exited():
	$"FormContainer/InfoBox".hide()
