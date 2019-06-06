extends ItemList

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func save():
	var node_data = {
				"List of avaliable updates" : items,
				"Date" : OS.get_date(),
	}
	return node_data
