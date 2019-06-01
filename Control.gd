extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	print_log()
func print_log():
	print(OS.get_name())
	var a = OS.get_executable_path()
	var b = File.new()
	b.open("user://logs/"+ str(OS.get_unix_time()) + ".log", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		b.store_line(to_json(node_data))
	b.close()
func error():
	print_log()
	OS.alert("There has been an error. \n Log file was created at:\n" + str(OS.get_user_data_dir()) +"/" + str(OS.get_unix_time())+".log\nPlease attach it to any bug report\n\nContact support at https://karoltomaszewskimu.wixsite.com/mastergames/support")

func _on_Timer_timeout():
	print_log()
	$Timer.start()

#func _on_AcceptDialog_confirmed():
#	get_tree().quit()
#
#func _on_AcceptDialog_popup_hide():
#	get_tree().quit()
#func _on_AcceptDialog_about_to_show():
#	$AcceptDialog/Label2.set_text(str(OS.get_user_data_dir()) + "/" + str(OS.get_unix_time()) + ".log")