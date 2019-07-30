extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'd"toxic3"elta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_toxic_body_entered(body):
	if body.name == 'Player':
		get_tree().change_scene("res://scenes/GameOver.tscn")


func _on_Area2D2_body_entered(body):
	if body.name == 'Player':
		get_tree().change_scene("res://scenes/stages/scifi/sci_fi_3.tscn")
		File.new().open("user://13.save", File.WRITE)

