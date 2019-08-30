extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
# Called when the node enters the scene tree for the first time.
func _ready():
	var update = File.new()
	var config = ConfigFile.new()
	if update.file_exists(str(documents) + "/Pixel Zone/.data/updates/update.pck"):
		ProjectSettings.load_resource_pack(str(documents) + "/Pixel Zone/.data/updates/update.pck")
		background_load.load_scene("res://updated_scenes/updated_GUI.tscn")
