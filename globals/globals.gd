extends Node
var scene_path = ''
var collected = 0 setget _set_collected, _get_collected
var to_collect = 0
var player

signal collected_changed
signal play_bgm(id, value)

func _set_collected(value):
	collected = value
	emit_signal("collected_changed")

func _get_collected():
	return collected

func play_bgm(id, value):
	emit_signal("play_bgm", id, value)

var dlc_name = ""
var selected_player = ''
func _set_player_pos(x, y):
	selected_player.set_position(Vector2(x, y))

func _get_player_pos_x():
	var position_p = selected_player.position.x
	return position_p

func _get_player_pos_y():
	var position_p = selected_player.position.y
	return position_p
func _save():
	var a = File.new()
	a.open("user://save_data.3", File.WRITE) #str(34567865))
	a.store_string(str('preload('+scene_path+').instance()'))
	a.close()

func _ready():
	var a = File.new()
	a.open("user://save_data.3", File.READ)# str(34567865))
	var file = a.get_line()
	selected_player = str(file)
#func _process(delta):
#	print(str(selected_player))
