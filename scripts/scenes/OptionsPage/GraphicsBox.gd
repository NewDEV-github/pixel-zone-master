extends VBoxContainer
var documents = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
func _ready():
	$ApplyButton.connect("pressed", self, "_on_apply")
