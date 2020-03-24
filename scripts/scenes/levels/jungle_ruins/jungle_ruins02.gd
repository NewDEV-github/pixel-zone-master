extends Node2D

var scene
var player_default = globals.selected_player
func _ready():
	add_child(Object(player_default))
	globals._set_player_pos(0,0)
	player_default.restart_position()
	globals.on_scene_changed()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		remove_child(player_default)
		game_state._update_data()
		scene = get_tree().change_scene("res://scenes/stages/jungle_ruins/jungle_ruins03.tscn")


func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		remove_child(player_default)
		scene = get_tree().change_scene("scenes/GameOver.tscn")


func _on_Area2D3_body_entered(body):
	if body.name == "Player":
		$Light2D.set_visible(false)


func _on_Area2D3_body_exited(body):
	if body.name == "Player":
		$Light2D.set_visible(true)

func _process(_delta):
	var unlock = File.new()
	unlock.open('user://sav.s7', File.WRITE)
	unlock.close()
	set_process(false)
