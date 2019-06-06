extends Node

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/stages/hill/hill_2.tscn")
func _ready():
	var a = File.new()
	a.open("user://9.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		a.store_line(to_json(node_data))
	a.close()

func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/GameOver.tscn")
