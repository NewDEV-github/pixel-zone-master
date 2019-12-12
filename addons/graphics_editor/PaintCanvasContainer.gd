tool
extends Control

var mouse_in_region
var mouse_on_top

func _ready():
	pass

func _process(delta):
	var mouse_position = get_local_mouse_position()
	var rect = Rect2(Vector2(0, 0), rect_size)
	mouse_in_region = rect.has_point(mouse_position)

func _on_PaintCanvasContainer_mouse_entered():
	mouse_on_top = true

func _on_PaintCanvasContainer_mouse_exited():
	mouse_on_top = false