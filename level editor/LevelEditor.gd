extends Control
var mode = null
var new_name = null
onready var x = float(str($Panel/heigth.text))
onready var y = float(str($Panel/weigth.text))
onready var root = $Control
onready var sprite_path = NodePath(str($Control/Sprite))
onready var sprite = preload("res://level editor/tile1_for_level_editor.tscn").instance()
func _ready():
	mode = 'select'
func _on_Button_pressed():
	root.add_child(sprite)
	sprite.set_owner(root)
	###experimental
	if root.has_node(sprite_path):
		new_name += 1
		sprite.set_name(str(new_name))
		root.add_child(sprite)
		sprite.set_owner(root)
		
	###not experimental
	mode = 'edit'
	$Panel/Button.set_enabled_focus_mode(Control.FOCUS_NONE)
	$Panel/Button.set_focus_mode(Control.FOCUS_NONE)
#	sprite.set_position(Vector2(100, 100))
	
func _process(delta):
	print(mode)
	if mode == 'edit':
		sprite.set_position(get_global_mouse_position())
		
func _input(event):
	if event.is_action_pressed("ui_accept"):
		mode = 'select'
		sprite.set_position(get_global_mouse_position())
func _on_Button2_pressed():
	var level = PackedScene.new()
	var save_level = File.new()
	save_level.open("res://save.tscn", File.WRITE)
	level.get_local_scene()
	save_level.store_line(str(level))

