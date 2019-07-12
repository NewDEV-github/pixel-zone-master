extends Control

func _on_Hide_pressed():
	hide()
	
func save():
    var save_dict = {
        "filename" : get_filename(),
        "parent" : get_parent().get_path(),
		"pos_x" : get_position().x,
		"pos_y" : get_position().y,
    }
    return save_dict
