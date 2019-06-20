extends Panel
class_name Options_Page
var music
var custom_music
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
onready var tab_container = get_node("TabContainer")
func _process(delta):
	tab_container.set_tab_title(0, "KEY_CON_TAB")
	tab_container.set_tab_title(1, "KEY_THEME")
	tab_container.set_tab_title(2, "KEY_LANG")
	tab_container.set_tab_title(3, "KEY_G_A")
	tab_container.set_tab_title(4, "KEY_CONTROLLER")
	if $"TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/Advanced".pressed == true:
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/MenuButton".set_visible(true)
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/LineEdit".set_visible(true)
	if $"TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/Advanced".pressed == false:
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/MenuButton".set_visible(false)
		$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/LineEdit".set_visible(false)
func _on_ApplyButton_pressed():
	hide()
func _save():
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/lang.save", File.WRITE)
	save.store_line(to_json($TabContainer/Language/Label.text))
	save.close()
func _ready():
	music = AudioServer.get_bus_index("Music")
	custom_music = AudioServer.get_bus_index("Custom Music")
func _on_Englisch_pressed():
	TranslationServer.set_locale("en")
	$TabContainer/Language/Label.set_text("en")
	_save()
func _on_Spanisch_pressed():
	TranslationServer.set_locale("es")
	$TabContainer/Language/Label.set_text("es")
	_save()
func _on_Detusch_pressed():
	TranslationServer.set_locale("de")
	$TabContainer/Language/Label.set_text("de")
	_save()
func _on_Polisch_pressed():
	TranslationServer.set_locale("pl")
	$TabContainer/Language/Label.set_text("pl")
	_save()
func _on_Italiano_pressed():
	TranslationServer.set_locale("it")
	$TabContainer/Language/Label.set_text("it")
	_save()
func _on_Portuguese_pressed():
	TranslationServer.set_locale("pt")
	$TabContainer/Language/Label.set_text("pt")
	_save()
func _on_French_pressed():
	TranslationServer.set_locale("fr")
	$TabContainer/Language/Label.set_text("fr")
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
		path = 'res://sounds/levels/Ice_Cap_Adventure/Ice_Cap_Adventure.ogg'
	if index == 4:
		path = "res://sounds/Audio/musics/sky_sanctuary_zone.ogg"
	AudioServer.set_bus_mute(1, true)
	$Custom_Music.set_stream(load(path))
	$Custom_Music.play()
	$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/LineEdit".set_text(path)