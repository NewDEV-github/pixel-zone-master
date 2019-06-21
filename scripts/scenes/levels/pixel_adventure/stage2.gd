extends Node
signal achieve1
func _ready():
	var a = File.new()
	a.open("user://2.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		a.store_line(to_json(node_data))
	a.close()
	var dlc = File.new()



func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("scenes/GameOver.tscn")

func _on_nextlevel_body_entered(body):
	if body.name =="Player":
		get_tree().change_scene("res://scenes/stages/ice_cap_adventure/ice_01.tscn")


func _on_Area2D_body_entered(body):
   if body.name == "Player":
    emit_signal("achieve1")
