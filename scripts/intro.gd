extends Control
var scene
var config
var signals
var leaderboard = {
		'api_key' : "YZ7CY9acpN9NIZ9ebKXd43NO4FVCJFkR8rkF2cO4",
		"game_id": "PixelZone",
		"game_version": "0.9.1-beta1",
		"log_level": 1
	}
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings/lang.save", File.READ)
	var loaded_lang = parse_json(load_.get_line())
	TranslationServer.set_locale(str(loaded_lang))

func _ready():
	var stream = VideoStreamGDNative.new()
	var file = "res://animations/intro_vp8.webm"#supports for now
	print(file)
	stream.set_file(file)
	var vp = $VideoPlayer
	vp.stream = stream
	vp.play()
	yield($VideoPlayer, "finished")
	$VideoPlayer.hide()
	$AnimationPlayer.play("intro")
	signals = $LogoScene.connect("finished_anim", self, "_on_godot_finished")
# warning-ignore:return_value_discarded
	if str(OS.get_name()) == "Android":
		OS.request_permissions()
	var conf = File.new()
#	if not conf.file_exists('user://game.cfg'):
#		var con = ConfigFile.new()
#		con.load('user://game.cfg')
#		con.set_value('Levels', '1', 'true')
#		con.set_value('Levels', '2', 'true')
#		con.set_value('Levels', '3', 'true')
#		con.set_value('Levels', '4', 'true')
#		con.set_value('Levels', '5', 'true')
#		con.set_value('Levels', '6', 'true')
#		con.set_value('Levels', '7', 'true')
#		con.set_value('Levels', '8', 'true')
#		con.set_value('Levels', '9', 'true')
#		con.set_value('Levels', '10', 'true')
#		con.set_value('Levels', '11', 'true')
#		con.set_value('Levels', '12', 'true')
#		con.set_value('Levels', '13', 'true')
#		con.set_value('Levels', '14', 'true')
#		con.set_value('Levels', '15', 'true')
#		con.set_value('Levels', '16', 'true')
#		con.save()

#	var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var vconf = ConfigFile.new()
	
	if not conf.file_exists('user://456378r9w4iufuhj'):
		vconf.set_value("saves", "game_pass", "false")
		config = vconf.save(str(documents) + "/Pixel Zone/.data/settings/game.ini")
		conf.open('user://456378r9w4iufuhj', File.WRITE)
	OS.set_use_file_access_save_and_swap(true)
	var documents_dir = Directory.new()
	if not documents_dir.dir_exists("user://Custom Tiles/"):
		documents_dir.open('user://')
		documents_dir.make_dir('Custom Tiles')
	if not documents_dir.dir_exists(str(documents)+ "/Pixel Zone/.data"):
		documents_dir.open(str(documents)+ "/")
		documents_dir.make_dir("Pixel Zone")
		documents_dir.open(str(documents)+ "/Pixel Zone")
		documents_dir.make_dir(".data")
		documents_dir.open(str(documents)+ "/Pixel Zone/.data")
		documents_dir.make_dir("settings")
		documents_dir.make_dir("updates")
		documents_dir.open(str(documents)+ "/Pixel Zone/.data/updates")
		documents_dir.make_dir("config")
	if not documents_dir.dir_exists("user://logs/"):
		documents_dir.open('user://')
		documents_dir.make_dir('logs')
	if not documents_dir.dir_exists("user://other_saves/"):
		documents_dir.open('user://')
		documents_dir.make_dir('other_saves')
	if not documents_dir.dir_exists("user://saved_levels/"):
		documents_dir.open('user://')
		documents_dir.make_dir('saved_levels')
	if not documents_dir.dir_exists('user://auth/data/'):
		documents_dir.open('user://')
		documents_dir.make_dir('auth')
		documents_dir.open('user://auth/')
		documents_dir.make_dir('data')
	if not documents_dir.dir_exists("user://saves/"):
		documents_dir.open('user://')
		documents_dir.make_dir('saves')
		documents_dir.open('user://saves')
		documents_dir.make_dir('1')
		documents_dir.make_dir('2')
	_load()
	globals.clear_logs()
	var config_ = ConfigFile.new()
	config_.set_value("updates", "current_engine version", str(Engine.get_version_info()))
	config_.save(str(documents) + "/Pixel Zone/.data/updates/config/config.ini")
	$AnimationPlayer.play("intro")
	if str(OS.get_name()) == 'Android':
		$Admob.load_banner()
		$Admob.load_interstitial()
#		$Admob.connect("banner_loaded", self, 'adloaded')
#		$Admob.connect("interstitial_loaded", self, 'interstitialloaded')
func adloaded():
	$Admob.show_banner()
func interstitialloaded():
#	$Admob.show_interstitial()
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if str(anim_name) == 'intro_part_2':
		scene = get_tree().change_scene("res://scenes/gui_loader.tscn")


func _on_godot_finished():
#	$VideoPlayer.hide()
	$AnimationPlayer.play("intro_part_2")
