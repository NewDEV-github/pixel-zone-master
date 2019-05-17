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
var ui_theme
func _on_Blue_pressed():
	self.set_theme(blue)
	ui_theme = blue
func _on_Default_pressed():
	self.set_theme(default)
	ui_theme = default
func _on_Old_pressed():
	self.set_theme(old)
	ui_theme = old
func _on_Grey_pressed():
	self.set_theme(grey)
	ui_theme = grey
func _on_Red_pressed():
	self.set_theme(red)
	ui_theme = red
func _on_Green_pressed():
	self.set_theme(green)
	ui_theme = green
func _on_Yellow_pressed():
	self.set_theme(yellow)
	ui_theme = yellow
func _on_Neon_pressed():
	self.set_theme(neon)
	ui_theme = neon
func _on_Alien_pressed():
	self.set_theme(alien)
	ui_theme = alien
func _on_Light_pressed():
	self.set_theme(light)
	ui_theme = light
func _on_Solarized_dark_pressed():
	self.set_theme(solarized_dark)
	ui_theme = solarized_dark
func _on_Solarized_light_pressed():
	self.set_theme(solarized_light)
	ui_theme = solarized_light

func _ready():
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
func _on_Save_pressed():
	save_load._on_Save()
func _on_Load_pressed():
	save_load._on_Load()
