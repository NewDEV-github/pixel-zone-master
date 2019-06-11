
extends Node

# Member variables
 
var points = 0
var level = 0
func _save():
	var save = File.new()
	save.open("user://save.save", File.WRITE)
	save.store_line(to_json(points))
func _load():
	var load_ = File.new()
	load_.open("user://save.save", File.READ)
	var loaded_coins = parse_json(load_.get_line())
	points += loaded_coins
func _ready():
	_load()