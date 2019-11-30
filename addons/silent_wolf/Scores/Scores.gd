extends Node

const UUID = preload("../utils/UUID.gd")

signal scores_received
signal position_received
signal score_posted

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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#connect("request_completed", self, "_on_Scores_request_completed")
	#setup_request_timer()
	
func get_score_position(score):
	ScorePosition = HTTPRequest.new()
	get_tree().get_root().add_child(ScorePosition)
	ScorePosition.connect("request_completed", self, "_on_GetScorePosition_request_completed")
	print("Calling SilentWolf to get score position")
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
	get_tree().get_root().add_child(HighScores)
	HighScores.connect("request_completed", self, "_on_GetHighScores_request_completed")
	print("Calling SilentWolf backend to get scores...")
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
	print("local scores: " + str(local_scores))

func persist_score(player_name, score):
	PostScore = HTTPRequest.new()
	get_tree().get_root().add_child(PostScore)
	PostScore.connect("request_completed", self, "_on_PostNewScore_request_completed")
	print("Calling SilentWolf backend to post new score...")
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
		
func _on_GetHighScores_request_completed(result, response_code, headers, body):
	HighScores.queue_free()
	var json = JSON.parse(body.get_string_from_utf8())
	var response = json.result
	if "message" in response.keys() and response.message == "Forbidden":
		print("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
	else:
		print("SilentWolf get high score success")
		scores = response.top_scores
		emit_signal("scores_received", scores)
	#var retries = 0
	#request_timer.stop()
		
func _on_PostNewScore_request_completed(result, response_code, headers, body):
	PostScore.queue_free()
	var json = JSON.parse(body.get_string_from_utf8())
	var response = json.result
	if "message" in response.keys() and response.message == "Forbidden":
		print("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
	else:
		print("SilentWolf post score success: " + str(response_code))
		emit_signal("score_posted")
				
func _on_GetScorePosition_request_completed(result, response_code, headers, body):
	ScorePosition.queue_free()
	print("GetScorePosition request completed")
	var json = JSON.parse(body.get_string_from_utf8())
	var response = json.result
	if "message" in response.keys() and response.message == "Forbidden":
		print("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/leaderboard")
	else:
		print("SilentWolf find score position success.")
		position = response.position
		emit_signal("position_received", position)
				
#func setup_request_timer():
#	request_timer = Timer.new()
#	request_timer.set_one_shot(true)
#	request_timer.set_wait_time(request_timeout)
#	request_timer.connect("timeout", self, "on_request_timeout_complete")
#	add_child(request_timer)

#func on_request_timeout_complete():
	# check underlying HTTPClient status
	#print("Request is taking a while, underlying HTTPClient status: " + str(get_http_client_status()))
	#print("Retrying get high scores...")
	# retry once if relevant, use the latest number of scores to be fetched (set on the previous request)
	#request_high_scores(latest_max)
