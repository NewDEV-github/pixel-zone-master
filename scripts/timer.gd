extends Label
var ms = 0
var s = 0
var m = 0
func _process(delta):
	if ms > 9:
		s += 1
		ms = 0
	if s > 59:
		m += 1
		s = 0
	set_text(str(m)+":"+str(s)+":"+str(ms))




func _on_Timer_timeout():
	ms += 1
	
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