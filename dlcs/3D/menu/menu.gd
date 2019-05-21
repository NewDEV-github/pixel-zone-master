extends Control
signal warning
# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _on_settings_pressed():
	$ui/main.hide()
	$ui/settings.show()
	
	if (settings2.gi_quality == settings2.GI_QUALITY_HIGH):
		$ui/settings/gi_high.pressed=true
	elif (settings2.gi_quality == settings2.GI_QUALITY_LOW):
		$ui/settings/gi_low.pressed=true
	elif (settings2.gi_quality == settings2.GI_QUALITY_DISABLED):
		$ui/settings/gi_disabled.pressed=true

	if (settings2.aa_quality == settings2.AA_8X):
		$ui/settings/aa_8x.pressed=true
	elif (settings2.aa_quality == settings2.AA_4X):
		$ui/settings/aa_4x.pressed=true
	elif (settings2.aa_quality == settings2.AA_2X):
		$ui/settings/aa_2x.pressed=true
	elif (settings2.aa_quality == settings2.AA_DISABLED):
		$ui/settings/aa_disabled.pressed=true

	if (settings2.ssao_quality == settings2.SSAO_QUALITY_HIGH):
		$ui/settings/ssao_high.pressed=true
	elif (settings2.ssao_quality == settings2.SSAO_QUALITY_LOW):
		$ui/settings/ssao_low.pressed=true
	elif (settings2.ssao_quality == settings2.SSAO_QUALITY_DISABLED):
		$ui/settings/ssao_disabled.pressed=true
		
	if (settings2.resolution == settings2.RESOLUTION_NATIVE):
		$ui/settings/resolution_native.pressed = true
	elif (settings2.resolution == settings2.RESOLUTION_1080):
		$ui/settings/resolution_1080.pressed = true
	elif (settings2.resolution == settings2.RESOLUTION_720):
		$ui/settings/resolution_720.pressed = true
	elif (settings2.resolution == settings2.RESOLUTION_576):
		$ui/settings/resolution_576.pressed = true


func _on_quit_pressed():
	get_tree().quit()


func _on_apply_pressed():
	background_load.load_scene("res://dlcs/3D/level/level.tscn")
	
	if($ui/settings/gi_high.pressed):
		settings2.gi_quality = settings2.GI_QUALITY_HIGH
	elif($ui/settings/gi_low.pressed):
		settings2.gi_quality = settings2.GI_QUALITY_LOW
	elif($ui/settings/gi_disabled.pressed):
		settings2.gi_quality = settings2.GI_QUALITY_DISABLED

	if($ui/settings/aa_8x.pressed):
		settings2.aa_quality = settings2.AA_8X
	elif($ui/settings/aa_4x.pressed):
		settings2.aa_quality = settings2.AA_4X
	elif($ui/settings/aa_2x.pressed):
		settings2.aa_quality = settings2.AA_2X
	elif($ui/settings/aa_disabled.pressed):
		settings2.aa_quality = settings2.AA_DISABLED

	if($ui/settings/ssao_high.pressed):
		settings2.ssao_quality = settings2.SSAO_QUALITY_HIGH
	elif($ui/settings/ssao_low.pressed):
		settings2.ssao_quality = settings2.SSAO_QUALITY_LOW
	elif($ui/settings/ssao_disabled.pressed):
		settings2.ssao_quality = settings2.SSAO_QUALITY_DISABLED

	if($ui/settings/resolution_native.pressed):
		settings2.resolution = settings2.RESOLUTION_NATIVE
	elif($ui/settings/resolution_1080.pressed):
		settings2.resolution = settings2.RESOLUTION_1080
	elif($ui/settings/resolution_720.pressed):
		settings2.resolution = settings2.RESOLUTION_720
	elif($ui/settings/resolution_576.pressed):
		settings2.resolution = settings2.RESOLUTION_576

	settings2.save_settings()
	background_load.load_scene("user://3D/level/level.tscn")
func _on_cancel_pressed():
	$ui/main.show()
	$ui/settings.hide()
func _process(delta):
	if $ui/settings/VBoxContainer/CheckBox.pressed == true:
		ProjectSettings.set("low_processor_mode", true)
		#ssao
		$ui/settings/ssao_low.set_disabled(true)
		$ui/settings/ssao_high.set_disabled(true)
		$ui/settings/ssao_disabled.set_pressed(true)
		#Global Illumination
		$ui/settings/gi_low.set_disabled(true)
		$ui/settings/gi_high.set_disabled(true)
		$ui/settings/gi_disabled.set_pressed(true)
		#Anti Aliasing
		$ui/settings/aa_8x.set_disabled(true)
		$ui/settings/aa_4x.set_disabled(true)
		$ui/settings/aa_2x.set_disabled(true)
		$ui/settings/aa_disabled.set_pressed(true)
	if $ui/settings/VBoxContainer/CheckBox.pressed == false:
		ProjectSettings.set("low_processor_mode", false)
		#ssao
		$ui/settings/ssao_low.set_disabled(false)
		$ui/settings/ssao_high.set_disabled(false)
		$ui/settings/ssao_disabled.set_pressed(false)
		$ui/settings/ssao_high.set_pressed(true)
		#Global Illumination
		$ui/settings/gi_low.set_disabled(false)
		$ui/settings/gi_high.set_disabled(false)
		$ui/settings/gi_high.set_pressed(true)
		$ui/settings/gi_disabled.set_pressed(false)
		#Anti Aliasing
		$ui/settings/aa_8x.set_disabled(false)
		$ui/settings/aa_4x.set_disabled(false)
		$ui/settings/aa_2x.set_disabled(false)
		$ui/settings/aa_disabled.set_pressed(false)
		$ui/settings/aa_8x.set_pressed(true)
	if $ui/settings/VBoxContainer/CheckBox2.pressed == true:
		ProjectSettings.set("rendering/quality/driver/fallback_to_gles2", true)
	if $ui/settings/VBoxContainer/CheckBox2.pressed == false:
		ProjectSettings.set("rendering/quality/driver/fallback_to_gles2", false)
	if $ui/settings/VBoxContainer/CheckBox3.pressed == true:
		if $ui/settings/VBoxContainer/CheckBox2.pressed == false:
			$ui/settings/VBoxContainer/CheckBox2.set_pressed(true)
		ProjectSettings.set("rendering/quality/2d/gles2_use_nvidia_rect_flicker_workaround", true)
	if $ui/settings/VBoxContainer/CheckBox3.pressed == false:
		ProjectSettings.set("rendering/quality/2d/gles2_use_nvidia_rect_flicker_workaround", false)