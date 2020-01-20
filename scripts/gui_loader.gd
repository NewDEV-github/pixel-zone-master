extends Control

# Declare member variables here. Examples:
# var a = 2

# Called when the node enters the scene tree for the first time.
func _ready():
#	var date_day = str(OS.get_date().day)
	var date_month = str(OS.get_date().month)
#	var date_year = str(OS.get_date().year)
	var file = File.new()
	file.open('user://date.dat', File.WRITE)
	file.store_line(str(date_month))
	background_load.load_scene("res://scenes/Main Menu/GUI.tscn")
	if OS.get_name() == 'Android':
		OS.alert('Permissions!', "We need permittions to save game data on your device. Allow it in Application's settings. Thanks!")
