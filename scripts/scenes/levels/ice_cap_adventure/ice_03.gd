extends Node2D


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		remove_child(player_default)
		get_tree().change_scene("scenes/stages/jungle_ruins/jungle_ruins01.tscn")
var player_default = globals.selected_player
func _ready():
	add_child(Object(player_default))
	globals._set_player_pos(0,0)
	var true_ = 'false'
	var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var vconf = ConfigFile.new()
	vconf.load(str(documents) + "/Pixel Zone/.data/settings/game.ini")
	var passed = str(vconf.get_value("saves", "game_pass", true_))
	if str(passed) == 'false':
		var a = File.new()
		a.open_encrypted_with_pass("user://save_data.1", File.WRITE, str(34567865))
		a.store_line("5")
		a.close()
		a.open_encrypted_with_pass("user://save_data.2", File.WRITE, str(34567865))
		a.store_line("5")
		a.close()

	
func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		remove_child(player_default)
		get_tree().change_scene("res://scenes/GameOver.tscn")

