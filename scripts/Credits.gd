extends TextureRect
var scene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
# Called when the node enters the scene tree for the first time.
func _ready():
	var vconf = ConfigFile.new()
	vconf.set_value("saves", "game_pass", "true")
	vconf.save(str(documents) + "/Pixel Zone/.data/settings/game.ini")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'credits':
		scene = get_tree().change_scene("res://scenes/Main Menu/GUI.tscn")
