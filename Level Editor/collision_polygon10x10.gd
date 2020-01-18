extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	hide_color()
# Called when the node enters the scene tree for the first time.
func hide_color():
	$ColorRect.hide()

func show_color():
	$ColorRect.show()
