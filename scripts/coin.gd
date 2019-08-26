extends Area2D

var taken=false
var save_dict = 'null'
func save():
	return save_dict


func _on_coin_body_entered(body):
	if body.name == "Player":
		get_node("/root/game_state").points += 1
		get_node("/root/game_state").points_temp +=1
		$anim.play("taken")
		taken = true
		game_state._save()
