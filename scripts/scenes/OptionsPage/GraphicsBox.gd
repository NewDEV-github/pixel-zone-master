extends VBoxContainer
var apply
func _ready():
	apply = $ApplyButton.connect("pressed", self, "_on_apply")
