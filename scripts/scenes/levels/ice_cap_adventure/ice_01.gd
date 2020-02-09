extends Node2D
var scene
var player_default = globals.selected_player
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		remove_child(player_default)
		scene = get_tree().change_scene("res://scenes/stages/ice_cap_adventure/ice_02.tscn")

func _ready():
	var player_default = globals.selected_player
	add_child(Object(player_default))
	globals._set_player_pos(0,0)
	player_default.restart_position()
	globals.on_scene_changed()
	var unlock = File.new()
	unlock.open_encrypted_with_pass("user://save_data.1", File.READ, str(34567865))
	var decrypted_sav_1 = int(str(unlock.get_line()))
	unlock.close()
	unlock.open_encrypted_with_pass("user://save_data.2", File.READ, str(34567865))
	var decrypted_sav_2 = int(str(unlock.get_line()))
	unlock.close()
	if decrypted_sav_1 == decrypted_sav_2:
		if not int(str(decrypted_sav_1)) >= 1:
			var a = File.new()
			a.open_encrypted_with_pass("user://save_data.1", File.WRITE, str(34567865))
			a.store_line("3")
			a.close()
			a.open_encrypted_with_pass("user://save_data.2", File.WRITE, str(34567865))
			a.store_line("3")
			a.close()
func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		if not str(OS.get_name()) == 'Android':
			remove_child(player_default)
			scene = get_tree().change_scene("res://scenes/GameOver.tscn")
