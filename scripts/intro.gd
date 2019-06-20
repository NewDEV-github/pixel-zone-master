extends Control
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var desktop = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
var dcim = OS.get_system_dir(OS.SYSTEM_DIR_DCIM)
var downloads = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)
var movies = OS.get_system_dir(OS.SYSTEM_DIR_MOVIES)
var music = OS.get_system_dir(OS.SYSTEM_DIR_MUSIC)
func _on_window_size_changeds(prev, now):
	rect_size = now
	$Viewport.size = now
func _on_AnimationPlayer_animation_finished(intro_new):
	get_tree().change_scene("res://scenes/AutoSaveNotification.tscn")
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
	_load()
	var update = File.new()
	if update.file_exists(str(documents) + "/Pixel Zone/.data/updates/update.pck"):
		ProjectSettings.load_resource_pack(str(documents) + "/Pixel Zone/.data/updates/update.pck")
	if not update.file_exists(str(documents) + "/Pixel Zone/.data/updates/config/config.ini"):
		update.open(str(documents) + "/Pixel Zone/.data/updates/config/config.ini", File.WRITE)
		var save_nodes = get_tree().get_nodes_in_group("config")
		for i in save_nodes:
			var node_data = i.call("save");
			update.store_line(to_json(node_data))
		update.close()
	var dlc = File.new()
	if update.file_exists(str(documents) + "/Pixel Zone/.data/updates/config/config.ini"):
		return
func _on_Skip_pressed():
	$AnimationPlayer.stop()
	get_tree().change_scene("res://scenes/AutoSaveNotification.tscn")
func save():
    var save_dict = {
        "filename" : get_filename(),
        "parent" : get_parent().get_path(),
		"File ID" : OS.get_unix_time()
    }
    return save_dict