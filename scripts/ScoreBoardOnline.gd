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
	#load user's score
	score.open_encrypted_with_pass("user://other_saves/0.save", File.READ, str(3087283))
	score_0 = score.get_line()
	print(score_0)
	score.close()
	var save_file = File.new()
	#Load current user's name
	if not save_file.file_exists(str(documents)  + "/Pixel Zone/.data/name.save"):
		$Panel2.show()
	save_file.open_encrypted_with_pass(str(documents)  + "/Pixel Zone/.data/name.save", File.READ, str(2345654))
	var loaded_name = save_file.get_line()
	$Panel/Names.add_item(str(loaded_name) + " - You")
	$Panel/Scores.add_item(str(score_0))
	#load other user's scores
	#1
	score.open('user://other_saves/1.save', File.READ)
	score_1 = parse_json(score.get_line())
	score.close()
	#2
	score.open('user://other_saves/2.save', File.READ)
	score_2 = parse_json(score.get_line())
	score.close()
	#3
	score.open('user://other_saves/3.save', File.READ)
	score_3 = parse_json(score.get_line())
	score.close()
	#4
	score.open('user://other_saves/4.save', File.READ)
	score_4 = parse_json(score.get_line())
	score.close()
	#count users from highest score to lower


func _on_Button_pressed():
	$"Login Panel".popup_centered()
	$Panel2.hide()

func _on_SignUp_pressed():
	var email = $"Login Panel/Sign In/Sign Up/Email".text
	var password = $"Login Panel/Sign In/Sign Up/Password".text
	var confirm_password = $"Login Panel/Sign In/Sign Up/Confirm Password".text
	if str(password) == str(confirm_password):
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
	var save_file = File.new()
	save_file.open_encrypted_with_pass(str(documents)  + "/Pixel Zone/.data/name.save", File.WRITE, str(2345654))
	save_file.store_line(str(email))
	get_tree().reload_current_scene()


func _on_Restore_pressed():
	OS.shell_open("https://masterpolska123.github.io/home/login.html")


func _on_RELOAD_pressed():
	get_tree().reload_current_scene()
