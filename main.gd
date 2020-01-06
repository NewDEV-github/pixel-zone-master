extends KinematicBody2D
func restart_position():
	set_position(Vector2(0, 0))
	$'Player'.position = Vector2(0, 0)
	$'PlayerCamera'.set_position(Vector2(144, 90))
