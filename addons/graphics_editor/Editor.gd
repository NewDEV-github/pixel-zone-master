tool
extends Control

onready var paint_canvas_container_node = get_node("PaintCanvasContainer")
onready var paint_canvas_node = paint_canvas_container_node.get_node("PaintCanvas")
onready var grids_node = paint_canvas_node.get_node("Grids")
var selected_color = Color(1, 1, 1, 1)
var util = preload("res://addons/graphics_editor/Util.gd")
onready var textinfo = get_node("BottomPanel/TextInfo")
onready var grid_size = paint_canvas_node.grid_size
onready var region_size = paint_canvas_node.region_size
var allow_drawing = true

func _ready():
	#---------------------------
	#Setup the info bottom panel
	#---------------------------
	add_text_info_variables()
	
	#--------------------
	#Setup the layer tree
	#--------------------
	setup_layer_tree()
	
	#------------------
	#Setup visual grids
	#------------------
	for i in grids_node.get_children():
		i.rect_size = Vector2(paint_canvas_node.canvas_size.x * grid_size, paint_canvas_node.canvas_size.y * grid_size)
	grids_node.get_node("VisualGrid").size = grid_size
	grids_node.get_node("VisualGrid2").size = grid_size * region_size
	
	#-----------------------------------
	#Setup canvas node size and position
	#-----------------------------------
	paint_canvas_node.rect_size = Vector2(paint_canvas_node.canvas_size.x * grid_size, paint_canvas_node.canvas_size.y * grid_size)
	paint_canvas_node.rect_min_size = Vector2(paint_canvas_node.canvas_size.x * grid_size, paint_canvas_node.canvas_size.y * grid_size)
	
	#------------------------------------------------------------
	#Set the selected color to what the color picker has selected
	#------------------------------------------------------------
	selected_color = get_node("ToolMenu/Buttons/ColorPicker").color
	
	#----------------------------------------------------------------
	#Setup is done so we can now allow the user to draw on the canvas
	#----------------------------------------------------------------
	paint_canvas_node.can_draw = true

func setup_layer_tree():
	var tree = get_node("ToolMenu/Layers/Tree")
	var root = tree.create_item()
	tree.set_hide_root(true)
	var child1 = tree.create_item(root)
	child1.set_text(0, "Layers")
	child1.set_editable(0, true)
	for i in paint_canvas_node.layers:
		var layer_name = i.name
		var subchild = tree.create_item(child1)
		subchild.set_text(0, layer_name)
		subchild.set_editable(0, true)

func _thread_process():
	pass

var brush_mode = "paint"

var mouse_position = Vector2()
var canvas_position = Vector2()
var canvas_mouse_position = Vector2()
var cell_mouse_position = Vector2()
var cell_region_position = Vector2()
var cell_position_in_region = Vector2()
var cell_color = Color()

var last_mouse_position = Vector2()
var last_canvas_position = Vector2()
var last_canvas_mouse_position = Vector2()
var last_cell_mouse_position = Vector2()
var last_cell_color = Color()

# warning-ignore:unused_argument
func _process(delta):
	#It's a lot more easier to just keep updating the variables in here than just have a bunch of local variables
	#in every update function and make it very messy
	if paint_canvas_node == null:
		set_process(false)
		return
		
	#Update commonly used variables
	grid_size = paint_canvas_node.grid_size
	region_size = paint_canvas_node.region_size
	mouse_position = get_local_mouse_position()
	canvas_position = paint_canvas_node.rect_position + paint_canvas_container_node.rect_position
	canvas_mouse_position = Vector2(mouse_position.x - canvas_position.x, mouse_position.y - canvas_position.y)
	cell_mouse_position = Vector2(floor(canvas_mouse_position.x / grid_size), floor(canvas_mouse_position.y / grid_size))
	cell_region_position = Vector2(floor(cell_mouse_position.x / region_size), floor(cell_mouse_position.y / region_size))
	cell_position_in_region = paint_canvas_node.get_region_from_cell(cell_mouse_position.x, cell_mouse_position.y)
	cell_color = paint_canvas_node.get_pixel_cell_color(cell_mouse_position.x, cell_mouse_position.y)
	
	#Process the brush drawing stuff
	if paint_canvas_container_node.mouse_in_region and paint_canvas_container_node.mouse_on_top:
		brush_process()
	
	#Render the highlighting stuff
	update()
	
	#Canvas Shift Moving
	if not mouse_position == last_mouse_position:
		if paint_canvas_container_node.has_focus():
			if Input.is_key_pressed(KEY_SHIFT):
				if Input.is_mouse_button_pressed(BUTTON_LEFT):
					var relative = mouse_position - last_mouse_position
					paint_canvas_node.rect_position += relative
				allow_drawing = false
			else:
				allow_drawing = true
	
	#Update text info
	update_text_info()
	
	#Update last variables with the current variables
	last_mouse_position = mouse_position
	last_canvas_position = canvas_position
	last_canvas_mouse_position = canvas_mouse_position
	last_cell_mouse_position = cell_mouse_position
	last_cell_color = cell_color

var currently_selecting = false
func _draw():
	if paint_canvas_node == null:
		return
	if paint_canvas_container_node.mouse_in_region and paint_canvas_node.mouse_in_region:
		#draw cell_mouse_position
		if paint_canvas_node.cell_in_canvas_region(cell_mouse_position.x, cell_mouse_position.y):
			draw_rect(Rect2(Vector2((cell_mouse_position.x * grid_size) + canvas_position.x, (cell_mouse_position.y * grid_size) + canvas_position.y), Vector2(grid_size, grid_size)), Color(0.8, 0.8, 0.8, 0.8), true)

func draw_outline_box(pos, size, color, width):
	#Top line
	draw_line(Vector2(0 + 1 + pos.x, 0 + pos.y), Vector2(pos.x + size.x, 0 + pos.y), color, width)
	#Left line
	draw_line(Vector2(0 + 1 + pos.x, 0 + pos.y), Vector2(0 + pos.x, pos.y + size.y), color, width)
	#Bottom line
	draw_line(Vector2(0 + 1 + pos.x, pos.y + size.y), Vector2(pos.x + size.x, pos.y + size.y), color, width)
	#Right line
	draw_line(Vector2(pos.x + size.x, 0 + pos.y), Vector2(pos.x + size.x, pos.y + size.y), color, width)

func pool_vector2_array_append_new_value(vec2array, vec2):
	for i in vec2array:
		if i == vec2:
			return
	vec2array.append(vec2)

func custom_rect_size_brush(x, y, color, size):
	for cx in range(x, x + size):
		for cy in range(y, y + size):
			paint_canvas_node.set_pixel_cell(cx, cy, color)
	pass

func brush_process():
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if allow_drawing:
			if brush_mode == "paint":
				paint_canvas_node.set_pixels_from_line(cell_mouse_position, last_cell_mouse_position, selected_color)
			if brush_mode == "bucket":
				paint_canvas_node.flood_fill(cell_mouse_position.x, cell_mouse_position.y, cell_color, selected_color)
			if brush_mode == "rainbow":
				paint_canvas_node.set_random_pixels_from_line(cell_mouse_position, last_cell_mouse_position)
	elif Input.is_mouse_button_pressed(BUTTON_RIGHT):
		if allow_drawing:
			if brush_mode == "paint" or brush_mode == "rainbow":
				paint_canvas_node.set_pixels_from_line(cell_mouse_position, last_cell_mouse_position, Color(0, 0, 0, 0))
			if brush_mode == "bucket":
				paint_canvas_node.flood_fill(cell_mouse_position.x, cell_mouse_position.y, cell_color, Color(0, 0, 0, 0))

func add_text_info_variables():
	textinfo.add_text_info("FPS")
	textinfo.add_text_info("Mouse Position")
	textinfo.add_text_info("Canvas Mouse Position")
	textinfo.add_text_info("Canvas Position")
	textinfo.add_text_info("Cell Position")
	var cell_color_texture_rect = ColorRect.new()
	cell_color_texture_rect.name = "Cell Color"
	cell_color_texture_rect.rect_size = Vector2(14, 14)
	cell_color_texture_rect.rect_position.x = 120
	textinfo.add_text_info("Cell Color", cell_color_texture_rect)
	textinfo.add_text_info("Cell Region")
	textinfo.add_text_info("Cell Position in Region")

func update_text_info():
	textinfo.update_text_info("FPS", Engine.get_frames_per_second())
	textinfo.update_text_info("Mouse Position", mouse_position)
	textinfo.update_text_info("Canvas Mouse Position", canvas_mouse_position)
	textinfo.update_text_info("Canvas Position", canvas_position)
	textinfo.update_text_info("Cell Position", cell_mouse_position)
	var cell_color_text = cell_color
	if paint_canvas_node.mouse_in_region and paint_canvas_container_node.mouse_on_top:
		if Input.is_mouse_button_pressed(BUTTON_LEFT) or Input.is_mouse_button_pressed(BUTTON_RIGHT):
			if paint_canvas_node.last_pixel.size() > 0:
				cell_color_text = paint_canvas_node.last_pixel[2]
	if cell_color_text == null:
		cell_color_text = Color(0, 0, 0, 0)
	textinfo.update_text_info("Cell Color", cell_color_text, "Cell Color", "color", cell_color_text)
	textinfo.update_text_info("Cell Region", cell_region_position)
	textinfo.update_text_info("Cell Position in Region", cell_position_in_region)

func _on_PaintTool_pressed():
	brush_mode = "paint"

func _on_BucketTool_pressed():
	brush_mode = "bucket"

func _on_ColorPicker_color_changed(color):
	selected_color = color

func _on_Save_pressed():
	get_node("SaveFileDialog").show()

func _on_RainbowTool_pressed():
	brush_mode = "rainbow"