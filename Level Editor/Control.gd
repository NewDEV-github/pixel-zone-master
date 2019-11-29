extends Control
var tile_path = ''
var position_x = 0
var position_y = 0
var timeout
var collision = CollisionPolygon2D.new()
var collision_ = false
var rotation = 1
onready var root = $"Editor's Scene"
var node
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var file_name
var fil_name
var extension
var file_path
var mode = 'play'
var number
var checked = false
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
	$TextEdit.add_keyword_color("load", Color.red)
	$TextEdit.add_keyword_color("preload", Color.red)
	$TextEdit.add_keyword_color("setget", Color.red)
	$TextEdit.add_keyword_color("match", Color.red)
	$TextEdit.add_keyword_color("extends", Color.red)
	$TextEdit.add_keyword_color("func", Color.red)
	$TextEdit.add_keyword_color("var", Color.red)
	$TextEdit.add_keyword_color("while", Color.red)
	$TextEdit.add_keyword_color("if", Color.red)
	$TextEdit.add_keyword_color("and", Color.red)
	$TextEdit.add_keyword_color("or", Color.red)
	$TextEdit.add_keyword_color("not", Color.red)
	$TextEdit.add_keyword_color("const", Color.red)
	$TextEdit.add_keyword_color("false", Color.red)
	$TextEdit.add_keyword_color("true", Color.red)
	$TextEdit.add_keyword_color("str", Color.red)
	$TextEdit.add_keyword_color("float", Color.red)
	$TextEdit.add_keyword_color("round", Color.red)
	$TextEdit.add_keyword_color("elif", Color.red)
	$TextEdit.add_keyword_color("else", Color.red)
	$TextEdit.add_keyword_color("print", Color.red)
	$TextEdit.add_keyword_color("Object", Color.lightgreen)
	$TextEdit.add_keyword_color("Control", Color.lightgreen)
	$TextEdit.add_color_region('#', '', Color.darkgray)
	$TextEdit.add_color_region(str("'"), str("'"), Color.yellow)
	$TextEdit.add_color_region(str('"'), str('"'), Color.yellow)
	$TextEdit.add_color_region(str('$'), str(' '), Color.green)
	$TextEdit.add_color_region(str('$'), str('.'), Color.green)
	$TextEdit.text = 'extends Control\nvar player_default = globals.selected_player\nfunc _ready():\n	set_position(Vector2(0,0))\n	add_child(Object(player_default))\n	globals._set_player_pos(0,0)\n#	You cannot edit this because the level will not load and the game will freeze'
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Editor's Scene".set_position(Vector2(position_x, position_y))
	if $PopupPanel.visible == false:
		locked = false
	if $PopupPanel2.visible == true:
		locked = false
	if $PopupPanel3.visible == false:
		locked = false
	if $PopupPanel4.visible == false:
		locked = false
	if $OptionPanel.visible == false:
		locked = false
	if $SetCurrentTile.visible == false:
		locked = false
	if $PopupPanel.visible == true:
		locked = true
	if $PopupPanel2.visible == true:
		locked = true
	if $PopupPanel3.visible == true:
		locked = true
	if $PopupPanel4.visible == true:
		locked = true
	if $OptionPanel.visible == true:
		locked = true
	if $SetCurrentTile.visible == true:
		locked = true
	number = str(delta * SPEED)
	if mode == 'edit':
		var mouse_position = get_local_mouse_position()
		var position_l = get_local_mouse_position().snapped(Vector2(x,y))
		var snap_grid_x = round(position_l.x)
		var snap_grid_y = round(position_l.y)
		$Label.set_text(str(position_l))
		node.set_position(Vector2(snap_grid_x - position_x, snap_grid_y - position_y)) 
		if Input.is_action_pressed("rotate"):
			if Input.is_action_pressed("ui_left"):
				node.rect_rotation += float(rotation)
			elif Input.is_action_pressed("ui_right"):
				node.rect_rotation -= float(rotation)
func _input(event):
	if event.is_action_pressed("ui_accept") and $TextEdit.visible == false:
		if mode == 'play'and locked == false:
			mode = 'edit'
			$Panel.hide()
			$Label.show()
			$Panel2.hide()
			$VSlider.show()
			$HSlider.show()
		elif mode == 'edit' and locked == false:
				mode = 'play'
				$Panel2.show()
				$Panel.show()
				$Label.hide()
				$HSlider.hide()
				$VSlider.hide()
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
	var script = str(save_dir + $PopupPanel/LineEdit.text + '.gd')
	#SAVING SCENE
	locked = false
	var packed_scene = PackedScene.new()
	$"Editor's Scene".set_script(load(str(script)))
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
	
	
func _on_LineEdit_text_entered(new_text):
	scale_x = float(str(new_text))
	node.set_scale(Vector2(scale_x, scale_y))

func _on_icon3_pressed():
	node = preload("res://scenes/coin.tscn").instance()
	node.set_name('coin' + str(number))
	root.add_child(node)
	node.set_owner(root)



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
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone2_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile2.tscn").instance()
	node.set_name('tile2_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone3_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile3.tscn").instance()
	node.set_name('tile3_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone4_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile4.tscn").instance()
	node.set_name('tile4_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone5_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile5.tscn").instance()
	node.set_name('tile5_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone6_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile6.tscn").instance()
	node.set_name('tile6_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_icecapzone7_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile7.tscn").instance()
	node.set_name('tile7_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)

	$SetCurrentTile.hide()


func _on_Tile1_icecapzone8_pressed():
	node = preload("res://Level Editor/tiles/IceCapZone/tile8.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile1.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill2_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile2.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)	
	$SetCurrentTile.hide()


func _on_Tile1_hill3_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile3.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill4_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile4.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()

func _on_Tile1_hill5_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile5.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()

func _on_Tile1_hill6_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile6.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill7_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile7.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill8_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile8.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill9_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile9.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill10_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile10.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill11_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile11.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill12_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile12.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill13_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile13.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill14_pressed():
	node = preload('res://Level Editor/tiles/Hill/tile14.tscn').instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill15_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile15.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill16_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile16.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill17_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile17.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile1_hill18_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile18.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()

func _on_Tile1_hill19_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile19.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()
	


func _on_Tile1_hill20_pressed():
	node = preload("res://Level Editor/tiles/Hill/tile20.tscn").instance()
	node.set_name('tile8_icecap' + str(number))
	root.add_child(node)
	node.set_owner(root)
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
	$SetCurrentTile.hide()


func _on_Tile2_pa_2_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile2.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_3_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile3.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_4_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile4.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_5_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile5.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_6_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile6.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_7_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile7.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_8_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile8.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()

func _on_Tile2_pa_9_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile9.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_10_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile10.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_11_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile11.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_12_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile12.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_13_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile13.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_14_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile14.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_15_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile15.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_16_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile16.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_17_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile17.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_18_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile18.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_19_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile19.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile2_pa_20_pressed():
	node = preload("res://Level Editor/tiles/PixelAdventure/tile20.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_1_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile1.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_2_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile2.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_3_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile3.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()

func _on_Tile3_jg_4_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile4.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	$SetCurrentTile.hide()


func _on_Tile3_jg_5_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile5.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_6_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile6.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_7_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile7.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_8_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile8.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_9_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile9.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_10_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile10.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_11_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile11.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_12_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile12.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile3_jg_13_pressed():
	node = preload("res://Level Editor/tiles/JungleRuins/tile13.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()

###gui options
func _on_BACK_pressed():
	background_load.load_scene('res://scenes/Main Menu/GUI.tscn')


func _on_RotiationDegree_text_changed(new_text):
	rotation = float(str(new_text))


func _on_RotiationDegree_text_entered(new_text):
	rotation = float(str(new_text))


func _on_OPTIONS_pressed():
	if locked == false:
		$OptionPanel.popup_centered()


func _on_EDITOR_pressed():
	if locked == false:
		$TextEdit.hide()


func _on_Script_pressed():
	if locked == false:
		$TextEdit.show()


func _on_FILE_pressed():
	if locked == false:
		$PopupPanel.popup_centered()


func _on_ADD_pressed():
	if locked == false:
		$PopupPanel4.popup_centered()


func _on_collision_pressed():
	if locked == false:
		$PopupPanel5.popup_centered()

func _on_10x10_pressed():
	node = preload("res://Level Editor/collisonbox10x10.tscn").instance()
	node.set_name('collision_10x10' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()
#	$PopupPanel5.hide()


func _on_40x40_pressed():
	node = preload("res://Level Editor/collisonbox40x40.tscn").instance()
	node.set_name('collision_40x40' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()


func _on_FAQ_pressed():
	OS.shell_open('https://masterpolska123.github.io/home/faq/#leveleditor')


func _on_Timer_timeout():
	if $PopupPanel/LineEdit.text != '':
		var text = $TextEdit.text
		var file = File.new()
		file.open(str(save_dir + $PopupPanel/LineEdit.text + '.gd'), File.WRITE)
		file.store_line(str(text))
### SELECTING TILES - Last part

func _on_Tile4_scifi_1_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile1.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_2_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile2.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_3_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile3.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_4_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile4.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_5_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile5.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_6_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile6.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_7_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile7.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_8_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile8.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_9_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile9.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_10_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile10.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_11_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile11.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_12_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile12.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_13_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile13.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_14_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile14.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_15_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile15.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_16_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile16.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_17_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile17.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_18_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile18.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()

func _on_Tile4_scifi_19_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile19.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_20_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile20.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_21_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile21.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_22_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile22.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_23_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile23.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_24_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile24.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_25_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile25.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile4_scifi_26_pressed():
	node = preload("res://Level Editor/tiles/Scifi/tile26.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_1_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile1.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_2_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile2.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_3_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile3.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_4_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile4.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_5_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile5.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_6_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile6.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_7_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile7.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_8_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile8.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_9_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile9.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_10_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile10.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_11_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile11.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_12_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile12.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_13_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile13.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_14_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile14.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_15_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile15.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_16_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile16.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_17_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile17.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_18_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile18.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_19_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile19.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_20_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile20.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_21_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile21.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_22_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile22.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_23_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile23.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_24_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile24.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_25_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile25.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_26_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile26.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()

func _on_Tile5_cs_27_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile27.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_28_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile28.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_29_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile29.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_30_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile30.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_31_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile31.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()


func _on_Tile5_cs_32_pressed():
	node = preload("res://Level Editor/tiles/CastleMania/tile32.tscn").instance()
	node.set_name('tile_pa' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$SetCurrentTile.hide()
### GUI OPTIONS - CONTINUED

func _on_Polygon_pressed():
	node = preload("res://Level Editor/collision_polygon10x10.tscn").instance()
	node.set_name('polygon_10x10' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()
	$PopupPanel5.hide()


func _on_Polygon40x40_pressed():
	node = preload("res://Level Editor/collision_polygon40x40.tscn").instance()
	node.set_name('polygon_40x40' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
	$SetCurrentTile.hide()
	$PopupPanel5.hide()

#
#func _on_ImportCustomtile_pressed():
#	var path = 'user://Tiles/'
#	if checked == false:
#		var dir = Directory.new()
#		if dir.open(path) == OK:
#			dir.list_dir_begin()
#			print(str(dir.list_dir_begin()))
#			var file_name = dir.get_next()
#			while (file_name != ""):
#				if dir.current_is_dir():
#					print("Found directory: " + file_name)
#				else:
#					print("Found file: " + file_name)
#					var fil_name = str(file_name).get_basename()
#					var extension = str(file_name).get_extension()
#					var file_path = str(file_name).get_base_dir()
#					var tile_name = File.new()
#					tile_name.open(str(file_path) + 'name.txt', File.READ)
#					var tile_name_ = tile_name.get_as_text()
#					print(extension)
#					if extension == "tscn":
#						tile_path = str(file_path) + str(fil_name)
#						var texture_button = Button.new()
#						$SetCurrentTile/VBoxContainer3/HBoxContainer5.add_child(texture_button)
#						texture_button.set_owner($SetCurrentTile/VBoxContainer3/HBoxContainer5)
#						texture_button.set_text(str(tile_name_))
#						texture_button.connect("pressed", self, '_on_pressed')
#				file_name = dir.get_next()
#				checked = true
#func _on_pressed():
#	var _node = load(str(tile_path))
#	node = _node.instance()
#	node.set_name('polygon_10x10' + str(number))
#	root.add_child(node)
#	node.set_owner(root)
#	$SetCurrentTile.hide()


func _on_icon4_pressed():
	node = preload("res://scenes/enemy.tscn").instance()
	node.set_name('enemy' + str(number))
	root.add_child(node)
	node.set_owner(root)


func _on_VSlider_value_changed(value):
	position_y = value*-100


func _on_HSlider_value_changed(value):
	position_x = value*-10
