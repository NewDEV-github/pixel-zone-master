extends Control

var img_path
var sprite = preload("res://Level Editor/Sprite.tscn").instance()
var coll = preload("res://Level Editor/tile_polygon.tscn").instance()
var has_selected_image = false
var has_name = false
var has_collision_polygon = false
onready var root = $Panel/HBoxContainer/Left/CenterContainer/Control/Tile

func _on_FileDialog_file_selected(path):
	sprite.load_img(path)
	root.add_child(sprite)
	sprite.set_owner(root)
	img_path = path
func _on_Open_pressed():
	$Panel/FileDialog.popup_centered()
#SAVING IMAGE DATA
func _on_Button_pressed():
	$Panel/HBoxContainer/Left/CenterContainer/Control/Tile.name_ = $Panel/HBoxContainer/Right/HBoxContainer4/name.text
	$Panel/HBoxContainer/Left/CenterContainer/Control/Tile.img_path = img_path
	coll.hide_colour()
	$Panel/HBoxContainer/Left/CenterContainer/Control/Tile.save()
	coll.show_colour()

func _on_Polygon_pressed():
	root.add_child(coll)
	coll.set_owner(root)
	coll.set_position(Vector2(0,0))
	coll.show_colour()


func _on_HSlider2_value_changed(value):
	coll.set_scale(Vector2(value, value))


func _on_HSlider_value_changed(value):
	sprite.set_scale(Vector2(value, value))


func _on_Back_pressed():
	background_load.load_scene('res://Level Editor/Editor.tscn')
