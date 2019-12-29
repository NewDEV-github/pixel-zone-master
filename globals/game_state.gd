
extends Node

# Member variables
var save = File.new()
var points = 0
func _save():
	save.open_encrypted_with_pass("user://other_saves/0.save", File.WRITE, '3087283')
	save.store_line(str(points))
	save.close()
func _load():
	save.open_encrypted_with_pass("user://other_saves/0.save", File.READ, '3087283')
	var loaded_coins = save.get_line()
	points += float(str(loaded_coins))
func _ready():
	_load()
