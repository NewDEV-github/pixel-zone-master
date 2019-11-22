extends Control
var scene
func _process(delta):
	if $connect/Control/CheckButton.pressed == true:
		$connect/Control/ROBI.show()
		$connect/Control/ROBI2.show()
		$connect/join.hide()
	if $connect/Control/CheckButton.pressed == false:
		$connect/Control/ROBI.hide()
		$connect/Control/ROBI2.hide()
		$connect/join.show()
func _ready():
	# Called every time the node is added to the scene.
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

func _on_Button_pressed():
	$Control.show()
	$Control/Control.show()
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)


func _on_signup_pressed():
	var email = $Control/Control2/VBoxContainer/email.text
	var password = $Control/Control2/VBoxContainer/password.text
	var password_confirm = $Control/Control2/VBoxContainer/password2.text
	if str(password) == str(password_confirm):
		Firebase.Auth.signup_with_email_and_password(email, password)
		$Control/Control2.hide()
		$Control.hide()

func _on_Button4_pressed():
	OS.shell_open("https://masterpolska123.github.io/home/login.html")


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

