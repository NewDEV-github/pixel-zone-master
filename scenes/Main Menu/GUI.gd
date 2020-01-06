extends Control
var configured = false
var scene
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
var mod_path = str(documents) + '/Pixel Zone/Mods/'
var dir_mod_path = Directory.new()
func _on_Play_pressed():
	if not str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new")
	if str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new_ANDROID")
		
var admob = null
var isReal = true
var isTop = true
var adBannerId = "ca-app-pub-3142193952770678/2105195769" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-3142193952770678/5995273653" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-3142193952770678/3880047799" # [There is no testing option for rewarded videos, so you can use this id for testing]
# Loaders
func _ready():
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		admob.init(isReal, get_instance_id())
		loadBanner()
		loadInterstitial()
		loadRewardedVideo()
	showbanner()
	get_tree().connect("screen_resized", self, "onResize")

	if os == 'OSX':
		if configured == false:
			$Control3.popup_centered()
	var file = File.new()
	if file.file_exists(str(documents) + '/Pixel Zone/.data/settings/editor.txt'):
		$TextureRect/VBoxContainer/LoadGame.set_disabled(false)
	else:
		$TextureRect/VBoxContainer/LoadGame.set_disabled(true)
	$HTTPRequest.set_download_file('user://LeaderBoard.txt')
	$HTTPRequest.request('https://masterpolska123.github.io/downloadable_files/installer/Leaderboard_config.txt')
	
	var conf = File.new()
	if not os == 'Android':
		if not os == 'OSX':
			if conf.file_exists(str(documents) +'/Pixel Zone/.data/settings/editor.txt'):
				$TextureRect/VBoxContainer/LoadGame.set_disabled(false)
			if not conf.file_exists(str(documents) +'/Pixel Zone/.data/settings/editor.txt'):
				$TextureRect/VBoxContainer/LoadGame.set_disabled(true)
		else:
			$TextureRect/VBoxContainer/LoadGame.set_disabled(true)
		
		if conf.file_exists(str(documents) +'/Pixel Zone/.data/settings/leaderboard.txt'):
			$TextureRect/VBoxContainer/Update.set_disabled(false)
		if not conf.file_exists(str(documents) +'/Pixel Zone/.data/settings/leaderboard.txt'):
			$TextureRect/VBoxContainer/Update.set_disabled(true)
	$HTTPRequest.set_download_file('user://dlc.txt')
	$HTTPRequest.request('https://masterpolska123.github.io/downloadable_files/installer/dlc.txt')
	if globals.auto_load_mod == true:
		$TextureRect/VBoxContainer/ImportMod.set_disabled(false)
	if globals.auto_load_mod == false:
		$TextureRect/VBoxContainer/ImportMod.set_disabled(true)
	if not dir_mod_path.dir_exists(str(mod_path)):
		dir_mod_path.open(str(documents + '/Pixel Zone/'))
		dir_mod_path.make_dir('Mods')
	if dir_mod_path.dir_exists(str(mod_path)):
		if globals.auto_load_mod == true :
			var checked = false
			var path = mod_path
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
							var file_path = str(file_name).get_base_dir()
							var fil_name = str(file_name).get_basename()
							var extension = str(file_name).get_extension()
							print(extension)
							if extension == "pck":
								print(str(path) + str(fil_name) + '.' + str(extension))
								ProjectSettings.load_resource_pack(str(path) + str(fil_name) + '.' + str(extension))
								print('LOADING MODIIFICATION FROM: ' +str(path) + str(fil_name) + '.' + str(extension))
						file_name = dir.get_next()
						checked = true
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
	var conf = File.new()
	if conf.file_exists('user://dlc.txt'):
		$TextureRect/PopupPanel/TextureButton4.show()
	if not conf.file_exists('user://dlc.txt'):
		$TextureRect/PopupPanel/TextureButton4.hide()
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
	background_load.load_scene("res://dlcs/multi/lobby.tscn")



func _on_WindowDialog3_popup_hide():
	$TextureRect/WindowDialog2.hide()

func _on_close_pressed():
	$TextureRect/WindowDialog2.hide()


func _on_ImportMod_pressed():
	$ModSelector.popup()




func _on_WindowDialog3_about_to_show():
	$TextureRect/WindowDialog2.hide()


func _on_Update_pressed():
	background_load.load_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")


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
	scene = get_tree().change_scene("res://mod.tscn")

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
	globals.play_cutscenes = true
	$TextureRect/PopupPanel/Label.set_text('Loading...')
	globals.scene_path = 'res://scenes/players/player1/player.tscn'
	globals.selected_player = preload('res://scenes/players/player1/player.tscn').instance()
	if not str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new")
	if str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new_ANDROID")


func _on_TextureButton2_pressed():
	globals.play_cutscenes = true
	$TextureRect/PopupPanel/Label.set_text('Loading...')
	globals.scene_path = 'res://scenes/players/player2/player2.tscn'
	globals.selected_player = preload('res://scenes/players/player2/player2.tscn').instance()
	if not str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new")
	if str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new_ANDROID")

func _on_Play5_pressed():
	$TextureRect/PopupPanel.popup_centered()


func _on_LoadGame2_pressed():
	OS.shell_open('https://masterpolska123.github.io/home/faq/')


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


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var file = File.new()
	file.open('user://LeaderBoard.txt', File.READ)
	if str(file.get_line()) == 'Enable' and not os == 'Android':
		$TextureRect/VBoxContainer/Update.set_disabled(false)
	else:
		$TextureRect/VBoxContainer/Update.set_disabled(true)


func _on_Control3_popup_hide():
	configured = true
	get_tree().reload_current_scene()
###ADS

# Loaders

func loadBanner():
	if admob != null:
		admob.loadBanner(adBannerId, isTop)

func loadInterstitial():
	if admob != null:
		admob.loadInterstitial(adInterstitialId)
		
func loadRewardedVideo():
	if admob != null:
		admob.loadRewardedVideo(adRewardedId)

# Events

func showbanner():
	if admob != null:
		admob.showBanner()
func hidebanner():
	if admob != null:
		admob.hideBanner()
func interstitial():
	if admob != null:
		admob.showInterstitial()
		
func rewarded():
	if admob != null:
		admob.showRewardedVideo()

func _on_rewarded(currency, amount):
	print("Reward: " + currency + ", " + str(amount))


func onResize():
	if admob != null:
		admob.resize()



func _on_TextureButton4_pressed():
	globals.play_cutscenes = false
	$TextureRect/PopupPanel/Label.set_text('Loading...')
	globals.scene_path = 'res://main.tscn'
	globals.selected_player = preload('res://main.tscn').instance()
	if not str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new")
	if str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new_ANDROID")
