extends Node

onready var Auth = HTTPRequest.new()
onready var Database = Node.new()

# Configuration used by all files in this project
# These values can be found in your Firebase Project
# See the README on Github for how to access
onready var config = {
	"apiKey": "AIzaSyD8_6IBQeP8DZKCOa5YLhDkqkFRLdgqHqY",
	"authDomain": "pixel-zone-8d8e4.firebaseapp.com",
	"databaseURL": "https://pixel-zone-8d8e4.firebaseio.com",
	"projectId": "pixel-zone-8d8e4",
	"storageBucket": "pixel-zone-8d8e4.appspot.com",
	"messagingSenderId": "1078122097377",
	"appId": "1:1078122097377:web:4c123f6c5f212952"
  }

func _ready():
	Auth.set_script(preload("res://addons/GDFirebase/FirebaseAuth.gd"))
	Database.set_script(preload("res://addons/GDFirebase/FirebaseDatabase.gd"))
	Auth.set_config(config)
	Database.set_config(config)
	add_child(Auth)
	add_child(Database)
	Auth.connect("login_succeeded", Database, "_on_FirebaseAuth_login_succeeded")
