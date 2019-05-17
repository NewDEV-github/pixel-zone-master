extends ItemList
func _ready():
	var achieve = File.new()
	if achieve.file_exists("user://1.save"):
		add_item("First Level Passed")
	if achieve.file_exists("user://2.save"):
		add_item("So much Snow!")
func save():
	var save_dict = {
		"Achievements" : items
	}
	return save_dict