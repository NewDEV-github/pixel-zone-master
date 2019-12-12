tool
extends EditorPlugin

var editor_scene = load("res://addons/graphics_editor/Editor.tscn").instance()

func _enter_tree():
	add_control_to_bottom_panel(editor_scene, "Graphics Editor")

func _exit_tree():
	remove_control_from_bottom_panel(editor_scene)