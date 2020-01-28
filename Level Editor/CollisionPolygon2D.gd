extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func hide_colour():
	$CollisionShape2D/ColorRect.hide()
func show_colour():
	$CollisionShape2D/ColorRect.show()
