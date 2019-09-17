extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_default = globals.selected_player
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(Object(player_default))
	globals._set_player_pos(0,0)
