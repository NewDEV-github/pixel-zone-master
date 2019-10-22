extends Panel
class_name Options_Page
var current_tab = 0
var music
var custom_music
onready var pause_x = $"TabContainer/Controller Test/Control/VBoxContainer/pause/x".text
onready var pause_y = $"TabContainer/Controller Test/Control/VBoxContainer/pause/y".text
onready var jump_x = $"TabContainer/Controller Test/Control/VBoxContainer/jump/x".text
onready var jump_y = $"TabContainer/Controller Test/Control/VBoxContainer/jump/y".text
onready var shoot_x = $"TabContainer/Controller Test/Control/VBoxContainer/shoot/x".text
onready var shoot_y = $"TabContainer/Controller Test/Control/VBoxContainer/shoot/y".text
onready var left_x = $"TabContainer/Controller Test/Control/VBoxContainer/left/x".text
onready var left_y = $"TabContainer/Controller Test/Control/VBoxContainer/left/y".text
onready var right_x = $"TabContainer/Controller Test/Control/VBoxContainer/right/x".text
onready var right_y = $"TabContainer/Controller Test/Control/VBoxContainer/right/y".text
var player_1 = preload('res://scenes/players/player1/player.gd').new()
var player_2 = preload('res://scenes/players/player2/player2.gd').new()
var os = str(OS.get_name())
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
onready var tab_container = get_node("TabContainer")
#func _input(event):
#	if Input.is_action_pressed("tab_left") and not current_tab == 0:
#		current_tab -= 1
#		tab_container.set_current_tab(int(float(current_tab)))
#	if Input.is_action_pressed("tab_left") and current_tab == 0:
#		current_tab = 4
#		tab_container.set_current_tab(int(float(current_tab)))
#	if Input.is_action_pressed("tab_right") and current_tab == 4:
#		current_tab = 0
#		tab_container.set_current_tab(int(float(current_tab)))
#	if Input.is_action_pressed("tab_right") and not current_tab == 4:
#		current_tab += 1
#		tab_container.set_current_tab(int(float(current_tab)))
#	print(current_tab)
func _process(delta):
	
	tab_container.set_tab_title(0, "KEY_CON_TAB")
	tab_container.set_tab_title(1, "KEY_THEME")
	tab_container.set_tab_title(2, "KEY_LANG")
	tab_container.set_tab_title(3, "KEY_G_A")
	tab_container.set_tab_title(4, "KEY_CONTROLLER")
	if not str(os) == 'Android':
		$TabContainer.set_tab_disabled(4, false)
	else:
		$TabContainer.set_tab_disabled(4, true)
	if $"TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/Advanced".pressed == true:
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/MenuButton".set_visible(true)
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/LineEdit".set_visible(true)
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/BetaTests".set_visible(true)
	if $"TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/Advanced".pressed == false:
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/MenuButton".set_visible(false)
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/LineEdit".set_visible(false)
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/BetaTests".set_visible(false)
	
func _on_ApplyButton_pressed():
	hide()

func _save():
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/settings/lang.save", File.WRITE)
	save.store_line(to_json(str(TranslationServer.get_locale())))
	save.close()
	
func _ready():
	if str(os) == 'Android':
		$"TabContainer/Controller Test/joypads".hide()
		$"TabContainer/Controller Test/Control".show()
	if not str(os) == 'Android':
		$"TabContainer/Controller Test/joypads".show()
		$"TabContainer/Controller Test/Control".hide()
	var beta = File.new()
	beta.open(str(documents)+ "/Pixel Zone/.data/settings/beta.save", File.READ)
	var loaded = bool(str(beta.get_line()))
	$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/BetaTests".set_pressed(loaded)
	music = AudioServer.get_bus_index("Music")
	custom_music = AudioServer.get_bus_index("Custom Music")
func _on_Englisch_pressed():
	TranslationServer.set_locale("en")
	_save()
func _on_Spanisch_pressed():
	TranslationServer.set_locale("es")
	_save()
func _on_Detusch_pressed():
	TranslationServer.set_locale("de")
	_save()
func _on_Polisch_pressed():
	TranslationServer.set_locale("pl")
	_save()
func _on_Italiano_pressed():
	TranslationServer.set_locale("it")
	_save()
func _on_Portuguese_pressed():
	TranslationServer.set_locale("pt")
	_save()
func _on_French_pressed():
	TranslationServer.set_locale("fr")
	_save()
#func _ready():
#	_load()


func _on_MenuButton_pressed():
	$"TabContainer/Graphics & Audio/WindowDialog".popup_centered()

func _on_ItemList_item_selected(index):
	var path
	if index == 0:
		path = "res://sounds/music.ogg"
	if index == 1:
		path = "res://sounds/jungle_ruins.ogg"
	if index == 2:
		path = "res://sounds/brazil-fast.ogg"
	if index == 3:
		path = 'res://sounds/Ice_Cap_Adventure.ogg'
	if index == 4:
		path = "res://sounds/hill.ogg"
	if index == 5:
		path = 'res://sounds/sci-fi.ogg'
	if index == 6:
		path = 'res://sounds/Castlemania.ogg'
	
	AudioServer.set_bus_mute(1, true)
	$Custom_Music.set_stream(load(path))
	$Custom_Music.play()
	$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/LineEdit".set_text(path)
	$"TabContainer/Graphics & Audio/WindowDialog".hide()

var checked = false
func _on_Yellow_pressed():
	$TabContainer/Theme/CustomTheme.popup_centered()
	var path = str(documents) +"/Pixel Zone/"
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
					if extension == "tres":
						$TabContainer/Theme/CustomTheme/ThemeList.add_item(fil_name)
				file_name = dir.get_next()
				checked = true
		else:
			print("An error occurred when trying to access the path.")

signal ready_to_load

func _on_ThemeList_item_selected(index):
	var path = str(documents) + "/Pixel Zone/"
	var item_name = $TabContainer/Theme/CustomTheme/ThemeList.get_item_text(index)
	var full_theme_path = str(path) + str(item_name)
	var load_path = load(full_theme_path)
	print(full_theme_path)
	var ui_theme = preload("res://scripts/ui.gd")
	ui_theme.new()._load_user_theme(load_path)
	emit_signal("ready_to_load", load_path)
#	self.set_theme(load(full_theme_path))


func _on_BetaTests_pressed():
	var beta = File.new()
	beta.open(str(documents)+ "/Pixel Zone/.data/settings/beta.save", File.WRITE)
	beta.store_line(str($"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/BetaTests".pressed))
	beta.close()

