extends Control
signal FPSHide
signal FPSShow
func _ready():
	$"UIScaler/Menu/OptionsPage/TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/VBoxContainer/FPSBox".connect("fps_hide", self, "_on_FPS_Hide")
	$"UIScaler/Menu/OptionsPage/TabContainer/Graphics & Audio/HBoxContainer/GraphicsBox/VBoxContainer/FPSBox".connect("fps_show", self, "_on_FPS_Show")
func _on_FPS_Hide():
	emit_signal("FPSHide")
func _on_FPS_Show():
	emit_signal("FPSShow")