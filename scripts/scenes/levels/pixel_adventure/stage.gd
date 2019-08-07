extends Node
func _ready():
	var a = File.new()
	a.open_encrypted_with_pass("user://save_data.1", File.WRITE, str(34567865))
	a.store_line("1")
	a.close()
	a.open_encrypted_with_pass("user://save_data.2", File.WRITE, str(34567865))
	a.store_line("1")
	a.close()

func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("scenes/GameOver.tscn")
func save():
    var save_dict = {
        "filename" : get_filename(),
        "parent" : get_parent().get_path(),
		"pos_x" : get_position().x,
		"pos_y" : get_position().y,
    }
    return save_dict


func _on_nextlevel_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("scenes/stages/pixel_adventure/stage2.tscn")
	
