extends Control
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var checked = false

var admob = null
var isReal = true
var isTop = true
var os = OS.get_name()
var adBannerId = "ca-app-pub-3142193952770678/7369767442" # [Replace with your Ad Unit ID and delete this message.]
var adInterstitialId = "ca-app-pub-3142193952770678/9337455234" # [Replace with your Ad Unit ID and delete this message.]
var adRewardedId = "ca-app-pub-3142193952770678/8372051443" # [There is no testing option for rewarded videos, so you can use this id for testing]
var date
func _ready():
#	show()
#	SilentWolf.Auth.auto_login_player()
	if globals.player_has_been_selected == true:
		$CanvasLayer/Menu/Box.show()
		$CanvasLayer/Menu/SelectCharacter.hide()
	else:
		$CanvasLayer/Menu/Box.hide()
		$CanvasLayer/Menu/SelectCharacter.show()
	var file = File.new()
	file.open('user://date.dat', File.READ)
	var currentline = str(file.get_line())
	date = currentline
	print(str(date))
	if str(date) == '2':
		$CanvasLayer/Menu/Character/VBoxContainer/HBoxContainer2.show()
	else:
		$CanvasLayer/Menu/Character/VBoxContainer/HBoxContainer2.hide()
#	print(str(downloadserver.get_data()))
#	print(str(gamesite.get_data()))
#	print(str(mainserver.get_data()))
	if str(os) == 'Android':
		$CanvasLayer/Menu/Box/LevelEditor.set_disabled(true)
		$CanvasLayer/Menu/Box/PlayCustomStage.set_disabled(true)
	else:
		$CanvasLayer/Menu/Box/LevelEditor.set_disabled(false)
		$CanvasLayer/Menu/Box/PlayCustomStage.set_disabled(false)
	if(Engine.has_singleton("AdMob")):
		print('HAS SINGLETON')
		admob = Engine.get_singleton("AdMob")
		admob.init(isReal, get_instance_id())
		loadBanner()
		loadInterstitial()
		loadRewardedVideo()
	admob.showBanner()
	admob.showInterstitial()
	get_tree().connect("screen_resized", self, "onResize")
	var loaded_lang = str(TranslationServer.get_locale())
	if loaded_lang == "en":
		$CanvasLayer/Menu/Lang.select(int(str(0)))
	if loaded_lang == "es":
		$CanvasLayer/Menu/Lang.select(int(str(1)))
	if loaded_lang == "de":
		$CanvasLayer/Menu/Lang.select(int(str(2)))
	if loaded_lang == "pl":
		$CanvasLayer/Menu/Lang.select(int(str(3)))
	if loaded_lang == "it":
		$CanvasLayer/Menu/Lang.select(int(str(4)))
	if loaded_lang == "pt":
		$CanvasLayer/Menu/Lang.select(int(str(5)))
	if loaded_lang == "fr":
		$CanvasLayer/Menu/Lang.select(int(str(6)))

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

func _on_BtnBanner_toggled(pressed):
	if admob != null:
		if pressed: admob.showBanner()
		else: admob.hideBanner()

func _on_BtnInterstitial_pressed():
	if admob != null:
		admob.showInterstitial()
		
func _on_BtnRewardedVideo_pressed():
	if admob != null:
		admob.showRewardedVideo()

func _on_admob_network_error():
	print("Network Error")

func _on_admob_ad_loaded():
	print("Ad loaded success")
	get_node("CanvasLayer/Ads/BtnBanner").set_disabled(false)

func _on_interstitial_not_loaded():
	print("Error: Interstitial not loaded")

func _on_interstitial_loaded():
	print("Interstitial loaded")
	get_node("CanvasLayer/Ads/BtnInterstitial").set_disabled(false)

func _on_interstitial_close():
	print("Interstitial closed")
	get_node("CanvasLayer/Ads/BtnInterstitial").set_disabled(true)

func _on_rewarded_video_ad_loaded():
	print("Rewarded loaded success")
	get_node("CanvasLayer/Ads/BtnRewardedVideo").set_disabled(false)
	
func _on_rewarded_video_ad_closed():
	print("Rewarded closed")
	get_node("CanvasLayer/Ads/BtnRewardedVideo").set_disabled(true)
	loadRewardedVideo()
	
func _on_rewarded(currency, amount):
	print("Reward: " + currency + ", " + str(amount))
	get_node("CanvasLayer/Ads/LblRewarded").set_text("Reward: " + currency + ", " + str(amount))

# Resize

func onResize():
	if admob != null:
		admob.resize()
###MENU


func _on_Play_pressed():
	if not str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new")
	if str(OS.get_name()) == 'Android':
		$AnimationPlayer.play("new_ANDROID")
		admob.showInterstitial()

func _on_Multiplayer_pressed():
	background_load.load_scene('res://dlcs/multi/lobby.tscn')


func _on_LevelEditor_pressed():
	admob.showInterstitial()
	background_load.load_scene('res://Level Editor/Editor.tscn')


func _on_FAQ_pressed():
	OS.shell_open('https://masterpolska123.github.io/faq/')


func _on_ModLoader_file_selected(path):
	ProjectSettings.load_resource_pack(path)
	get_tree().change_scene("res://mod.tscn")


func _on_LoadMOD_pressed():
	$CanvasLayer/Menu/ModLoader.popup_centered()


func _on_PlayCustomStage_pressed():
	scan_levels()
	$CanvasLayer/Menu/StagesList.popup_centered()


func _on_ItemList_item_selected(index):
	var path = 'user://saved_levels'
	var name = $CanvasLayer/Menu/StagesList/ItemList.get_item_text(index)
	background_load.load_scene(str(path) + '/' + str(name) + '.tscn')


func scan_levels():
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
						$CanvasLayer/Menu/StagesList/ItemList.add_item(fil_name)
				file_name = dir.get_next()
				checked = true


func _on_Button_pressed():
	$CanvasLayer/Menu/Character.popup_centered()


func _on_Sonic_pressed():
	globals.play_cutscenes = false
	$CanvasLayer/Menu/Character/VBoxContainer/HBoxContainer/infoLabel.set_text('Loading...')
	globals.scene_path = 'res://main.tscn'
	globals.selected_player = preload('res://main.tscn').instance()
	after_selecting_player()
	globals.player_has_been_selected = true

func _on_UfoRobi_pressed():
	globals.play_cutscenes = true
	$CanvasLayer/Menu/Character/VBoxContainer/HBoxContainer/infoLabel.set_text('Loading...')
	globals.scene_path = 'res://scenes/players/player2/player2.tscn'
	globals.selected_player = preload('res://scenes/players/player2/player2.tscn').instance()
	after_selecting_player()
	globals.player_has_been_selected = true



func _on_Robi_pressed():
	
	globals.play_cutscenes = true
	$CanvasLayer/Menu/Character/VBoxContainer/HBoxContainer/infoLabel.set_text('Loading...')
	globals.scene_path = 'res://scenes/players/player1/player.tscn'
	globals.selected_player = preload('res://scenes/players/player1/player.tscn').instance()
	after_selecting_player()
	globals.player_has_been_selected = true

func after_selecting_player():
	$CanvasLayer/Menu/Character.hide()
	$CanvasLayer/Menu/SelectCharacter.hide()
	$CanvasLayer/Menu/Box.show()
	if str(os) == 'Android':
		admob.showInterstitial()
		admob.showBanner()
#	player_has_been_selected = true


func _on_CheckForUpdates_pressed():
	$CanvasLayer/Menu/UpdateDialog.popup_centered()


func _on_UpdateDialog_confirmed():
	OS.shell_open('https://masterpolska123.github.io/')


func _on_Quit_pressed():
	$CanvasLayer/Menu/QuitDialog.popup_centered()


func _on_QuitDialog_confirmed():
	get_tree().quit()


func _on_Leaderboard_pressed():
	if str(os) == 'Android':
		admob.showInterstitial()
		admob.hideBanner()
	background_load.load_scene('res://scenes/auth.tscn')

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
	$CanvasLayer/Menu/Box.set_anchors_preset(Control.PRESET_CENTER)
