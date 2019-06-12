extends Panel
class_name Options_Page
onready var tab_container = get_node("TabContainer")
func _process(delta):
	tab_container.set_tab_title(0, "KEY_CON_TAB")
	tab_container.set_tab_title(1, "KEY_THEME")
	tab_container.set_tab_title(2, "KEY_LANG")
	tab_container.set_tab_title(3, "KEY_G_A")
	tab_container.set_tab_title(4, "KEY_CONTROLLER")
func _on_ApplyButton_pressed():
	hide()
func _on_Englisch_pressed():
	TranslationServer.set_locale("en")
func _on_Spanisch_pressed():
	TranslationServer.set_locale("es")
func _on_Detusch_pressed():
	TranslationServer.set_locale("de")
func _on_Polisch_pressed():
	TranslationServer.set_locale("pl")
func _on_Italiano_pressed():
	TranslationServer.set_locale("it")
func _on_Portuguese_pressed():
	TranslationServer.set_locale("pt")
func _on_French_pressed():
	TranslationServer.set_locale("fr")
