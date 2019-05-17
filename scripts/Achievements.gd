extends Panel
func _on_Button_pressed():
    hide()
func _process(delta):
	print(OS.get_name())
	var a = OS.get_executable_path()
	var b = File.new()
	b.open("user://data1.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Save")
	for i in save_nodes:
		var node_data = i.call("save");
		b.store_line(to_json(node_data))
	b.close()



