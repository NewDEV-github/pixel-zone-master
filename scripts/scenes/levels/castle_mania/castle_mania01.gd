extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var true_ = 'false'
	var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var vconf = ConfigFile.new()
	vconf.load(str(documents) + "/Pixel Zone/.data/settings/game.ini")
	var passed = str(vconf.get_value("saves", "game_pass", true_))
	if str(passed) == 'false':
		var a = File.new()
		a.open_encrypted_with_pass("user://save_data.1", File.WRITE, str(34567865))
		a.store_line("15")
		a.close()
		var b = File.new()
		b.open_encrypted_with_pass("user://save_data.2", File.WRITE, str(34567865))
		b.store_line("15")
		b.close()


func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_Area2D5_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_Area2D8_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_Area2D22_body_entered(body):
	if body.name == "Player":
		background_load.load_scene("res://scenes/stages/castle_mania/castle_mania02.tscn")


func _on_Area2D23_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/GameOver.tscn")