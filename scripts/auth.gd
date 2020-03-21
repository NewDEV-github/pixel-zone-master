extends Control
#var logged_player = str(SilentWolf.Auth.logged_in_player)
const SWLogger = preload("res://addons/silent_wolf/utils/SWLogger.gd")
func _ready():
#	var scene_name = SilentWolf.auth_config.redirect_to_scene
#	if not str(logged_player) == null:
#		get_tree().change_scene(scene_name)
	var auth_node = get_tree().get_root().get_node("res://addons/silent_wolf/Auth/Auth")
	SilentWolf.Auth.connect("sw_registration_succeeded", self, "_on_registration_succeeded")
	SilentWolf.Auth.connect("sw_registration_failed", self, "_on_registration_failed")
	SilentWolf.Auth.connect("sw_login_succeeded", self, "_on_login_succeeded")
	SilentWolf.Auth.connect("sw_login_failed", self, "_on_login_failed")
	SilentWolf.Auth.connect("sw_email_verif_succeeded", self, "_on_confirmation_succeeded")
	SilentWolf.Auth.connect("sw_email_verif_failed", self, "_on_confirmation_failed")
	SilentWolf.Auth.connect("sw_resend_conf_code_succeeded", self, "_on_resend_code_succeeded")
	SilentWolf.Auth.connect("sw_resend_conf_code_failed", self, "_on_resend_code_failed")

###LOGGING IN
func _on_LoginButton_pressed():
	var username = $MainCon/login/LogCon/username.text
	var password = $MainCon/login/LogCon/pass.text
	var remember_me = false
	SWLogger.debug("Login form submitted, remember_me: " + str(remember_me))
	SilentWolf.Auth.login_player(username, password, remember_me)
	show_processing()
	
func _on_login_succeeded():
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	SWLogger.info("logged in as: " + str(SilentWolf.Auth.logged_in_player))
	globals.debug_auth_player()
	get_tree().change_scene(scene_name)
	
func _on_login_failed(error):
	hide_processing()
	SWLogger.info("log in failed: " + str(error))
	$ERROR.text = str(tr('AUTH_ERROR')) + ' ' + str(error)
	$ERROR.show()

### INTERFACE
func _on_BackButton_pressed():
	get_tree().change_scene(SilentWolf.auth_config.redirect_to_scene)
	
func show_processing():
	$ProcessingPanel.show()
	
func hide_processing():
	$ProcessingPanel.hide()

###REGISTERING
func _on_RegisterButton_pressed():
	var player_name = $MainCon/Reg/RegCon/username.text
	var email = $MainCon/Reg/RegCon/email.text
	var password = $MainCon/Reg/RegCon/pass.text
	var confirm_password = $MainCon/Reg/RegCon/confirmpass.text
	SilentWolf.Auth.register_player(player_name, email, password, confirm_password)
	show_processing()
	show_confirm_email()
	$ERROR.hide()
	
func _on_registration_succeeded():
	SWLogger.info("registration succeeded: " + str(SilentWolf.Auth.logged_in_player))
	#get_tree().change_scene("res://addons/silent_wolf/Auth/Login.tscn")
	# redirect to configured scene (user is logged in after registration)

	
func _on_registration_failed(error):
	hide_processing()
	SWLogger.info("registration failed: " + str(error))
	$ERROR.text = str(tr('AUTH_ERROR')) + ' ' + str(error)
	$ERROR.show()
#
#func _on_UsernameToolButton_mouse_entered():
#	$"FormContainer/InfoBox".text = "Username should contain at least 6 characters (letters or numbers) and no spaces."
#	$"FormContainer/InfoBox".show()
#
#func _on_UsernameToolButton_mouse_exited():
#	$"FormContainer/InfoBox".hide()
#
#func _on_PasswordToolButton_mouse_entered():
#	$"FormContainer/InfoBox".text = "Password should contain at least 8 characters including uppercase and lowercase letters, numbers and (optionally) special characters."
#	$"FormContainer/InfoBox".show()
#
#func _on_PasswordToolButton_mouse_exited():
#	$"FormContainer/InfoBox".hide()


func _on_Button_pressed():
	background_load.load_scene('res://scenes/Main Menu/GUI.tscn')


func _on_CofirmReg_pressed():
	_on_RegisterButton_pressed()


func _on_CheckBox_toggled(button_pressed):
	if button_pressed == true:
		$MainCon/Reg/RegCon/confirmpass.set_secret(false)
		$MainCon/Reg/RegCon/pass.set_secret(false)
		$MainCon/login/LogCon/pass.set_secret(false)
	else:
		$MainCon/Reg/RegCon/confirmpass.set_secret(true)
		$MainCon/Reg/RegCon/pass.set_secret(true)
		$MainCon/login/LogCon/pass.set_secret(true)


###Email Verification
	
func _on_confirmation_succeeded():
	SWLogger.info("email verification succeeded: " + str(SilentWolf.Auth.logged_in_player))
	# redirect to configured scene (user is logged in after registration)
	var scene_name = SilentWolf.auth_config.redirect_to_scene
	get_tree().change_scene(scene_name)
	
	
func _on_confirmation_failed(error):
	hide_processing()
	SWLogger.info("email verification failed: " + str(error))
	$ConfirmEmailPanel/Confirm/VBoxContainer/Label.text = error
	
	
func _on_resend_code_succeeded():
	SWLogger.info("Code resend succeeded for player: " + str(SilentWolf.Auth.tmp_username))
	$ConfirmEmailPanel/Confirm/VBoxContainer/Label.text = "Confirmation code was resent to your email address"
	

func _on_resend_code_failed():
	SWLogger.info("Code resend failed for player: " + str(SilentWolf.Auth.tmp_username))
	$ConfirmEmailPanel/Confirm/VBoxContainer/Label.text = "Confirmation code could not be resent"

func show_confirm_email():
	$ConfirmEmailPanel.show()
	$ConfirmEmailPanel/Confirm.popup_centered()

func hide_confirm_email():
	$ConfirmEmailPanel.hide()
	$ConfirmEmailPanel/Confirm.hide()

func _on_ConfirmButton_pressed():
	var username = SilentWolf.Auth.tmp_username
	var code = $ConfirmEmailPanel/Confirm/VBoxContainer/Code.text
	SWLogger.debug("Email verification form submitted, code: " + str(code))
	SilentWolf.Auth.verify_email(username, code)
	show_processing()
	
	
# TODO: implement
func _on_ResendConfCodeButton_pressed():
	var username = SilentWolf.Auth.tmp_username
	SWLogger.debug("Requesting confirmation code resend")
	SilentWolf.Auth.resend_conf_code(username)
	show_processing()


func _on_Confirm_popup_hide():
	hide_confirm_email()


func _on_Cancel_pressed():
	hide_confirm_email()
