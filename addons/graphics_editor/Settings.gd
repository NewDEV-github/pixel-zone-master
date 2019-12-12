tool
extends Control

onready var editor = get_parent()
onready var canvas_outline = get_parent().get_node("PaintCanvasContainer/PaintCanvas/CanvasOutline")
var start_time
var end_time

func _ready():
	#start_time = OS.get_ticks_msec()
	get_node("CanvasOutlineToggle/CheckButton").pressed = canvas_outline.visible
	get_node("CanvasOutlineColor/ColorPickerButton").color = canvas_outline.color

func _process(delta):
#	if get_parent().paint_canvas_node != null:
#		canvas_outline = get_parent().paint_canvas_node.get_node("CanvasOutline")
#		end_time = OS.get_ticks_msec()
#		print("[Settings] Found Editor node in %s seconds!" % [(end_time - start_time) / float(1000)])
#		set_process(false)
	pass

func _on_ColorPickerButton_color_changed(color):
	canvas_outline.color = color

func _on_CheckButton_toggled(button_pressed):
	canvas_outline.visible = button_pressed

func _on_Ok_pressed():
	hide()
