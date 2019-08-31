
extends Node

# Member variables
var save = File.new()
var points = 0
var points_temp = 0
func _save():
	save.open_encrypted_with_pass("user://other_saves/0.save", File.WRITE, str(3087283))
	save.store_line(str(points))
func _load():
	var load_ = File.new()
	load_.open_encrypted_with_pass("user://other_saves/0.save", File.READ, str(3087283))
	var loaded_coins = parse_json(load_.get_line())
	points += float(str(loaded_coins))
func _ready():
	_load()
