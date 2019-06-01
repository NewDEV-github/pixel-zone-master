extends Node
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		
		get_tree().change_scene("res://scenes/stages/pixel_adventure/stage.tscn")
		var exists = File.new()
		exists.open(str(OS.get_executable_path() + ".tut.data0"), File.WRITE)