extends Control

# Declare member variables here. Examples:
onready var root = $"Editor's Scene"
var node 
var mode = 'play'
var number
const SPEED = 100
var selected_file
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var objects = str(float(get_tree().get_node_count()) - 8)
	$Panel/VBoxContainer/Label.set_text('OBJECTS CONUT: '+str(objects) + '\n' +str(mode))
	number = str(delta * SPEED)
	if mode == 'edit':
		var position_l = get_local_mouse_position()
		node.set_position(position_l)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if mode == 'play':
			mode = 'edit'
		elif mode == 'edit':
			mode = 'play'

func _on_TextureButton_pressed():
	node = preload("res://Level Editor/tiles/icon.tscn").instance()
	node.set_name('icon' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))

func _on_Button_pressed():
	$PopupPanel.popup_centered()
#	

func _on_TextureButton2_pressed():
	node = preload("res://Level Editor/tiles/icon2.tscn").instance()
	node.set_name('icon2' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	
func _on_Button2_pressed():
	$PopupPanel/FileDialog.popup_centered()
	$PopupPanel/SAVE_BUTTON.set_disabled(false)

func _on_FileDialog_file_selected(path):
	selected_file = str(path)
	$PopupPanel/LineEdit.set_text(selected_file)

func _on_SAVE_BUTTON_pressed():
	var packed_scene = PackedScene.new()
	packed_scene.pack($"Editor's Scene")
	ResourceSaver.save(str(selected_file), packed_scene)
