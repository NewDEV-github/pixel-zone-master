extends Node
var timer = Timer.new()
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var scene_path
var collected = 0 setget _set_collected, _get_collected
var auto_load_mod = true
var current_stage = ''
var play_cutscenes
signal collected_changed
signal play_bgm(id, value)
func _set_collected(value):
	collected = value
	emit_signal("collected_changed")

func _get_collected():
	return collected

func _send_data():

	var playername = str(SilentWolf.Auth.logged_in_player)
	if not str(playername) == '':
		SilentWolf.Scores.persist_score(playername, game_state.points)
		SilentWolf.Scores.get_high_scores()
		
func play_bgm(id, value):
	emit_signal("play_bgm", id, value)

var selected_player = ''
func _set_player_pos(x, y):
	selected_player.set_position(Vector2(x, y))

func _get_player_pos_x():
	var position_p = selected_player.position.x
	return position_p

func _get_player_pos_y():
	var position_p = selected_player.position.y
	return position_p
func on_scene_changed():
	var file = File.new()
	file.open_encrypted_with_pass('user://save_data.1', File.READ, str(34567865))
	current_stage = str(file.get_line())
#	selected_player.restart_position()

func _ready():
#	timer.wait_time = 20
#	timer.connect("timeout", self, '_timeout')
#	timer.one_shot = false
#	timer.start()
	scene_path = ''
	var beta_2 = File.new()
	beta_2.open(str(documents)+ "/Pixel Zone/.data/settings/advanced.save", File.READ)
	var load_set = beta_2.get_line()
	auto_load_mod = bool(str(load_set))

func _timeout():
	_send_data()
	print('SENDING DATA...')
