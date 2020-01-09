extends Node

const CommonErrors = preload("../common/CommonErrors.gd")
const SWLogger = preload("../utils/SWLogger.gd")

signal sw_login_succeeded
signal sw_login_failed
signal sw_logout_succeeded
signal sw_registration_succeeded
signal sw_registration_failed
signal sw_session_check_complete

var tmp_username = null
var logged_in_player = null
var token = null
var id_token = null

var RegisterPlayer = null
var LoginPlayer = null
var ValidateSession = null

var login_timeout = 0
var login_timer = null

var complete_session_check_wait_timer

func _ready():
	if SilentWolf.auth_config.has("session_duration") and typeof(SilentWolf.auth_config.session_duration) == 2:
		login_timeout = SilentWolf.auth_config.session_duration
	else:
		login_timeout = 3600
	SWLogger.info("SilentWolf login timeout: " + str(login_timeout))
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
	
func login_player(username, password, remember_me=false):
	tmp_username = username
	LoginPlayer = HTTPRequest.new()
	print("get_tree().get_root(): " + str(get_tree().get_root()))
	get_tree().get_root().add_child(LoginPlayer)
	LoginPlayer.connect("request_completed", self, "_on_LoginPlayer_request_completed")
	SWLogger.info("Calling SilentWolf to log in a player")
	var game_id = "PixelZone"
	var api_key = "YZ7CY9acpN9NIZ9ebKXd43NO4FVCJFkR8rkF2cO4"
	var payload = { "game_id": game_id, "username": username, "password": password, "remember_me": str(remember_me) }
	var query = JSON.print(payload)
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	#print("login_player headers: " + str(headers))
	LoginPlayer.request("https://api.silentwolf.com/login_player", headers, true, HTTPClient.METHOD_POST, query)
	return self
	
func logout_player():
	logged_in_player = null
	# remove any player data if present
	SilentWolf.Players.clear_player_data()
	# remove stored session if any
	remove_stored_session()
	emit_signal("sw_logout_succeeded")
				
func _on_LoginPlayer_request_completed( result, response_code, headers, body ):
	SWLogger.info("LoginPlayer request completed")
	var status_check = CommonErrors.check_status_code(response_code)
#	LoginPlayer.queue_free()
	SWLogger.debug("response headers: " + str(response_code))
	SWLogger.debug("response headers: " + str(headers))
	#SWLogger.debug("response body: " + str(body.get_string_from_utf8()))
	
	if status_check:
		var json = JSON.parse(body.get_string_from_utf8())
		var response = json.result
		if "message" in response.keys() and response.message == "Forbidden":
			SWLogger.error("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
		else:
			if "lookup" in response.keys():
				print("remember me lookup: " + str(response.lookup))
				save_session(response.lookup, response.validator)
			if "validator" in response.keys():
				print("remember me validator: " + str(response.validator))
			SWLogger.info("SilentWolf login player success? : " + str(response.success))
			# TODO: get JWT token and store it
			# send a different signal depending on login success or failure
			if response.success:
				token = response.swtoken
				#id_token = response.swidtoken
				SWLogger.debug("token: " + token)
				logged_in_player  = tmp_username
				emit_signal("sw_login_succeeded")
			else:
				emit_signal("sw_login_failed", response.error)
	
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
				emit_signal("sw_registration_succeeded")
			else:
				emit_signal("sw_registration_failed", response.error)
			
func setup_login_timer():
	login_timer = Timer.new()
	login_timer.set_one_shot(true)
	login_timer.set_wait_time(login_timeout)
	login_timer.connect("timeout", self, "on_login_timeout_complete")
	add_child(login_timer)

func on_login_timeout_complete():
	logout_player()
	
# store lookup (not logged in player name) and validator in local file
func save_session(lookup, validator):
	var session = File.new()
	session.open("user://swsession.save", File.WRITE)
	var session_data = {
		"lookup": lookup,
		"validator": validator
	}
	SWLogger.debug("Saving SilentWolf session: " + str(session_data))
	session.store_line(to_json(session_data))
	session.close()
	
func remove_stored_session():
	var session = File.new()
	session.open("user://swsession.save", File.WRITE)
	var session_data = {}
	SWLogger.debug("Removing SilentWolf session if any: " + str(session_data))
	session.store_line(to_json(session_data))
	session.close()
	
# reload lookup and validator and send them back to the server to auto-login user
func load_session():
	var sw_session_data = null
	var session = File.new()
	if session.file_exists("user://swsession.save"):
		SWLogger.debug("Found SilentWolf session.")
		session.open("user://swsession.save", File.READ)
		var data = parse_json(session.get_as_text())
		SWLogger.debug("SilentWolf session data: " + str(data))
		# should we make sure to always process the following line?
		if typeof(data) == TYPE_DICTIONARY and "lookup" in data:
			sw_session_data = data
		else:
			SWLogger.debug("Invalid SilentWolf session data")
	else:
		SWLogger.debug("No local SilentWolf session stored")
	session.close()
	SWLogger.debug("sw_session_data: " + str(sw_session_data))
	return sw_session_data
	
func auto_login_player():
	var sw_session_data = load_session()
	if sw_session_data:
		SWLogger.debug("Found saved SilentWolf session data, attempting autologin...")
		var lookup = sw_session_data.lookup
		var validator = sw_session_data.validator
		# whether successful or not, in the end the "sw_session_check_complete" signal will be emitted
		validate_player_session(lookup, validator)
	else:
		SWLogger.debug("No saved SilentWolf session data, so no autologin will be performed")
		# the following is needed to delay the emission of the signal just a little bit, otherwise the signal is never received!
		setup_complete_session_check_wait_timer()
		complete_session_check_wait_timer.start()
	return self
	
# Signal can't be emitted directly from auto_login_player() function
# otherwise it won't connect back to calling script
func complete_session_check(return_value=null):
	SWLogger.debug("emitting signal....")
	emit_signal("sw_session_check_complete", return_value)
		
func validate_player_session(lookup, validator, scene=get_tree().get_current_scene()):
	ValidateSession = HTTPRequest.new()
	scene.add_child(ValidateSession)
	ValidateSession.connect("request_completed", self, "_on_ValidateSession_request_completed")
	SWLogger.info("Calling SilentWolf to validate an existing player session")
	var game_id = SilentWolf.config.game_id
	var api_key = SilentWolf.config.api_key
	var payload = { "game_id": game_id, "lookup": lookup, "validator": validator }
	SWLogger.debug("Validate session payload: " + str(payload))
	var query = JSON.print(payload)
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	ValidateSession.request("https://api.silentwolf.com/validate_remember_me", headers, true, HTTPClient.METHOD_POST, query)
	return self
	
func _on_ValidateSession_request_completed( result, response_code, headers, body ):
	SWLogger.info("SilentWolf - ValidateSession request completed")
	var status_check = CommonErrors.check_status_code(response_code)
	ValidateSession.queue_free()
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
			SWLogger.info("SilentWolf validate session success? : " + str(response.success))
			if response.success:
				logged_in_player  = response.player_name
				complete_session_check(logged_in_player)
			else:
				complete_session_check(response.error)

func setup_complete_session_check_wait_timer():
	complete_session_check_wait_timer = Timer.new()
	complete_session_check_wait_timer.set_one_shot(true)
	complete_session_check_wait_timer.set_wait_time(0.01)
	complete_session_check_wait_timer.connect("timeout", self, "complete_session_check")
	add_child(complete_session_check_wait_timer)
