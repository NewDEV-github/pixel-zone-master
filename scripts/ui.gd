extends Control
var solarized_light = load("res://themes/solarized_light.tres")
var solarized_dark = load("res://themes/solarized_dark.tres")
var light = load("res://themes/light.tres")
var alien = load("res://themes/alien.tres")
var neon = load("res://themes/new_gui/neon.tres")
var green = load("res://themes/green_theme.tres")
var grey = load("res://themes/grey_theme.tres")
var red = load("res://themes/red_theme.tres")
var yellow = load("res://themes/yellow_theme.tres")
var old = load("res://themes/2theme.tres")
var blue = load("res://themes/blue_theme.tres")
var default = load("res://themes/theme_test.tres")
var ui_theme #= $theme.text
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _save():
	var save = File.new()
	save.open(str(documents) +"/Pixel Zone/.data/theme.save", File.WRITE)
	save.store_line(to_json($theme.text))
	save.close()
func _load():
	var load_ = File.new()
	load_.open(str(documents) +"/Pixel Zone/.data/theme.save", File.READ)
	var loaded_theme = parse_json(load_.get_line())
	if loaded_theme == "yellow":
		self.set_theme(yellow)
	if loaded_theme == "neon":
		self.set_theme(neon)
	if loaded_theme == "blue":
		self.set_theme(blue)
	if loaded_theme == "default":
		self.set_theme(default)
	if loaded_theme == "old":
		self.set_theme(old)
	if loaded_theme == "grey":
		self.set_theme(grey)
	if loaded_theme == "red":
		self.set_theme(red)
	if loaded_theme == "green":
		self.set_theme(green)
	if loaded_theme == "alien":
		self.set_theme(alien)
	if loaded_theme == "light":
		self.set_theme(light)
	if loaded_theme == "solarized_light":
		self.set_theme(solarized_light)
	if loaded_theme == "solarized_dark":
		self.set_theme(solarized_dark)
func _on_Blue_pressed():
	self.set_theme(blue)
	$theme.set_text("blue")
	_save()
func _on_Default_pressed():
	self.set_theme(default)
	$theme.set_text('default')
	_save()
func _on_Old_pressed():
	self.set_theme(old)
	$theme.set_text('old')
	_save()
func _on_Grey_pressed():
	self.set_theme(grey)
	$theme.set_text('grey')
	_save()
func _on_Red_pressed():
	self.set_theme(red)
	$theme.set_text('red')
	_save()
func _on_Green_pressed():
	self.set_theme(green)
	$theme.set_text('green')
	_save()
func _on_Yellow_pressed():
	self.set_theme(yellow)
	$theme.set_text('yellow')
	_save()
func _on_Neon_pressed():
	self.set_theme(neon)
	$theme.set_text('neon')
	_save()
func _on_Alien_pressed():
	self.set_theme(alien)
	$theme.set_text('alien')
	_save()
func _on_Light_pressed():
	self.set_theme(light)
	$theme.set_text('light')
	_save()
func _on_Solarized_dark_pressed():
	self.set_theme(solarized_dark)
	$theme.set_text('solarized_dark')
	_save()
func _on_Solarized_light_pressed():
	self.set_theme(solarized_light)
	$theme.set_text('solarized_light')
	_save()

func _ready():
	_load()
#	self.set_theme(default)
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Neon.connect("pressed", self, "_on_Neon_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Alien.connect("pressed", self, "_on_Alien_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Light.connect("pressed", self, "_on_Light_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Solarized_dark.connect("pressed", self, "_on_Solarized_dark_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Solarized_light.connect("pressed", self, "_on_Solarized_light_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Red.connect("pressed", self, "_on_Red_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Yellow.connect("pressed", self, "_on_Yellow_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Grey.connect("pressed", self, "_on_Grey_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Green.connect("pressed", self, "_on_Green_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Blue.connect("pressed", self, "_on_Blue_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Default.connect("pressed", self, "_on_Default_pressed")
	$GameUI/UIScaler/Menu/OptionsPage/TabContainer/Theme/VBoxContainer/Old.connect("pressed", self, "_on_Old_pressed")
func _on_theme_selected(path):
	self.set_theme(path)
