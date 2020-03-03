extends Node

const CommonErrors = preload("../common/CommonErrors.gd")
const SWLogger = preload("../utils/SWLogger.gd")
const UUID = preload("../utils/UUID.gd")

# legacy signals
signal scores_received
signal position_received
signal score_posted

# new signals
signal sw_scores_received
signal sw_position_received
signal sw_score_posted
signal sw_leaderboard_wiped

var scores = []
var local_scores = []
var score_id = ""
var position = 0

#var request_timeout = 3
#var request_timer = null

# latest number of scores to be fetched from the backend
var latest_max = 10

var ScorePosition = null
var HighScores = null
var PostScore = null
var WipeLeaderboard = null

# wekrefs
var wrScorePosition = null
var wrHighScores = null
var wrPostScore = null
var wrWipeLeaderboard = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#connect("request_completed", self, "_on_Scores_request_completed")
	#setup_request_timer()
	
func get_score_position(score):
	ScorePosition = HTTPRequest.new()
	wrScorePosition = weakref(ScorePosition)
	if OS.get_name() != "HTML5":
		ScorePosition.set_use_threads(true)
	get_tree().get_root().add_child(ScorePosition)
	ScorePosition.connect("request_completed", self, "_on_GetScorePosition_request_completed")
	SWLogger.info("Calling SilentWolf to get score position")
	var game_id = SilentWolf.config.game_id
	var game_version = SilentWolf.config.game_version
	var api_key = SilentWolf.config.api_key
	var payload = { "score": score, "game_id": game_id, "game_version": game_version }
	var query = JSON.print(payload)
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	ScorePosition.request("https://api.silentwolf.com/get_score_position", headers, true, HTTPClient.METHOD_POST, query)
	return self

func get_high_scores(maximum=10):
	HighScores = HTTPRequest.new()
	wrHighScores = weakref(HighScores)
	if OS.get_name() != "HTML5":
		HighScores.set_use_threads(true)
	get_tree().get_root().add_child(HighScores)
	HighScores.connect("request_completed", self, "_on_GetHighScores_request_completed")
	SWLogger.info("Calling SilentWolf backend to get scores...")
	# resetting the latest_number value in case the first requests times out, we need to request the same amount of top scores in the retry
	latest_max = maximum
	var api_key_header = "x-api-key: " + SilentWolf.config.api_key
	var headers = [api_key_header]
	var game_id = SilentWolf.config.game_id
	var game_version = SilentWolf.config.game_version
	var request_url = "https://api.silentwolf.com/get_top_scores/" + str(game_id) + "?version=" + str(game_version) + "&max=" + str(maximum)
	HighScores.request(request_url, headers)
	# setup request timer to track potential timeouts (and retry in case of timeout)
	#request_timer.start()
	# needed to call yield function - needs to return an object
	return self
	
func add_to_local_scores(game_result):
	var local_score = { "score_id": game_result.score_id, "game_id_version" : game_result.game_id + ";"  + game_result.game_version, "player_name": game_result.player_name, "score": game_result.score }
	local_scores.append(local_score)
	SWLogger.debug("local scores: " + str(local_scores))
	
func persist_score(player_name, score):
	if player_name == null or player_name == "":
		SWLogger.error("SilentWolf.scores.persist_score - please enter a valid player name")
	else:
		PostScore = HTTPRequest.new()
		wrPostScore = weakref(PostScore)
		if OS.get_name() != "HTML5":
			PostScore.set_use_threads(true)
		get_tree().get_root().add_child(PostScore)
		PostScore.connect("request_completed", self, "_on_PostNewScore_request_completed")
		SWLogger.info("Calling SilentWolf backend to post new score...")
		var game_id = SilentWolf.config.game_id
		var game_version = SilentWolf.config.game_version
		var api_key = SilentWolf.config.api_key
		var score_uuid = UUID.generate_uuid_v4()
		score_id = score_uuid
		var payload = { "score_id" : score_id, "player_name" : player_name, "game_id": game_id, "game_version": game_version, "score": score }
		# also add to local scores
		add_to_local_scores(payload)
		var query = JSON.print(payload)
		var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
		var use_ssl = true
		PostScore.request("https://api.silentwolf.com/post_new_score", headers, use_ssl, HTTPClient.METHOD_POST, query)
		return self
		
# Deletes all your scores for your game and version
# Scores are permanently deleted, no going back!
func wipe_leaderboard():
	WipeLeaderboard = HTTPRequest.new()
	wrWipeLeaderboard = weakref(WipeLeaderboard)
	if OS.get_name() != "HTML5":
		WipeLeaderboard.set_use_threads(true)
	get_tree().get_root().add_child(WipeLeaderboard)
	WipeLeaderboard.connect("request_completed", self, "_on_WipeLeaderboard_request_completed")
	SWLogger.info("Calling SilentWolf backend to wipe leaderboard...")
	var game_id = SilentWolf.config.game_id
	var game_version = SilentWolf.config.game_version
	var api_key = SilentWolf.config.api_key
	var payload = { "game_id": game_id, "game_version": game_version }
	var query = JSON.print(payload)
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	var use_ssl = true
	WipeLeaderboard.request("https://api.silentwolf.com/wipe_leaderboard", headers, use_ssl, HTTPClient.METHOD_POST, query)
	return self
		
func _on_GetHighScores_request_completed(result, response_code, headers, body):
	SWLogger.info("GetHighScores request completed")
	var status_check = CommonErrors.check_status_code(response_code)
	#print("client status: " + str(HighScores.get_http_client_status()))
	#HighScores.queue_free()
	SilentWolf.free_request(wrHighScores, HighScores)
	SWLogger.debug("response headers: " + str(response_code))
	SWLogger.debug("response headers: " + str(headers))
	SWLogger.debug("response body: " + str(body.get_string_from_utf8()))
	
	if status_check:
		var json = JSON.parse(body.get_string_from_utf8())
		var response = json.result
		if "message" in response.keys() and response.message == "Forbidden":
			SWLogger.error("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
		else:
			SWLogger.info("SilentWolf get high score success")
			if "top_scores" in response:
				scores = response.top_scores
			emit_signal("sw_scores_received", scores)
			emit_signal("scores_received", scores)
	#var retries = 0
	#request_timer.stop()
		
func _on_PostNewScore_request_completed(result, response_code, headers, body):
	SWLogger.info("PostNewScore request completed")
	var status_check = CommonErrors.check_status_code(response_code)
	#PostScore.queue_free()
	SilentWolf.free_request(wrPostScore, PostScore)
	SWLogger.debug("response headers: " + str(response_code))
	SWLogger.debug("response headers: " + str(headers))
	SWLogger.debug("response body: " + str(body.get_string_from_utf8()))
	
	if status_check:
		var json = JSON.parse(body.get_string_from_utf8())
		var response = json.result
		if "message" in response.keys() and response.message == "Forbidden":
			SWLogger.error("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
		else:
			SWLogger.info("SilentWolf post score success: " + str(response_code))
			emit_signal("sw_score_posted")
			emit_signal("score_posted")
				
func _on_GetScorePosition_request_completed(result, response_code, headers, body):
	SWLogger.info("GetScorePosition request completed")
	var status_check = CommonErrors.check_status_code(response_code)
	#ScorePosition.queue_free()
	SilentWolf.free_request(wrScorePosition, ScorePosition)
	SWLogger.debug("response headers: " + str(response_code))
	SWLogger.debug("response headers: " + str(headers))
	SWLogger.debug("response body: " + str(body.get_string_from_utf8()))
	
	if status_check:
		var json = JSON.parse(body.get_string_from_utf8())
		var response = json.result
		if "message" in response.keys() and response.message == "Forbidden":
			SWLogger.error("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
		else:
			SWLogger.info("SilentWolf find score position success.")
			position = response.position
			emit_signal("sw_position_received", position)
			emit_signal("position_received", position)
			
func _on_WipeLeaderboard_request_completed(result, response_code, headers, body):
	SWLogger.info("WipeLeaderboard request completed")
	var status_check = CommonErrors.check_status_code(response_code)
	#WipeLeaderboard.queue_free()
	SilentWolf.free_request(wrWipeLeaderboard, WipeLeaderboard)
	SWLogger.debug("response headers: " + str(response_code))
	SWLogger.debug("response headers: " + str(headers))
	SWLogger.debug("response body: " + str(body.get_string_from_utf8()))
	
	if status_check:
		var json = JSON.parse(body.get_string_from_utf8())
		var response = json.result
		if "message" in response.keys() and response.message == "Forbidden":
			SWLogger.error("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
		else:
			SWLogger.info("SilentWolf wipe leaderboard success.")
			emit_signal("sw_leaderboard_wiped")
