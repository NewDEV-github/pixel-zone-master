extends Area2D

var taken=false
var save_dict = 'null'
func save():
	return save_dict


func _on_coin_body_entered(body):
	if body.name == "Player":
		game_state.points += 1
		print(str(game_state.points))
		$anim.play("taken")
		taken = true
		game_state._save()
		game_state._update_data()
