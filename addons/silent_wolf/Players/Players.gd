extends Node

signal player_data_received
signal player_data_posted
signal player_data_removed

var GetPlayerData = null
var PushPlayerData = null
var RemovePlayerData = null

var player_name = null
var player_data = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_player_data(new_player_data):
	player_data = new_player_data

func clear_player_data():
	player_name = null
	player_data = null
	
func get_stats():
	var stats = null
	if player_data:
		stats = {
			"strength": player_data.strength,
			"speed": player_data.speed,
			"reflexes": player_data.reflexes,
			"max_health": player_data.max_health,
			"career": player_data.career
		}
	return stats
	
func get_inventory():
	var inventory = null
	if player_data:
		inventory = {
			"weapons": player_data.weapons,
			"gold": player_data.gold
		}
	return inventory

func get_player_data(player_name):
	GetPlayerData = HTTPRequest.new()
	get_tree().get_root().add_child(GetPlayerData)
	GetPlayerData.connect("request_completed", self, "_on_GetPlayerData_request_completed")
	print("Calling SilentWolf to get player data")
	var game_id = SilentWolf.config.game_id
	var game_version = SilentWolf.config.game_version
	var api_key = SilentWolf.config.api_key
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	GetPlayerData.request("https://api.silentwolf.com/get_player_data/" + game_id + "/" + player_name, headers, true, HTTPClient.METHOD_GET)
	return self
	
func post_player_data(player_name, player_data, overwrite=true):
	PushPlayerData = HTTPRequest.new()
	get_tree().get_root().add_child(PushPlayerData)
	PushPlayerData.connect("request_completed", self, "_on_PushPlayerData_request_completed")
	print("Calling SilentWolf to post player data")
	var game_id = SilentWolf.config.game_id
	var game_version = SilentWolf.config.game_version
	var api_key = SilentWolf.config.api_key
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	var payload = { "game_id": game_id, "game_version": game_version, "player_name": player_name, "player_data": player_data, "overwrite": overwrite }
	var query = JSON.print(payload)
	PushPlayerData.request("https://api.silentwolf.com/push_player_data", headers, true, HTTPClient.METHOD_POST, query)
	return self
	
func delete_player_weapons(player_name):
	var weapons = { "Weapons": [] }
	delete_player_data(player_name, weapons)
	
func remove_player_money(player_name):
	var money = { "Money": 0 }
	delete_player_data(player_name, money)
	
func delete_player_items(player_name, item_name):
	var item = { item_name: "" }
	delete_player_data(player_name, item)
	
func delete_all_player_data(player_name):
	delete_player_data(player_name, "")
	
func delete_player_data(player_name, player_data):
	RemovePlayerData = HTTPRequest.new()
	get_tree().get_root().add_child(RemovePlayerData)
	RemovePlayerData.connect("request_completed", self, "_on_RemovePlayerData_request_completed")
	print("Calling SilentWolf to remove player data")
	var game_id = SilentWolf.config.game_id
	var api_key = SilentWolf.config.api_key
	var headers = ["Content-Type: application/json", "x-api-key: " + api_key]
	var payload = { "game_id": game_id, "player_name": player_name, "player_data": player_data }
	var query = JSON.print(payload)
	RemovePlayerData.request("https://api.silentwolf.com/remove_player_data", headers, true, HTTPClient.METHOD_POST, query)
	return self
	
func _on_GetPlayerData_request_completed(result, response_code, headers, body):
	if is_instance_valid(GetPlayerData): # GetPlayerData != null and GetPlayerData.is_inside_tree():
		GetPlayerData.queue_free()
	var json = JSON.parse(body.get_string_from_utf8())
	var response = json.result
	if "message" in response.keys() and response.message == "Forbidden":
		print("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/playerdata")
	else:
		print("SilentWolf get player data success")
		player_name = response.player_name
		player_data = response.player_data
		print("Request completed: Player data: " + str(player_data))
		emit_signal("player_data_received", player_name, player_data)
		
func _on_PushPlayerData_request_completed(result, response_code, headers, body):
	if  is_instance_valid(PushPlayerData): #PushPlayerData != null and PushPlayerData.is_inside_tree():
		PushPlayerData.queue_free()
	var json = JSON.parse(body.get_string_from_utf8())
	var response = json.result
	if "message" in response.keys() and response.message == "Forbidden":
		print("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/playerdata")
	else:
		print("SilentWolf post player data score success: " + str(response_code))
		var player_name = response.player_name
		emit_signal("player_data_posted", player_name)
		
func _on_RemovePlayerData_request_completed(result, response_code, headers, body):
	if  is_instance_valid(RemovePlayerData): 
		RemovePlayerData.queue_free()
	var json = JSON.parse(body.get_string_from_utf8())
	var response = json.result
	if "message" in response.keys() and response.message == "Forbidden":
		print("You are not authorized to call the SilentWolf API - check your API key configuration: https://silentwolf.com/playerdata")
	else:
		print("SilentWolf post player data score success: " + str(response_code))
		var player_name = response.player_name
		# return player_data after (maybe partial) removal
		var player_data = response.player_data
		emit_signal("player_data_removed", player_name, player_data)