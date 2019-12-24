tool
extends EditorPlugin

const version = "0.4.2"

func _enter_tree():
	add_autoload_singleton("SilentWolf", "res://addons/silent_wolf/SilentWolf.gd")

func _exit_tree():
	remove_autoload_singleton("SilentWolf")
