extends Node
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/stages/pixel_adventure/stage.tscn")
func _ready():
	var a = File.new()
	a.open(str(documents) + "/Pixel Zone/.data/data1.data", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		a.store_line(to_json(node_data))
	a.close()