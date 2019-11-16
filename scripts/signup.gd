extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time


func _on_LinkButton_pressed():
	OS.shell_open("https://masterpolska.pl.tl/Polityka--Prywatno%26%23347%3Bci.htm")
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var user_name = $Panel/VBoxContainer/name.text
var user_pass = $Panel/VBoxContainer/password.text
func _on_Button_pressed():
	var config = File.new()
	config.open(str(documents) + "/Pixel Zone/.data/user_name.save", File.WRITE)
	config.store_line(str(user_name))
	var config2 = File.new()
	config2.open(str(documents) + "/Pixel Zone/.data/user_pass.save", File.WRITE)
	config2.store_line(str(user_pass))
	var config3 = File.new()
	config3.open(str(documents) + "/Pixel Zone/.data/user_config.save", File.WRITE)
	get_tree().quit()
