extends Node2D
func _ready():
	var a = File.new()
	a.open_encrypted_with_pass("user://save_data.1", File.WRITE, str(34567865))
	a.store_line("8")
	a.close()
	a.open_encrypted_with_pass("user://save_data.2", File.WRITE, str(34567865))
	a.store_line("8")
	a.close()
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://scenes/stages/hill/hill_1.tscn")
func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("scenes/GameOver.tscn")


func _on_Area2D3_body_entered(body):
	if body.name == "Player":
		$Player/Light2D.set_visible(false)


func _on_Area2D3_body_exited(body):
	if body.name == "Player":
		$Player/Light2D.set_visible(true)
