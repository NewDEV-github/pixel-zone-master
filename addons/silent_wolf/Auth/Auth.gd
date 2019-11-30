extends Node

signal login_succeeded
signal login_failed
signal registration_succeeded
signal registration_failed
signal player_logged_out

var tmp_username = null
var logged_in_player = null

var RegisterPlayer = null
var LoginPlayer = null

var login_timeout = 3600
var login_timer = null

func _ready():
	setup_login_timer()
	
func register_player(player_name, email, password, confirm_password):
	tmp_username = player_name
	RegisterPlayer = HTTPRequest.new()
	get_tree().get_root().add_child(RegisterPlayer)
	RegisterPlayer.connect("request_completed", self, "_on_RegisterPlayer_request_completed")
	print("Calling SilentWolf to regsiter a player")
	var game_id = SilentWolf.config.game_id
	var game_version = SilentWolf.config.game_version
	var api_key = SilentWolf.config.api_key
	var payload = { "game_id": game_id, "player_name": player_name, "email":  email, "password": password, "confirm_password": confirm_password }
	var query = JSON.print(payload)
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	#print("register_player headers: " + str(headers))
	RegisterPlayer.request("https://api.silentwolf.com/create_new_player", headers, true, HTTPClient.METHOD_POST, query)
	return self
	
func login_player(username, password):
	tmp_username = username
	LoginPlayer = HTTPRequest.new()
	get_tree().get_root().add_child(LoginPlayer)
	LoginPlayer.connect("request_completed", self, "_on_LoginPlayer_request_completed")
	print("Calling SilentWolf to log in a player")
	var game_id = SilentWolf.config.game_id
	var api_key = SilentWolf.config.api_key
	var payload = { "game_id": game_id, "username": username, "password": password }
	var query = JSON.print(payload)
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	#print("login_player headers: " + str(headers))
	LoginPlayer.request("https://api.silentwolf.com/login_player", headers, true, HTTPClient.METHOD_POST, query)
	return self

				
func _on_LoginPlayer_request_completed( result, response_code, headers, body ):
	LoginPlayer.queue_free()
	var json = JSON.parse(body.get_string_from_utf8())
	var response = json.result
	if "message" in response.keys() and response.message == "Forbidden":
		print("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
	else:
		print("SilentWolf login player success? : " + str(response.success))
		# TODO: get JWT token and store it
		# send a different signal depending on login success or failure
		if response.success:
			var token = response.swtoken
			print("token: " + token)
			logged_in_player  = tmp_username
			emit_signal("login_succeeded")
		else:
			emit_signal("login_failed", response.error)
	
func _on_RegisterPlayer_request_completed( result, response_code, headers, body ):
	RegisterPlayer.queue_free()
	var json = JSON.parse(body.get_string_from_utf8())
	var response = json.result
	print("reponse: " + str(response))
	if "message" in response.keys() and response.message == "Forbidden":
		print("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
	else:
		print("SilentWolf create new player success? : " + str(response.success))
		# also get a JWT token here
		# send a different signal depending on registration success or failure
		if response.success:
			logged_in_player  = tmp_username
			emit_signal("registration_succeeded")
		else:
			emit_signal("registration_failed", response.error)
			
func setup_login_timer():
	login_timer = Timer.new()
	login_timer.set_one_shot(true)
	login_timer.set_wait_time(login_timeout)
	login_timer.connect("timeout", self, "on_login_timeout_complete")
	add_child(login_timer)

func on_login_timeout_complete():
	logged_in_player = null
	emit_signal("player_logged_out")
