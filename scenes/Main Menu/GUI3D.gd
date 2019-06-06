extends Control
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _on_Play_pressed():
	var exists = File.new()
	if exists.file_exists(str(documents) + "/Pixel Zone/.data/data1.data"):):
		$AnimationTree.play("new")
	if not exists.file_exists(str(documents) + "/Pixel Zone/.data/data1.data"):):
		background_load.load_scene("res://scenes/stages/tutorial.tscn")

func _on_Quit_pressed():
	get_tree().quit()
	
	settings.connect("window_size_changed", self, "_on_window_size_changeds")
	var c = File.new()
	if c.file_exists("user://multi/lobby.tscn"):
		$TextureRect/WindowDialog/ItemList.add_item("MultiPlayer Mode")
	if c.file_exists("user://dlc_2/Drum & Bass.ogg"):
		$TextureRect/WindowDialog/ItemList.add_item("Custom Music")
	if c.file_exists("user://dlc_1/stage_dlc1.tscn"):
		$TextureRect/WindowDialog/ItemList.add_item("Power Up!")
	if c.file_exists("user://report_bug/BugReporter.tscn"):
		$TextureRect/WindowDialog/ItemList.add_item("Report a Bug")
	if c.file_exists("user://dlc_3/stage.tscn"):
		$TextureRect/WindowDialog/ItemList.add_item("Character Selection")


func _on_Play7_pressed():
	OS.shell_open("mailto:karoltomaszewskimusic@gmail.com;olo2tom@o2.pl;?subject=I Found a Bug in Pixel Zone")

func _on_Play6_pressed():
	$TextureRect/WindowDialog.popup_centered()

func _on_PP_pressed():
	OS.shell_open("https://masterpolska.pl.tl/Polityka--Prywatno%26%23347%3Bci.htm")

func _on_Licenses_pressed():
	$TextureRect/LicenseSelector.popup_centered()

func _on_Play8_pressed():
	get_tree().change_scene("res://dlcs/multi/lobby.tscn")



func _on_WindowDialog3_popup_hide():
	$TextureRect/WindowDialog2.hide()

func _on_close_pressed():
	$TextureRect/WindowDialog2.hide()


func _on_ImportMod_pressed():
	$ModeSelect.popup_centered()


func _on_ModeSelect_file_selected(path):
	ProjectSettings.load_resource_pack(path)
	get_tree().change_scene("res://mod.tscn")
	if FAILED:
		log_file.error()






func _on_VScrollBar_value_changed(value):
	$TextureRect/Control/control.set_position(Vector2(0, -(value*10)))
