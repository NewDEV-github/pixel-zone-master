extends Node
var scene
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var a = File.new()
		a.open(str(documents) + "/Pixel Zone/.data/tut.save", File.WRITE)
		var data = "54 72 75 65"
		a.store_line(to_json(data))
		a.close()
		scene = get_tree().change_scene("res://scenes/stages/pixel_adventure/stage.tscn")
func _ready():
	var a = File.new()
	a.open(str(documents) + "/Pixel Zone/.data/tut.save", File.WRITE)
	var data = "46 61 6c 73 65"
	a.store_line(to_json(data))
	a.close()
