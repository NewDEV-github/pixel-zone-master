extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func restart_position():
	set_position(Vector2(0, 0))
	$'Player'.position = Vector2(0, 0)
	$'Player_ai2'.set_position(Vector2(144, 90))
	
func _process(delta):
#	print(str(is_instance_valid($Player_ai2)))
	var pos_y = $Player.position.y
	var pos_x = $Player.position.x
	var length = ($Player.position - $Player_ai2.position).length()
	if length >= 900:
		$Player_ai2.set_position(Vector2(float(pos_x - 3), float(pos_y - 3)))
