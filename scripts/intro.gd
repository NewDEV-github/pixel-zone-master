extends Control
var scene
var config
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings/lang.save", File.READ)
	var loaded_lang = parse_json(load_.get_line())
	if loaded_lang == "en":
		TranslationServer.set_locale("en")
	if loaded_lang == "es":
		TranslationServer.set_locale("es")
	if loaded_lang == "de":
		TranslationServer.set_locale("de")
	if loaded_lang == "pl":
		TranslationServer.set_locale("pl")
	if loaded_lang == "it":
		TranslationServer.set_locale("it")
	if loaded_lang == "pt":
		TranslationServer.set_locale("pt")
	if loaded_lang == "fr":
		TranslationServer.set_locale("fr")

func _ready():
	
	ProjectSettings.save()

	var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var vconf = ConfigFile.new()
	
	var conf = File.new()
	if not conf.file_exists('user://456378r9w4iufuhj'):
		vconf.set_value("saves", "game_pass", "false")
		config = vconf.save(str(documents) + "/Pixel Zone/.data/settings/game.ini")
		conf.open('user://456378r9w4iufuhj', File.WRITE)
	OS.set_use_file_access_save_and_swap(true)
	var documents_dir = Directory.new()
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
	if not documents_dir.dir_exists("user://saves/"):
		documents_dir.open('user://')
		documents_dir.make_dir('saves')
		documents_dir.open('user://saves')
		documents_dir.make_dir('1')
		documents_dir.make_dir('2')
	_load()
	var config = ConfigFile.new()
	config.set_value("updates", "current_engine version", str(Engine.get_version_info()))
	config.save(str(documents) + "/Pixel Zone/.data/updates/config/config.ini")
	$AnimationPlayer.play("intro")

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"File ID" : OS.get_unix_time()
	}
	return save_dict


func _on_AnimationPlayer_animation_finished(anim_name):
	if not str(anim_name) == '':
		scene = get_tree().change_scene("res://scenes/gui_loader.tscn")
