extends Control
func _process(delta):
	get_node("VBoxContainer/stats_coins").set_text(str(get_node("/root/game_state").points))
	get_node("VBoxContainer/stats_points").set_text(str(get_node("/root/game_experience").points))
	get_node("VBoxContainer/stats_killed_enemies").set_text(str(get_node("/root/killed_enemies").points))

func _on_Hide_pressed():
	hide()
	
func save():
    var save_dict = {
        "filename" : get_filename(),
        "parent" : get_parent().get_path(),
        "coins_points" : get_node("/root/game_state").points,
        "killed_enemies_points" : get_node("/root/killed_enemies").points,
        "experience_points" : get_node("/root/game_experience").points,
		"pos_x" : get_position().x,
		"pos_y" : get_position().y,
    }
    return save_dict
