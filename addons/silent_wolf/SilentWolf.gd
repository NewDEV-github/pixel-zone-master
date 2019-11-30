extends Node

onready var Scores = Node.new()
onready var Auth = Node.new()

var config = {
	"api_key": "FmKF4gtm0Z2RbUAEU62kZ2OZoYLj4PYOURAPIKEY",
	"game_id": "PixelZone",
	"game_version": "0.9.2-beta2"
}

var scores_config = {
	"open_scene_on_close": "res://scenes/Main Menu/GUI.tscn"
}

var auth_config = {
	"redirect_to_scene": "res://scenes/ScoreboardOnline"
}

func _ready():
	Scores.set_script(load("res://addons/silent_wolf/Scores/Scores.gd"))
	add_child(Scores)
	Auth.set_script(load("res://addons/silent_wolf/Auth/Auth.gd"))
	add_child(Auth)

func configure(json_config):
	config = json_config

func configure_api_key(api_key):
	config.apiKey = api_key

func configure_game_id(game_id):
	config.game_id = game_id

func configure_game_version(game_version):
	config.game_version = game_version

func configure_scores(json_scores_config):
	scores_config = json_scores_config

func configure_scores_open_scene_on_close(scene):
	scores_config.open_scene_on_close = scene
