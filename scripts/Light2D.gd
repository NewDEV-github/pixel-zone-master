extends Light2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var players_pos_x = float(globals._get_player_pos_x()) + 243
	var players_pos_y = float(globals._get_player_pos_y()) + 71
	set_position(Vector2(float(players_pos_x), float(players_pos_y)))
