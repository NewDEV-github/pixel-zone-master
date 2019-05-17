extends Label

var collected = 0
var to_collect = 0

func _ready():
	$Timer.connect("timeout", self, "on_timeout")
	globals.connect("collected_changed", self, "on_collected_changed")

func update_label():
	text = str(collected) + "/" + str(to_collect)

func on_timeout():
	to_collect = globals.to_collect
	collected = globals.collected
	update_label()

func on_collected_changed():
	collected = globals.collected
	update_label()




