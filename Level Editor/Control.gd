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
var x = 4
var scale_x = 1
var scale_y = 1
var y = 4
var heigth_width = 100000000
var locked = false
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
		var position_l = get_global_mouse_position().snapped(Vector2(x,y))
		var snap_grid_x = round(position_l.x)
		var snap_grid_y = round(position_l.y)
		$Label.set_text("POSITION: " + str(position_l))
		node.set_position(Vector2(snap_grid_x, snap_grid_y))
		print(str(node.position))
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if mode == 'play'and locked == false:
			mode = 'edit'
			$Panel.hide()
			$Label.show()
		elif mode == 'edit' and locked == false:
				mode = 'play'
				$Panel.show()
				$Label.hide()

func _on_TextureButton_pressed():
	$SetCurrentTile.show()

func _on_Button_pressed():
	locked == true
	$PopupPanel.popup_centered()
#	
	
func _on_Button2_pressed():
	$PopupPanel/FileDialog.popup_centered()
	$PopupPanel/SAVE_BUTTON.set_disabled(false)

func _on_FileDialog_file_selected(path):
	selected_file = str(path)
	$PopupPanel/LineEdit.set_text(selected_file)

func _on_SAVE_BUTTON_pressed():
	locked = false
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
	
	
func _on_LineEdit_text_entered(new_text):
	scale_x = float(str(new_text))
	node.set_scale(Vector2(scale_x, scale_y))

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


func _on_Tile1_hill_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile1.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill2_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile2.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill3_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile3.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill4_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile4.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()

func _on_Tile1_hill5_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile5.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()

func _on_Tile1_hill6_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile6.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill7_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile7.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill8_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile8.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill9_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile9.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill10_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile10.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill11_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile11.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill12_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile12.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill13_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile13.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill14_pressed():
	node = preload('res://Level Editor/tiles/Hill/tile14.tscn').instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill15_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile15.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill16_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile16.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill17_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile17.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile1_hill18_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile18.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()

func _on_Tile1_hill19_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile19.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()
	


func _on_Tile1_hill20_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile20.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


###ANOTHER GUI OPTIONS
func _on_PopupPanel_popup_hide():
	locked = false



func _on_Scalex_text_changed(new_text):
	scale_x = float(str(new_text))
	node.set_scale(Vector2(scale_x, scale_y))


func _on_Scalex_text_entered(new_text):
	scale_x = float(str(new_text))
	node.set_scale(Vector2(scale_x, scale_y))


func _on_Scaley_text_entered(new_text):
	scale_y = float(str(new_text))
	node.set_scale(Vector2(scale_x, scale_y))


func _on_Scaley_text_changed(new_text):
	scale_y = float(str(new_text))
	node.set_scale(Vector2(scale_x, scale_y))


func _on_Snappingx_text_changed(new_text):
	x = float(new_text)


func _on_Snappingx_text_entered(new_text):
	x = float(new_text)


func _on_Snappingy_text_changed(new_text):
	y = float(new_text)


func _on_Snappingy_text_entered(new_text):
	y = float(new_text)
### selecting tiles - continuation

func _on_Tile2_pa_1_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile1.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_2_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile2.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_3_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile3.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_4_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile4.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_5_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile5.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_6_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile6.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_7_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile7.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_8_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile8.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()

func _on_Tile2_pa_9_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile9.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_10_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile10.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_11_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile11.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_12_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile12.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_13_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile13.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_14_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile14.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_15_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile15.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_16_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile16.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_17_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile17.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_18_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile18.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_19_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile19.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile2_pa_20_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile20.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_1_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile1.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_2_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile2.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_3_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile3.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()

func _on_Tile3_jg_4_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile4.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_5_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile5.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_6_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile6.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_7_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile7.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_8_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile8.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_9_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile9.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_10_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile10.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_11_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile11.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_12_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile12.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_Tile3_jg_13_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile13.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()

###gui options
func _on_BACK_pressed():
	background_load.load_scene('res://scenes/Main Menu/GUI.tscn')
### selecting tiles - cotinued
