extends Node
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var scene_path = ''
var collected = 0 setget _set_collected, _get_collected
var to_collect = 0
var player
var auto_load_mod = true
signal collected_changed
signal play_bgm(id, value)
var player_has_been_selected = false
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
func _ready():
	var beta_2 = File.new()
	beta_2.open(str(documents)+ "/Pixel Zone/.data/settings/advanced.save", File.READ)
	var load_set = beta_2.get_line()
	if load_set == 'True':
		auto_load_mod = true
	if load_set == 'False':
		auto_load_mod = false
