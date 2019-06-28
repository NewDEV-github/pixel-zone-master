extends Control
onready var x = float(str($heigth.text))
onready var y = float(str($weigth.text))
onready var root = $Control
onready var sprite = preload("res://tile1_for_level_editor.tscn").instance()
func _on_Button_pressed():
	root.add_child(sprite)
	sprite.set_owner(root)
	sprite.set_position(Vector2(x, y))
	

func _on_Button2_pressed():
	var level = PackedScene.new()
	var save_level = File.new()
	save_level.open("res://save.tscn", File.WRITE)
	level.pack($Control)
	save_level.store_line(str(level))
