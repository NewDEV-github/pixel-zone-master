extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var permissions = null
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
onready var editor = load(str(documents) +'/Pixel Zone/.data/Level Editor/Editor.tscn')
# Called when the node enters the scene tree for the first time.
func _ready():
	background_load.load_scene("res://scenes/Main Menu/GUI.tscn")
	if OS.get_name() == 'Android':
		OS.alert('Permissions!', "We need permittions to save game data on your device. Allow it in Application's settings. Thanks!")
