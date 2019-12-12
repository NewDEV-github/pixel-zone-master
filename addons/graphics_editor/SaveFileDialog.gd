tool
extends FileDialog

onready var canvas = get_parent().get_node("PaintCanvasContainer/PaintCanvas")

var file_path = ""

func _ready():
	# warning-ignore:return_value_discarded
	get_line_edit().connect("text_entered", self, "_on_LineEdit_text_entered")
	invalidate()
	clear_filters()
	add_filter("*.png ; PNG Images")

func _on_SaveFileDialog_file_selected(path):
	file_path = path

# warning-ignore:unused_argument
func _on_LineEdit_text_entered(text):
	save_file()

func _on_SaveFileDialog_confirmed():
	save_file()

func save_file():
	var image = Image.new()
	image.create(canvas.canvas_size.x, canvas.canvas_size.y, true, Image.FORMAT_RGBA8)
	image.lock()
	for i in canvas.get_node("Chunks").get_children():
		var chunk_name = i.name
		var chunk_name_split = chunk_name.split("-")
		var chunk_x = int(chunk_name_split[1])
		var chunk_y = int(chunk_name_split[2])
		var chunk_image = i.image.duplicate()
		chunk_image.lock()
		var chunk_image_size = chunk_image.get_size()
		for x in chunk_image_size.x:
			for y in chunk_image_size.y:
				var pixel_color = chunk_image.get_pixel(x, y)
				var global_cell_x = (chunk_x * canvas.region_size) + x
				var global_cell_y = (chunk_y * canvas.region_size) + y
				image.lock()
				image.set_pixel(global_cell_x, global_cell_y, pixel_color)
	image.unlock()
	image.save_png(file_path)

func _on_SaveFileDialog_about_to_show():
	invalidate()

func _on_SaveFileDialog_visibility_changed():
	invalidate()
