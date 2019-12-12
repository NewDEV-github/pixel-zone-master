tool
extends Control

func _ready():
	for i in get_node("Buttons").get_children():
		i.connect("item_pressed", self, "button_pressed")

func button_pressed(button_name, button_item):
	if button_name == "File":
		if button_item == "Save":
			get_parent().get_node("SaveFileDialog").show()
		if button_item == "Quit":
			get_tree().quit()
	elif button_name == "Editor":
		if button_item == "Settings":
			get_parent().get_node("Settings").show()
		elif button_item == "Toggle Grid":
			var grids_node = get_parent().get_node("PaintCanvasContainer/PaintCanvas/Grids")
			grids_node.visible = !grids_node.visible
		elif button_item == "Reset Canvas Position":
			get_parent().paint_canvas_node.rect_position = Vector2(0, 0)