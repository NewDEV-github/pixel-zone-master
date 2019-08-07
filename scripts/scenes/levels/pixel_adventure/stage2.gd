extends Node
signal achieve1
func _ready():
	var a = File.new()
	a.open_encrypted_with_pass("user://save_data.1", File.WRITE, str(34567865))
	a.store_line("2")
	a.close()
	a.open_encrypted_with_pass("user://save_data.2", File.WRITE, str(34567865))
	a.store_line("2")
	a.close()



func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("scenes/GameOver.tscn")

func _on_nextlevel_body_entered(body):
	if body.name =="Player":
		get_tree().change_scene("res://scenes/stages/ice_cap_adventure/ice_01.tscn")


func _on_Area2D_body_entered(body):
   if body.name == "Player":
    emit_signal("achieve1")
