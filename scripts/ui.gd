extends Control
var theme1
var theme2
var theme3
var theme4
var theme5
var theme6
var theme7
var theme8
var default = load("res://themes/theme_test.tres")
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _save():
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/settings/theme.save", File.WRITE)
	save.store_line(to_json($theme.text))
	save.close()
func _load_user_theme(path):
	self.set_theme(path)
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/settings/theme.save", File.READ)
	var loaded_theme = parse_json(load_.get_line())
	if loaded_theme == "default":
		self.set_theme(default)

func _on_Default_pressed():
	self.set_theme(default)
	$theme.set_text('default')
	_save()

func _ready():
	_load()
	
	theme1 = $GameUI/Menu/OptionsPage.connect("ready_to_load", self, "_load_user_theme")
	theme7 = $GameUI/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Default.connect("pressed", self, "_on_Default_pressed")
func _on_theme_selected(path):
	self.set_theme(path)
