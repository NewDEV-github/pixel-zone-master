extends WindowDialog

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _select_tile(path):
	node = preload('path').instance()
	node.set_name('icon' + str(number))
	root.add_child(node)
	node.set_owner(root)
	$Panel/Tree.add_item(str(node.name))
