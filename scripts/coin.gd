extends Area2D

var taken=false
	

	
   
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


func _on_coin_body_entered(body):
	if body.name == "Player":
		get_node("/root/game_state").points += 1
		get_node("/root/game_state").points_temp +=1
		get_node("/root/game_experience").points += 1
		$anim.play("taken")
		taken = true
		game_state._save()
	
