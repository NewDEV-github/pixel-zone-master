extends Node2D


func _ready():
	var a = File.new()
	a.open("user://6.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		a.store_line(to_json(node_data))
	a.close()
	var dlc = File.new()
	if dlc.file_exists("user://dlc_2/brazil-fast.ogg"):
		$AudioStreamPlayer2D.stop()
		$AudioStreamPlayer2D2.play()
	if not dlc.file_exists("user://dlc_2/brazil-fast.ogg"):
		$AudioStreamPlayer2D.play()
		$AudioStreamPlayer2D2.stop()
func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("user://dlc_1/jungle_ruins02_dlc1.tscn")


func _on_Area2D2_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("scenes/GameOver.tscn")
