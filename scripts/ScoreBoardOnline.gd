extends Control

var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var score = File.new()
var first
var second 
var third 
var fourth 
var fifth 
var loaded_score
var score_0
var score_1
var score_2
var score_3
var score_4
func _ready():
	SilentWolf.Scores.persist_score("alan_duval", 34)
	SilentWolf.Scores.persist_score("HamsterToad", 49)
	SilentWolf.Scores.persist_score("Bolivar", 17)
	SilentWolf.Scores.persist_score("appendage", 6)
	SilentWolf.Scores.persist_score("masterofdisaster", 28)
	SilentWolf.Scores.persist_score("ken", 24)
	SilentWolf.Scores.persist_score("rabidtiger", 39)
	SilentWolf.Scores.persist_score("Bloodnoon", 32)
func _on_Button_pressed():
	$"Login Panel".popup_centered()
	$Panel2.hide()

func _on_SignUp_pressed():
	var email = $"Login Panel/Sign In/Sign Up/Email".text
	var password = $"Login Panel/Sign In/Sign Up/Password".text
	var confirm_password = $"Login Panel/Sign In/Sign Up/Confirm Password".text
	if str(password) == str(confirm_password):
		SilentWolf.Auth.register_player(email, email, password, confirm_password)
		Firebase.Auth.signup_with_email_and_password(email, password)
#	if not str(password) == str(confirm_password):
#		$Label.show()
	var save_file = File.new()
	save_file.open_encrypted_with_pass(str(documents)  + "/Pixel Zone/.data/name.save", File.WRITE, str(2345654))
	save_file.store_line(str(email))
	get_tree().reload_current_scene()


func _on_Sign_In_pressed():
	var email = $"Login Panel/Sign In/Email".text
	var password = $"Login Panel/Sign In/Password".text
	Firebase.Auth.login_with_email_and_password(email, password)
	SilentWolf.Auth.login_player(email, password)
	var save_file = File.new()
	save_file.open_encrypted_with_pass(str(documents)  + "/Pixel Zone/.data/name.save", File.WRITE, str(2345654))
	save_file.store_line(str(email))
	get_tree().reload_current_scene()


func _on_Restore_pressed():
	OS.shell_open("https://masterpolska123.github.io/home/auth/login/")


func _on_RELOAD_pressed():
	get_tree().reload_current_scene()
