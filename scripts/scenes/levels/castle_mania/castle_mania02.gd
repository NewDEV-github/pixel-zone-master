extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var a = File.new()
	a.open_encrypted_with_pass("user://save_data.1", File.WRITE, str(34567865))
	a.store_line("16")
	a.close()
	a.open_encrypted_with_pass("user://save_data.2", File.WRITE, str(34567865))
	a.store_line("16")
	a.close()


func _on_Area2D2_body_entered(body):
	get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_Area2D5_body_entered(body):
	get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_Area2D8_body_entered(body):
	get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://scenes/GameOver.tscn")
