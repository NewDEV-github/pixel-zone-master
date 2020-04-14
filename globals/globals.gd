extends Node
var timer = Timer.new()
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var scene_path
var collected = 0 setget _set_collected, _get_collected
var auto_load_mod = true
var current_stage = ''
var play_cutscenes
var player_has_been_selected = false
signal collected_changed
signal play_bgm(id, value)
#func send_saved_data():
#	print('SENDING SAVED DATA TO SilentWolf')
#	var save = File.new()
#	save.open_encrypted_with_pass("user://other_saves/0.save", File.READ, '3087283')
#	var loaded_coins = save.get_line()
#	debug_auth_player()
#	var playername = str(SilentWolf.Auth.logged_in_player)
#	if not str(playername) == '':
#		SilentWolf.Scores.persist_score(playername, loaded_coins)
#		SilentWolf.Scores.get_high_scores()
func _set_collected(value):
	collected = value
	emit_signal("collected_changed")

func _get_collected():
	return collected

func _send_data():
	google.submit_leaderboard(int(game_state.points), "CgkIisyP4OEeEAIQAQ")
	debug_auth_player()
	var playername = SilentWolf.Auth.logged_in_player
	if not str(playername) == 'Null':
		if not str(playername) == 'null':
			if not str(playername) == '':
				if not playername == null:
					SilentWolf.Scores.persist_score(playername, game_state.points)
					SilentWolf.Scores.get_high_scores()
				else:
					pass
			else:
				pass
		else:
			pass
	else:
		pass
func play_bgm(id, value):
	emit_signal("play_bgm", id, value)

var selected_player = ''
func _set_player_pos(x, y):
	selected_player.set_position(Vector2(x, y))

func _get_player_pos_x():
	var position_p
	if scene_path == 'res://scenes/players/player2/player2.tscn':
		position_p = float(preload('res://scenes/players/player2/player2.gd').new().position_x)
	if scene_path == 'res://scenes/players/player/player.tscn':
		position_p = float(preload('res://scenes/players/player1/player.gd').new().position_x)
	if scene_path == 'res://main.tscn':
		position_p = float(preload('res://Gameplay Scripts/player_physics.gd').new().position_x)
	return position_p
func _get_player_pos_y():
	var position_p
	if scene_path == 'res://scenes/players/player2/player2.tscn':
		position_p = float(preload('res://scenes/players/player2/player2.gd').new().position_y)
	if scene_path == 'res://scenes/players/player/player.tscn':
		position_p = float(preload('res://scenes/players/player1/player.gd').new().position_y)
	if scene_path == 'res://main.tscn':
		position_p = float(preload('res://Gameplay Scripts/player_physics.gd').new().position_y)
	return position_p
func on_scene_changed():
	var file = File.new()
	file.open_encrypted_with_pass('user://save_data.1', File.READ, str(34567865))
	current_stage = str(file.get_line())
#	selected_player.restart_position()
var google = null

#func show_gps_leaderboard():
#	google.show_leaderboard("CgkIisyP4OEeEAIQAQ")

func _ready():
#	if OS.get_name() == "Android":
#		if Engine.has_singleton("GooglePlay"):
#			google = Engine.get_singleton("GooglePlay")
#			google.init(get_instance_id()) # use get_instance_id () for Godot 3.X
#			google.login()
	SilentWolf.configure({
		'api_key' : "YZ7CY9acpN9NIZ9ebKXd43NO4FVCJFkR8rkF2cO4",
		"game_id": "PixelZone",
		"game_version": "0.9.1-beta1",
		"log_level": 1
	})
	SilentWolf.configure_auth({
	"redirect_to_scene": "res://addons/silent_wolf/Scores/Leaderboard.tscn",
	"session_duration_seconds": 3600,
	"saved_session_expiration_days": 30
	})
	SilentWolf.configure_scores({
	"open_scene_on_close": "res://scenes/Main Menu/GUI.tscn"
	})
	scene_path = ''
	var beta_2 = File.new()
	beta_2.open(str(documents)+ "/Pixel Zone/.data/settings/advanced.save", File.READ)
	var load_set = beta_2.get_line()
	auto_load_mod = bool(str(load_set))
func clear_logs():
	var dir = Directory.new()
	dir.open('user://')
	dir.remove('logs')
	dir.make_dir('logs')
func debug_auth_player():
	print(str(SilentWolf.Auth.logged_in_player))
