extends Control

var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var desktop = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
var dcim = OS.get_system_dir(OS.SYSTEM_DIR_DCIM)
var downloads = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)
var movies = OS.get_system_dir(OS.SYSTEM_DIR_MOVIES)
var music = OS.get_system_dir(OS.SYSTEM_DIR_MUSIC)
var load_mod = "false"
var mod_temp
var os = OS.get_name()
var download_path = 'res://Level Editor/'
func _on_Play_pressed():
	if globals.player_has_been_selected == true:
		if not str(OS.get_name()) == 'Android':
			$AnimationPlayer.play("new")
		if str(OS.get_name()) == 'Android':
			$AnimationPlayer.play("new_ANDROID")
func _ready():
	if str(os) == 'Android':
		$TextureRect/VBoxContainer/ImportMod.set_disabled(true)
		$TextureRect/VBoxContainer/LoadGame.set_disabled(true)
		$Back.hide()
		$VScrollBar.set_scale(Vector2(2,1))
	if not str(os) == 'Android':
		$TextureRect/VBoxContainer/ImportMod.set_disabled(false)
		$TextureRect/VBoxContainer/LoadGame.set_disabled(false)
		$Back.show()
		$VScrollBar.set_scale(Vector2(1,1))
	var loaded_lang = str(TranslationServer.get_locale())
	if loaded_lang == "en":
		$TextureRect/LanguageButton.select(int(str(0)))
	if loaded_lang == "es":
		$TextureRect/LanguageButton.select(int(str(1)))
	if loaded_lang == "de":
		$TextureRect/LanguageButton.select(int(str(2)))
	if loaded_lang == "pl":
		$TextureRect/LanguageButton.select(int(str(3)))
	if loaded_lang == "it":
		$TextureRect/LanguageButton.select(int(str(4)))
	if loaded_lang == "pt":
		$TextureRect/LanguageButton.select(int(str(5)))
	if loaded_lang == "fr":
		$TextureRect/LanguageButton.select(int(str(6)))
	var beta = File.new()
	beta.open(str(documents)+ "/Pixel Zone/.data/settings/beta.save", File.READ)
	var loaded = bool(str(beta.get_line()))
	$TextureRect/VBoxContainer/Update.set_visible(loaded)
func _on_Quit_pressed():
	get_tree().quit()

func _process(delta):
	
	$TextureRect/Label.set_text("Downloaded " + str($HTTPRequest.get_downloaded_bytes()) + " bytes of " + str($HTTPRequest.get_body_size()) + " bytes (" + (str($HTTPRequest.get_downloaded_bytes()/($HTTPRequest.get_body_size()*(0.01)))) +" %)")
	
func _on_Play7_pressed():
	OS.shell_open("mailto:karoltomaszewskimusic@gmail.com;olo2tom@o2.pl;?subject=I Found a Bug in Pixel Zone")

func _on_Play6_pressed():
	$TextureRect/WindowDialog.popup_centered()

func _on_PP_pressed():
	$TextureRect/DownloadNot.popup_centered()
	$TextureRect/Label.show()
# warning-ignore:standalone_expression
	globals.dlc_name == "3D DLC"
	$HTTPRequest.set_download_file("user://dlc_loops.pck")
	$HTTPRequest.request("https://github.com/MasterPolska123/pixel-zone-master/releases/download/v0.7.2.1.0/dlc_loops.pck")

func _on_Licenses_pressed():
	$TextureRect/Control._show()
func _on_Play8_pressed():
	get_tree().change_scene("res://dlcs/multi/lobby.tscn")



func _on_WindowDialog3_popup_hide():
	$TextureRect/WindowDialog2.hide()

func _on_close_pressed():
	$TextureRect/WindowDialog2.hide()


func _on_ImportMod_pressed():
	$ModSelector.popup()




func _on_WindowDialog3_about_to_show():
	$TextureRect/WindowDialog2.hide()


func _on_Update_pressed():
	background_load.load_scene("res://scenes/ScoreBoardOnline.tscn")


func _on_VScrollBar_value_changed(value):
	$Control.set_position(Vector2(0, +(value*(-10))))


func _on_Timer_timeout():
	_on_Play_pressed()

func _on_ModSelector_file_selected(path):
	var mod = File.new()
	var mod_path = File.new()
	mod_path.open(str(documents) + "/Pixel Zone/.data/mod_path.save", File.WRITE)
	mod_path.store_line(path)
	mod_temp = path
	print(str(path))
	ProjectSettings.load_resource_pack(path)
	get_tree().change_scene("res://mod.tscn")

func _on_ModSelector_popup_hide():
	pass


func _on_ModSelector_about_to_show():
	pass


func _on_ConfirmationDialog_confirmed():
	if not str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new")
	if str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new_ANDROID")

signal reload
func _on_TextureButton_pressed():
	globals.scene_path = 'res://scenes/players/player1/player.tscn'
	globals.selected_player = preload('res://scenes/players/player1/player.tscn').instance()
	if not str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new")
	if str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new_ANDROID")
	globals.player_has_been_selected = true
	globals._save()

func _on_TextureButton2_pressed():
	globals.scene_path = 'res://scenes/players/player2/player2.tscn'
	globals.selected_player = preload('res://scenes/players/player2/player2.tscn').instance()
	if not str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new")
	if str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new_ANDROID")
	globals.player_has_been_selected = true
	globals._save()

func _on_Play5_pressed():
	if globals.player_has_been_selected == false:
		$TextureRect/PopupPanel.popup_centered()
	elif globals.player_has_been_selected == true:
		if not str(OS.get_name()) == 'Android':
			$AnimationPlayer.play("new")
		if str(OS.get_name()) == 'Android':
			$AnimationPlayer.play("new_ANDROID")


func _on_LoadGame2_pressed():
	OS.shell_open('https://masterpolska123.github.io/home/faq/index.html')


func _on_LanguageButton_item_selected(id):
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/settings/lang.save", File.WRITE)
	save.store_line(to_json(str(TranslationServer.get_locale())))
	if id == 0:
		TranslationServer.set_locale('en')
	if id == 1:
		TranslationServer.set_locale('es')
	if id == 2:
		TranslationServer.set_locale('de')
	if id == 3:
		TranslationServer.set_locale('pl')
	if id == 4:
		TranslationServer.set_locale('it')
	if id == 5:
		TranslationServer.set_locale('pt')
	if id == 6:
		TranslationServer.set_locale('fr')

var checked = false
func _on_Back_pressed():
	$WindowDialog.popup_centered()
	var path = 'user://saved_levels/'
	if checked == false:
		var dir = Directory.new()
		if dir.open(path) == OK:
			dir.list_dir_begin()
			print(str(dir.list_dir_begin()))
			var file_name = dir.get_next()
			while (file_name != ""):
				if dir.current_is_dir():
					print("Found directory: " + file_name)
				else:
					print("Found file: " + file_name)
					var fil_name = str(file_name).get_basename()
					var extension = str(file_name).get_extension()
					print(extension)
					if extension == "tscn":
						$WindowDialog/ItemList.add_item(fil_name)
				file_name = dir.get_next()
				checked = true
#	$AnimationPlayer.play("back")
	


func _on_ItemList_item_selected(index):
	var path = 'user://saved_levels'
	var name = $WindowDialog/ItemList.get_item_text(index)
	background_load.load_scene(str(path) + '/' + str(name) + '.tscn')
	


func _on_LoadGame_pressed():
	background_load.load_scene('res://Level Editor/Editor.tscn')
