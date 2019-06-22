extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.hide()
	var config = File.new()
	if config.file_exists(str(documents)  + "/Pixel Zone/.data/user_config.save"):
		config.open(str(documents)  + "/Pixel Zone/.data/user_name.save", File.READ)
		load_name = config.get_line()
#func login():
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _on_Button_pressed():
	hide()

	
export (String) var load_name

func _on_Button2_pressed():
	var config = File.new()
	var config2 = File.new()
	if config.file_exists(str(documents)  + "/Pixel Zone/.data/user_config.save"):
		config.open(str(documents)  + "/Pixel Zone/.data/user_name.save", File.READ)
		var loaded_name = config.get_line()
		config2.open(str(documents)  + "/Pixel Zone/.data/user_pass.save", File.READ)
		var loaded_pass = config2.get_line()
		if $Control/HBoxContainer/username.text == loaded_name and $Control/HBoxContainer/password.text == loaded_pass:
			load_name = loaded_name
			print(load_name)
			hide()
		if not $Control/HBoxContainer/username.text == loaded_name or not $Control/HBoxContainer/password.text == loaded_pass:
			$Control/HBoxContainer/Label.set_text("Invalid password or username!")
func _on_Button3_pressed():
	$Control.hide()
	$Control2.show()
