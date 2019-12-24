extends Node

const CommonErrors = preload("../common/CommonErrors.gd")
const SWLogger = preload("../utils/SWLogger.gd")

signal login_succeeded
signal login_failed
signal logout_succeeded
signal registration_succeeded
signal registration_failed
signal player_logged_out

var tmp_username = null
var logged_in_player = null
var token = null
var id_token = null

var RegisterPlayer = null
var LoginPlayer = null

var login_timeout = 0
var login_timer = null

func _ready():
	if SilentWolf.auth_config.has("session_duration") and typeof(SilentWolf.auth_config.session_duration) == 2:
		login_timeout = SilentWolf.auth_config.session_duration
	else:
		login_timeout = 3600
	SWLogger.info("SilentWolf ogin timeout: " + str(login_timeout))
	setup_login_timer()
	
	
func register_player(player_name, email, password, confirm_password):
	tmp_username = player_name
	RegisterPlayer = HTTPRequest.new()
	get_tree().get_root().add_child(RegisterPlayer)
	RegisterPlayer.connect("request_completed", self, "_on_RegisterPlayer_request_completed")
	SWLogger.info("Calling SilentWolf to register a player")
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
	SWLogger.info("Calling SilentWolf to log in a player")
	var game_id = SilentWolf.config.game_id
	var api_key = SilentWolf.config.api_key
	var payload = { "game_id": game_id, "username": username, "password": password }
	var query = JSON.print(payload)
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	#print("login_player headers: " + str(headers))
	LoginPlayer.request("https://api.silentwolf.com/login_player", headers, true, HTTPClient.METHOD_POST, query)
	return self
	
func logout_player():
	logged_in_player = null
	# remove any player data if present
	SilentWolf.Players.clear_player_data()
	emit_signal("logout_succeeded")
		
				
func _on_LoginPlayer_request_completed( result, response_code, headers, body ):
	SWLogger.info("LoginPlayer request completed")
	var status_check = CommonErrors.check_status_code(response_code)
	LoginPlayer.queue_free()
	SWLogger.debug("response headers: " + str(response_code))
	SWLogger.debug("response headers: " + str(headers))
	SWLogger.debug("response body: " + str(body.get_string_from_utf8()))
	
	if status_check:
		var json = JSON.parse(body.get_string_from_utf8())
		var response = json.result
		if "message" in response.keys() and response.message == "Forbidden":
			SWLogger.error("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
		else:
			SWLogger.info("SilentWolf login player success? : " + str(response.success))
			# TODO: get JWT token and store it
			# send a different signal depending on login success or failure
			if response.success:
				token = response.swtoken
				#id_token = response.swidtoken
				SWLogger.debug("token: " + token)
				logged_in_player  = tmp_username
				emit_signal("login_succeeded")
			else:
				emit_signal("login_failed", response.error)
	
func _on_RegisterPlayer_request_completed( result, response_code, headers, body ):
	SWLogger.info("RegisterPlayer request completed")
	var status_check = CommonErrors.check_status_code(response_code)
	RegisterPlayer.queue_free()
	SWLogger.debug("response headers: " + str(response_code))
	SWLogger.debug("response headers: " + str(headers))
	SWLogger.debug("response body: " + str(body.get_string_from_utf8()))
	
	if status_check:
		var json = JSON.parse(body.get_string_from_utf8())
		var response = json.result
		SWLogger.debug("reponse: " + str(response))
		if "message" in response.keys() and response.message == "Forbidden":
			SWLogger.error("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
		else:
			SWLogger.info("SilentWolf create new player success? : " + str(response.success))
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
	
# TODO: we shouldn't remember the logged_in_player or a token. 
# Rather we should remember a long generated string that matches
# the user in the database.
func save_session(logged_in_player, refresh_token):
	var session = File.new()
	session.open("user://swsession.save", File.WRITE)
	var session_data = {
		"logged_in_player": logged_in_player,
		"refresh_token": id_token
	}
	session.store_line(to_json(session_data))
	session.close()
	
# TODO: load long string and send it back to the server to auto-login user
func load_session():
	var session = File.new()
	session.open("user://swsession.save", File.WRITE)
	var session_data = {
		"logged_in_player": logged_in_player,
		"refresh_token": id_token
	}
	session.store_line(to_json(session_data))
	session.close()
