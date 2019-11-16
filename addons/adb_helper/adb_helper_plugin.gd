tool
extends EditorPlugin

#Load the plugin button
var adb_helper

func _enter_tree():
	
	#Make a new helper
	adb_helper = preload("./adb_helper.tscn").instance()
	adb_helper.settings = get_editor_interface().get_editor_settings()
	
	#Add the helper to the tree
	add_control_to_container(CONTAINER_TOOLBAR, adb_helper)

func _exit_tree():
	
	#Kill the dock
	remove_control_from_container(CONTAINER_TOOLBAR, adb_helper)
	
	#Clear memory
	adb_helper.free()
