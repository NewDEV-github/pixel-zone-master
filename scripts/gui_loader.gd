extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
# Called when the node enters the scene tree for the first time.
func _ready():
	background_load.load_scene("res://scenes/Main Menu/GUI.tscn")
