extends Panel

var current_page = null
var visible_connect

func _ready():
	visible_connect = connect("visibility_changed", self, "_on_visibility_changed")
func _on_visibility_changed():
	get_tree().paused = visible
	if visible:
		globals.play_bgm("Menu", true)
		globals.play_bgm("Level", false)
	else:
		globals.play_bgm("Menu", false)
		globals.play_bgm("Level", true)

func show_page(node):
	if current_page != null:
		current_page.hide()
	node.show()
	current_page = node

func _on_Quit_pressed():
	get_tree().quit()

# when preesed "Return" or "No" button in Quit Page
func _on_Return_pressed():
	hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		visible = !visible
		delta -=1

func _on_Options_pressed():
	show_page($OptionsPage)
#
#func _on_window_minimized_changed(value):
#	show()
#

func _on_Stats_pressed():
	show_page($StatsPage)








func _on_Controls_pressed():
	show_page($ControlsPage)
func _on_Load_pressed():
	var con = File.new()
	if con.file_exists("user://1.save") and not con.file_exists("user://2.save") and not con.file_exists("user://3.save") and not con.file_exists("user://4.save"):
		background_load.load_scene("scenes/stages/pixel_adventure/stage2.tscn")
	if con.file_exists("user://2.save") and con.file_exists("user://1.save") and not con.file_exists("user://3.save") and not con.file_exists("user://4.save"):
		background_load.load_scene("scenes/stages/ice_cap_adventure/ice_01.tscn")
	if con.file_exists("user://3.save") and con.file_exists("user://1.save") and con.file_exists("user://3.save") and not con.file_exists("user://4.save"):
		background_load.load_scene("scenes/stages/ice_cap_adventure/ice_02.tscn")
	if con.file_exists("user://4.save") and con.file_exists("user://3.save") and con.file_exists("user://1.save") and con.file_exists("user://3.save"):
		background_load.load_scene("scenes/stages/ice_cap_adventure/ice_03.tscn")
	if con.file_exists("user://1_dlc1.save") and not con.file_exists("user://2_dlc1.save") and not con.file_exists("user://3_dlc1.save") and not con.file_exists("user://4_dlc1.save") and con.file_exists("user://dlc_1/stage_dlc1.tscn"):
		background_load.load_scene("user://dlc_1/stage2_dlc1.tscn")
	if con.file_exists("user://2_dlc1.save") and con.file_exists("user://1_dlc1.save") and not con.file_exists("user://3_dlc1.save") and not con.file_exists("user://4_dlc1.save") and con.file_exists("user://dlc_1/stage_dlc1.tscn"):
		background_load.load_scene("user://dlc_1/ice_01_dlc1.tscn")
	if con.file_exists("user://3_dlc1.save") and con.file_exists("user://1_dlc1.save") and con.file_exists("user://3_dlc1.save") and not con.file_exists("user://4_dlc1.save") and con.file_exists("user://dlc_1/stage_dlc1.tscn"):
		background_load.load_scene("user://dlc_1/ice_02_dlc1.tscn")
	if con.file_exists("user://4_dlc1.save") and con.file_exists("user://3_dlc1.save") and con.file_exists("user://1_dlc1.save") and con.file_exists("user://3_dlc1.save") and con.file_exists("user://dlc_1/stage_dlc1.tscn"):
		background_load.load_scene("user://dlc_1/ice_03_dlc1.tscn")
func _on_Achievements_pressed():
	$AchievementsPage.show()


func _on_eastereggtimer_timeout():
	$easteregg.hide()
