extends Spatial
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var desktop = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
var dcim = OS.get_system_dir(OS.SYSTEM_DIR_DCIM)
var downloads = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)
var movies = OS.get_system_dir(OS.SYSTEM_DIR_MOVIES)
var music = OS.get_system_dir(OS.SYSTEM_DIR_MUSIC)
func _on_AnimationPlayer_animation_finished(intro_new):
	get_tree().change_scene("res://scenes/gui_loader.tscn")
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/lang.save", File.READ)
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
	_load()
	var update = File.new()
	if update.file_exists(str(documents) + "/Pixel Zone/.data/updates/update.pck"):
		ProjectSettings.load_resource_pack(str(documents) + "/Pixel Zone/.data/updates/update.pck")
	if not update.file_exists(str(documents) + "/Pixel Zone/.data/updates/config/config.ini"):
		update.open(str(documents) + "/Pixel Zone/.data/updates/config/config.ini", File.WRITE)
		update.store_line(to_json(""))
		update.close()
	var dlc = File.new()
	if update.file_exists(str(documents) + "/Pixel Zone/.data/updates/config/config.ini"):
		return
func _on_Skip_pressed():
	$AnimationPlayer.stop()
	get_tree().change_scene("res://scenes/gui_loader.tscn")
func save():
    var save_dict = {
        "filename" : get_filename(),
        "parent" : get_parent().get_path(),
		"File ID" : OS.get_unix_time()
    }
    return save_dict
