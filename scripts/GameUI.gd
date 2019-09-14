extends Control
class_name Pause_Menu
signal FPSHide
signal FPSShow
func _ready():
	$"Menu/OptionsPage/TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/VBoxContainer/FPSBox".connect("fps_hide", self, "_on_FPS_Hide")
	$"Menu/OptionsPage/TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/VBoxContainer/FPSBox".connect("fps_show", self, "_on_FPS_Show")
func _on_FPS_Hide():
	emit_signal("FPSHide")
func _on_FPS_Show():
	emit_signal("FPSShow")
