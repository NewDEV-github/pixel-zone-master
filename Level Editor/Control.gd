extends Control

# Declare member variables here. Examples:
onready var root = $"Editor's Scene"
var node 
var mode = 'play'
var number
var is_checked: bool
var save_dir = 'user://saved_levels/'
const SPEED = 100
var selected_file
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if str($PopupPanel/LineEdit.text) == '':
#		$PopupPanel/SAVE_BUTTON.set_disabled(false)
	var objects = str(float(get_tree().get_node_count()) - 8)
#	$Panel/VBoxContainer/Label.set_text('OBJECTS CONUT: '+str(objects) + '\n' +str(mode))
	number = str(delta * SPEED)
	if mode == 'edit':
		var position_l = get_global_mouse_position()
		node.set_position(position_l)
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if mode == 'play':
			mode = 'edit'
			$Panel.hide()
		elif mode == 'edit':
			mode = 'play'
			$Panel.show()

func _on_TextureButton_pressed():
	$SetCurrentTile.show()

func _on_Button_pressed():
	$PopupPanel.popup_centered()
#	
	
func _on_Button2_pressed():
	$PopupPanel/FileDialog.popup_centered()
	$PopupPanel/SAVE_BUTTON.set_disabled(false)

func _on_FileDialog_file_selected(path):
	selected_file = str(path)
	$PopupPanel/LineEdit.set_text(selected_file)

func _on_SAVE_BUTTON_pressed():
	var packed_scene = PackedScene.new()
	$"Editor's Scene".set_script(load('res://Level Editor/level_script.gd'))
	packed_scene.pack($"Editor's Scene")
	ResourceSaver.save(str(save_dir + $PopupPanel/LineEdit.text + '.tscn'), packed_scene)
	$PopupPanel.hide()


func _on_Select_Background_pressed():
	$PopupPanel2.popup_centered()


func _on_ItemList_item_selected(index):
	var selected_bg
	if index == 0:
		selected_bg = preload('res://scenes/parallax_bg2.tscn').instance()
	if index == 1:
		selected_bg = preload('res://scenes/parallax_bg4.tscn').instance()
	if index == 2:
		selected_bg = preload('res://scenes/parallax_bg.tscn').instance()
	if index == 3:
		selected_bg = preload('res://scenes/parllax_bg_3.tscn').instance()
	if index == 4:
		selected_bg = preload('res://scenes/parllax_bg_4.tscn').instance()
	if index == 5:
		selected_bg = preload('res://scenes/parllax_bg_5.tscn').instance()
	if index == 6:
		selected_bg = preload('res://scenes/parllax_bg_6.tscn').instance()
	root.add_child(selected_bg)
	selected_bg.set_owner(root)
	$PopupPanel2.hide()
	$"Panel/VBoxContainer2/Select Background2".set_disabled(true)
	
	
	


func _on_icon3_pressed():
	node = preload("res://scenes/coin.tscn").instance()
	node.set_name('coin' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))


func _on_MusicList_item_selected(index):
	var audio = preload('res://Level Editor/audio.tscn').instance()
	if not root.has_node('AUDIO'):
		root.add_child(audio)
		audio.set_owner(root)
		audio.set_name('AUDIO')
	var music_to_play
	if index == 0:
		music_to_play = load('res://sounds/music.ogg')
	if index == 1:
		music_to_play = load('res://sounds/Ice_Cap_Adventure.ogg')
	if index == 2:
		music_to_play = load('res://sounds/brazil-fast.ogg')
	if index == 3:
		music_to_play = load('res://sounds/jungle_ruins.ogg')
	if index == 4:
		music_to_play = load('res://sounds/hill.ogg')
	if index == 5:
		music_to_play = load('res://sounds/sci-fi.ogg')
	if index == 6:
		music_to_play = load('res://sounds/Castlemania.ogg')
	audio.set_stream(music_to_play)


func _on_Select_Music_pressed():
	$PopupPanel3.popup_centered()

###selecing tiles

func _on_Tile1_icecapzone_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile1.tscn").instance()
	node.set_name('tile1_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone2_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile2.tscn").instance()
	node.set_name('tile2_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone3_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile3.tscn").instance()
	node.set_name('tile3_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone4_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile4.tscn").instance()
	node.set_name('tile4_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone5_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile5.tscn").instance()
	node.set_name('tile5_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone6_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile6.tscn").instance()
	node.set_name('tile6_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone7_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile7.tscn").instance()
	node.set_name('tile7_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone8_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile8.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()
