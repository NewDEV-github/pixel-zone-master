extends Control

var img_path
# Declare member variables here. Examples:
var kin = preload("res://Level Editor/KinematicBody2D.tscn").instance()
var sp = Sprite.new()
var ten
var fourty
var id_
var other_collisions
onready var root_static = $Panel/HBoxContainer/Left/CenterContainer/Tile/Tile
var has_selected_image = false
var has_name = false
var has_collision_polygon = false
onready var root = $Panel/HBoxContainer/Left/CenterContainer/Tile


func _on_FileDialog_file_selected(path):
	var img = Image.new()
	img.load(str(path))
	img_path = str(path)
	img.decompress()
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	sp.set_texture(tex)
	sp.set_name('Sprite')
	sp.set_owner(kin)
	kin.add_child(sp)
	has_selected_image = true
	$Panel/HBoxContainer/Right/HBoxContainer/LineEdit.set_text(str(path))
func _ready():
	root.add_child(kin)
	kin.set_owner(root)
	$Panel/HBoxContainer/Right/Label3.set_text('Add Collision')

func _on_Open_pressed():
	$Panel/FileDialog.popup_centered()
func _process(delta):
#	
	if not $Panel/HBoxContainer/Right/HBoxContainer4/name.text == '':
		has_name = false
	else:
		has_name = true
	$Panel/HBoxContainer/Right/HBoxContainer2/HSlider.editable = has_selected_image
	$Panel/HBoxContainer/Right/HBoxContainer2/SpinBox.editable = has_selected_image
#	$Panel/HBoxContainer/Right/HBoxContainer3/SpinBox.editable = has_collision_polygon
#	$Panel/HBoxContainer/Right/HBoxContainer3/HSlider2.editable = has_collision_polygon
	$Panel/HBoxContainer/Right/HBoxContainer4/Button.set_disabled(has_name)
	$Panel/HBoxContainer/Right/HBoxContainer2/HSlider.value = $Panel/HBoxContainer/Right/HBoxContainer2/SpinBox.value
	$Panel/HBoxContainer/Right/HBoxContainer3/HSlider2.value = $Panel/HBoxContainer/Right/HBoxContainer3/SpinBox.value
#	$Panel/HBoxContainer/Right/HBoxContainer2/SpinBox.value = $Panel/HBoxContainer/Right/HBoxContainer2/HSlider.value

func _on_HSlider_value_changed(value):
	sp.set_scale(Vector2(value, value))
	$Panel/HBoxContainer/Right/HBoxContainer2/SpinBox.value = value
	


func _on_Label3_item_selected(id):
	if other_collisions == 'fourty':
		fourty.queue_free()
	if other_collisions == 'ten':
		ten.queue_free()
	if id == 0:
		ten = preload('res://Level Editor/CollisionPolygon2D.tscn').instance()
		root_static.add_child(ten)
		ten.set_owner(root_static)
		ten.show_color()
		$Panel/HBoxContainer/Left/CenterContainer/Control/ReferenceRect.set_size(Vector2(10, 10))
		other_collisions = 'ten'
		has_collision_polygon = true
#	if id == 1:
#		fourty = preload('res://Level Editor/collision_polygon40x40.tscn').instance()
#		root.add_child(fourty)
#		fourty.set_owner(root)
#		fourty.show_color()
#		$Panel/HBoxContainer/Left/CenterContainer/Control/ReferenceRect.set_size(Vector2(40, 40))
#		other_collisions = 'fourty'
	id_ = str(id)
	has_collision_polygon = true

func _on_HSlider2_value_changed(value):
#	$Panel/HBoxContainer/Left/CenterContainer/Tile/Tile/CollisionShape2D.set_scale(Vector2(value, value))
	$Panel/HBoxContainer/Right/HBoxContainer3/SpinBox.value = value


func _on_Button_pressed():
	
	
	var val = $Panel/HBoxContainer/Right/HBoxContainer3/HSlider2.value
	kin.set_scale(Vector2(val, val))
#	$Panel/HBoxContainer/Left/CenterContainer/Tile/Tile/CollisionShape2D/ColorRect.hide()
	var save_dir = str(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)+ '/Pixel Zone/Custom Tiles/')
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save(str(save_dir + $Panel/HBoxContainer/Right/HBoxContainer4/name.text + '.tscn'), packed_scene)
	var dir = Directory.new()
#	$Panel/HBoxContainer/Left/CenterContainer/Tile/Tile/CollisionShape2D/ColorRect.show()
	dir.copy(str(img_path), str(save_dir + '/' + $Panel/HBoxContainer/Right/HBoxContainer4/name.text + '.png'))
