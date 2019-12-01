extends Area2D

var taken=false
var save_dict = 'null'
func save():
	return save_dict


func _on_coin_body_entered(body):
	if body.name == "Player":
		get_node("/root/game_state").points += 1
		$anim.play("taken")
		taken = true
		game_state._save()
		var points = {
		'COINS' : game_state.points,
		'STAGE' : globals.current_stage
		}
		var playername = str(SilentWolf.Auth.logged_in_player)
		SilentWolf.Scores.persist_score(playername, points)
