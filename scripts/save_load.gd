extends Node
func _on_Save():
	print("Saving Game...")
	var save_game = File.new()
	save_game.open("user://saved.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var save_dict = {
			"filename" : get_filename(),
			"parent" : get_parent().get_path(),
		}
		return
	save_game.close()
func _on_Load():
	print("Loading Game...")
	var load_game = File.new()
	if not load_game.file_exists("user://saved.save"):
		return # Error! We don't have a save to load.
	var load_nodes = get_tree()
	for i in load_nodes:
		i.queue_free()
	load_game.open("user://saved.save", File.READ)
	while load_game.eof_reached():
		var current_line = parse_json(load_game.get_line())
		var new_object = load(current_line["filename"]).instance()
		get_node(current_line["parent"]).add_child(new_object)
		new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"])
		for i in current_line.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, current_line[i])
	load_game.close()
