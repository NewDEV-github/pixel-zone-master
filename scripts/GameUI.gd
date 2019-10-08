extends Control
class_name Pause_Menu
signal FPSHide
signal FPSShow
func _ready():
	if str(OS.get_name()) == 'Android':
		$"Menu/OptionsPage/TabContainer/Controller Test".hide()
	if not str(OS.get_name()) == 'Android':
		$"Menu/OptionsPage/TabContainer/Controller Test".show()
	$"Menu/OptionsPage/TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/VBoxContainer/FPSBox".connect("fps_hide", self, "_on_FPS_Hide")
	$"Menu/OptionsPage/TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/VBoxContainer/FPSBox".connect("fps_show", self, "_on_FPS_Show")
func _on_FPS_Hide():
	emit_signal("FPSHide")
func _on_FPS_Show():
	emit_signal("FPSShow")
