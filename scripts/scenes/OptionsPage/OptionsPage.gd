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
	$"TabContainer/Graphics & Audio/FileDialog".popup_centered()


func _on_FileDialog_file_selected(path):
	$"TabContainer/Graphics & Audio/HBoxContainer/MusicBox/LineEdit".set_text(path)
	AudioServer.set_bus_mute(1, true)
	$Custom_Music.set_stream(load(path))
	$Custom_Music.play()
