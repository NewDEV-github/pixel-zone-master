tool
extends Control

export var color = Color()

func _ready():
	pass

func _draw():
	draw_outline_box(rect_size, color, 3)

func draw_outline_box(size, color, width):
		#Top line
		draw_line(Vector2(0 + 1, 0), Vector2(size.x, 0), color, width)
		#Left line
		draw_line(Vector2(0 + 1, 0), Vector2(0, size.y), color, width)
		#Bottom line
		draw_line(Vector2(0 + 1, size.y), Vector2(size.x, size.y), color, width)
		#Right line
		draw_line(Vector2(size.x, 0), Vector2(size.x, size.y), color, width)

func _process(delta):
	update()