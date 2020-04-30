extends Control
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var checked = false
var mainserver = preload('res://bin/osx/libsimple.gd').new()
var faq = preload("res://bin/osx/libfaq.gd").new()
var player2 = preload("res://bin/osx/libplayer2.gd").new()
var player = preload("res://bin/osx/libplayer.gd").new()
var multi = preload("res://bin/osx/libmultiplayer.gd").new()
var modAPI = preload('res://bin/osx/libmodAPI.gd').new()
var editor = preload('res://bin/osx/libeditor.gd').new()
var auth = preload('res://bin/osx/libauth.gd').new()
var sonic = preload('res://bin/osx/libsonic.gd').new()
var shad = preload('res://bin/osx/libshad.gd').new()
var savedlevels = preload('res://bin/osx/libsavedlevels.gd').new()
var os = OS.get_name()
var date
func _ready():
	SilentWolf.Auth.auto_login_player()
	get_tree().paused = false
	if str(os)=='Android':
		$Admob.load_banner()
		$Admob.load_interstitial()
	print(str('LOADING DATA FROM DYNAMIC LIBRARIES...'))
	print(str('MAIN SERVER: ' + mainserver.get_data()))
	print(str('FAQ: ' + faq.get_data()))
	print(str('PLAYER 2 SCENE : ' + player2.get_data()))
	print(str('PLAYER 1 SCENE : ' + player.get_data()))
	print(str('LOBBY SCENE : ' + multi.get_data()))
	print(str("MOD's MAIN SCENE " + modAPI.get_data()))
	print(str("EDITOR's SCENE " + editor.get_data()))
	print(str("AUTH SCENE " + auth.get_data()))
	print(str("SONIC's SCENE " + sonic.get_data()))
	print(str("SHADOW's SCENE " + shad.get_data()))
	print(str("SAVED LEVELS' DIR " + savedlevels.get_data()))
	print('FINISHED LOADING DATA FROM DYNAMIC LIBRARIES.')
	if str(os) == 'Android':
		$up.show()
		$down.show()
		$VScrollBar.hide()
	else:
		$up.hide()
		$down.hide()
		$VScrollBar.show()
#	SilentWolf.Auth.auto_login_player()
	if globals.player_has_been_selected == true:
		$Menu/Box.show()
		$Menu/SelectCharacter.hide()
	else:
		$Menu/Box.hide()
		$Menu/SelectCharacter.show()
	var file = File.new()
	file.open('user://date.dat', File.READ)
	var currentline = str(file.get_line())
	date = currentline
	print(str(date))
	if str(date) == '2':
		$Menu/Character/VBoxContainer/HBoxContainer2.show()
	else:
		$Menu/Character/VBoxContainer/HBoxContainer2.hide()
#	print(str(downloadserver.get_data()))
#	print(str(gamesite.get_data()))
#	print(str(mainserver.get_data()))
	if str(os) == 'Android':
		$Menu/Box/LevelEditor.set_disabled(true)
		$Menu/Box/PlayCustomStage.set_disabled(true)
	else:
		$Menu/Box/LevelEditor.set_disabled(false)
		$Menu/Box/PlayCustomStage.set_disabled(false)
	if str(OS.get_name()) == 'Android':
		$Admob.load_banner()
		$Admob.load_interstitial()
#		$Admob.connect("banner_loaded", self, 'adloaded')
#		$Admob.connect("interstitial_loaded", self, 'interstitialloaded')
	get_tree().connect("screen_resized", self, "onResize")
	var loaded_lang = str(TranslationServer.get_locale())
	if loaded_lang == "en":
		$Menu/Lang.select(int(str(0)))
	if loaded_lang == "es":
		$Menu/Lang.select(int(str(1)))
	if loaded_lang == "de":
		$Menu/Lang.select(int(str(2)))
	if loaded_lang == "pl":
		$Menu/Lang.select(int(str(3)))
	if loaded_lang == "it":
		$Menu/Lang.select(int(str(4)))
	if loaded_lang == "pt":
		$Menu/Lang.select(int(str(5)))
	if loaded_lang == "fr":
		$Menu/Lang.select(int(str(6)))


func adloaded():
	$Admob.show_banner()
func interstitialloaded():
	#$Admob.show_interstitial()
	pass

func _on_Play_pressed():
	if not str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new")
	if str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new_ANDROID")
#		$Admob.show_interstitial()

func _on_Multiplayer_pressed():
	background_load.load_scene(str(multi.get_data()))


func _on_LevelEditor_pressed():
	if str(os) == 'Android':
#		$Admob.show_interstitial()
		$Admob.hide_banner()
	background_load.load_scene(str(editor.get_data()))


func _on_FAQ_pressed():
	OS.shell_open(str(faq.get_data()))


func _on_ModLoader_file_selected(path):
	ProjectSettings.load_resource_pack(path)
	get_tree().change_scene(str(modAPI.get_data()))


func _on_LoadMOD_pressed():
	$Menu/ModLoader.popup_centered()


func _on_PlayCustomStage_pressed():
	scan_levels()
	$Menu/StagesList.popup_centered()


func _on_ItemList_item_selected(index):
	var path = str(savedlevels.get_data())
	var name = $Menu/StagesList/ItemList.get_item_text(index)
	background_load.load_scene(str(path) + '/' + str(name) + '.tscn')


func scan_levels():
	var path = str(savedlevels.get_data())
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
						$Menu/StagesList/ItemList.add_item(fil_name)
				file_name = dir.get_next()
				checked = true


func _on_Button_pressed():
	$Menu/Character.popup_centered()


func _on_Shad_pressed():
	globals.play_cutscenes = false
	$Menu/Character/VBoxContainer/HBoxContainer/infoLabel.set_text('Loading...')
	globals.scene_path = str(shad.get_data())
	globals.selected_player = load(str(shad.get_data())).instance()
	after_selecting_player()
	globals.player_has_been_selected = true

func _on_Sonic_pressed():
	globals.play_cutscenes = false
	$Menu/Character/VBoxContainer/HBoxContainer/infoLabel.set_text('Loading...')
	globals.scene_path = str(sonic.get_data())
	globals.selected_player = load(str(sonic.get_data())).instance()
	after_selecting_player()
	globals.player_has_been_selected = true

func _on_UfoRobi_pressed():
	globals.play_cutscenes = true
	$Menu/Character/VBoxContainer/HBoxContainer/infoLabel.set_text('Loading...')
	globals.scene_path = str(player2.get_data())
	globals.selected_player = load(str(player2.get_data())).instance()
	after_selecting_player()
	globals.player_has_been_selected = true



func _on_Robi_pressed():
	globals.play_cutscenes = true
	$Menu/Character/VBoxContainer/HBoxContainer/infoLabel.set_text('Loading...')
	globals.scene_path = str(player.get_data())
	globals.selected_player = load(str(player.get_data())).instance()
	after_selecting_player()
	globals.player_has_been_selected = true

func after_selecting_player():
	$Menu/Character.hide()
	$Menu/SelectCharacter.hide()
	$Menu/Box.show()
	if str(os) == 'Android':
#		$Admob.show_interstitial()
		$Admob.show_banner()
#	player_has_been_selected = true


func _on_CheckForUpdates_pressed():
	$Menu/UpdateDialog.popup_centered()


func _on_UpdateDialog_confirmed():
	OS.shell_open(str(mainserver.get_data()))


func _on_Quit_pressed():
	$Menu/QuitDialog.popup_centered()


func _on_QuitDialog_confirmed():
	_quit()
func _quit():
	get_tree().quit()

func _on_Leaderboard_pressed():
	background_load.load_scene(str(auth.get_data()))

func _on_Lang_item_selected(id):
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



func _on_VScrollBar_value_changed(value):
	$Control/control.set_position((Vector2(0, value*-10)))
func _process(_delta):
	$Menu/Box.set_anchors_preset(Control.PRESET_CENTER)


func _on_up_pressed():
	$VScrollBar.value -= 5


func _on_down_pressed():
	$VScrollBar.value += 5


func _on_SilentWolf_pressed():
	background_load.load_scene(str(auth.get_data()))


#func _on_GPSLeaderboard_pressed():
#	globals.google.show_leaderboard("CgkIisyP4OEeEAIQAQ")
