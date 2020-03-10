extends Control
var scene
var keep_data
var os = OS.get_name()
var admob = null
var isReal = true
#func _process(delta):
#	keep_data = $Control/Control2/VBoxContainer/Keep.pressed
#	if $connect/Control/CheckButton.pressed == true:
#		$connect/Control/ROBI.show()
#		$connect/Control/ROBI2.show()
#		$connect/join.hide()
#	if $connect/Control/CheckButton.pressed == false:
#		$connect/Control/ROBI.hide()
#		$connect/Control/ROBI2.hide()
#		$connect/join.show()
func _ready():
	if(Engine.has_singleton("AdMob")):
		if str(os) == 'Android':
			admob.hideBanner()
	gamestate.connect("connection_failed", self, "_on_connection_failed")
	gamestate.connect("connection_succeeded", self, "_on_connection_success")
	gamestate.connect("player_list_changed", self, "refresh_lobby")
	gamestate.connect("game_ended", self, "_on_game_ended")
	gamestate.connect("game_error", self, "_on_game_error")
func login_show():
	$connect/Button.show()
func _on_host_pressed():
	var ip = $connect/ip.text
	if (get_node("connect/name").text == ""):
		get_node("connect/error_label").text="Invalid name!"
		return
	if (not ip.is_valid_ip_address()):
		get_node("connect/error_label").text="Invalid IPv4 address!"
		return

	get_node("connect").hide()
	get_node("players").show()
	get_node("connect/error_label").text=""

	var player_name = get_node("connect/name").text
	gamestate.host_game(player_name)
	refresh_lobby()
func _on_join_pressed():
	if (get_node("connect/name").text == ""):
		get_node("connect/error_label").text="Invalid name!"
		return

	var ip = get_node("connect/ip").text
	if (not ip.is_valid_ip_address()):
		get_node("connect/error_label").text="Invalid IPv4 address!"
		return

	get_node("connect/error_label").text=""
	get_node("connect/host").disabled=true
	get_node("connect/join").disabled=true

	var player_name = get_node("connect/name").text
	gamestate.join_game(ip, player_name)
	# refresh_lobby() gets called by the player_list_changed signal

func _on_connection_success():
	get_node("connect").hide()
	get_node("players").show()

func _on_connection_failed():
	get_node("connect/host").disabled=false
	get_node("connect/join").disabled=false
	get_node("connect/error_label").set_text("Connection failed.")

func _on_game_ended():
	show()
	get_node("connect").show()
	get_node("players").hide()
	get_node("connect/host").disabled=false
	get_node("connect/join").disabled

func _on_game_error(errtxt):
	get_node("error").dialog_text = errtxt
	get_node("error").popup_centered_minsize()

func refresh_lobby():
	var players = gamestate.get_player_list()
	players.sort()
	get_node("players/list").clear()
	get_node("players/list").add_item(gamestate.get_player_name() + " (You)")
	for p in players:
		get_node("players/list").add_item(p)

	get_node("players/start").disabled=not get_tree().is_network_server()

func _on_start_pressed():
	gamestate.begin_game()


func _on_back_pressed():
	scene = get_tree().change_scene("scenes/Main Menu/GUI.tscn")


func _on_back3_pressed():
	$connect.show()
	$players.hide()

var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _on_Button4_pressed():
	OS.shell_open("https://masterpolska123.github.io/home/auth/login")


func _on_ROBI_toggled(button_pressed):
	if button_pressed == true:
		gamestate.player_scene = load("res://dlcs/multi/player.tscn")


func _on_ROBI2_toggled(button_pressed):
	if button_pressed == true:
		gamestate.player_scene = load("res://dlcs/multi/player2.tscn")


func _on_join2_pressed():
	var os = OS.get_name()
	var ip = IP.get_local_addresses()
	print(ip)
	$connect/WindowDialog/TextEdit.add_text(str('\n' + str(ip)))
	$connect/WindowDialog.popup_centered()

func login_succeed():
#
#	print(str(auth))
	$Control/HBoxContainer/login/VBoxContainer/Label.set_text('Success!')
#	$Control/HBoxContainer/Register/VBoxContainer/Label.set_text('Success!')
	$Control.hide()
func login_failed(errorcode, errormessage):
	$Control/HBoxContainer/login/VBoxContainer/Label.set_text(str(errormessage))
	$Control/HBoxContainer/Register/VBoxContainer/Label.set_text(str(errormessage))
	$Control.show()

func _on_LoginBack_pressed():
	$Control/Control2.hide()
	$Control/Control.show()
	$Control/Control/HBoxContainer/Label.text = ''


func _on_Close_pressed():
	$Control.hide()
	$connect.show()


func _on_Control_logged_in(username):
	$connect/name.text = username
