extends Control
var save
func _notification(what):
	if what == NOTIFICATION_CRASH:
		print_log()
func print_log():
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	save = ResourceSaver.save("user://logs/log_scene.tscn", packed_scene)
	var b = File.new()
	b.open("user://logs/"+ 'game_log' + str(OS.get_unix_time()) + ".log", File.WRITE)
	b.store_line("Number of log : " + str(OS.get_unix_time()) + ' \nProcess ID : ' +str(OS.get_process_id())+ " \nTextures (by size) : " + str(OS.print_all_textures_by_size()) + " \nUsed Resources : "+ str(OS.print_resources_in_use()) + " \nThe number of processor cores : " + str(OS.get_processor_count()) + " \nThe nuber of audio drivers : " + str(OS.get_audio_driver_count()) + " \nStatic memory used : " + str(OS.get_static_memory_usage()) + " \nTime from starting the engine (seconds) : " +str(OS.get_ticks_msec()) +
	" \nOperating System : "+ str(OS.get_name()) +
	" \nLocale : "+ str(OS.get_locale()) + 
	" \nEnumeration : " + str($Label.text) +
	" \nDate : " + str(OS.get_date()) +
	" \nBattery : " + str(OS.POWERSTATE_CHARGED) +
	" \nVideo Driver : " + str(OS.get_current_video_driver()) +
	" \nDevice Type : " + str(OS.get_model_name()) +
	" \nAudio Output Latency : " + str(AudioServer.get_output_latency()))
func error():
	print_log()
	OS.alert("There has been an error. \n Log file was created at:\n" + str(OS.get_user_data_dir()) +"/" + str(OS.get_unix_time())+".log\nPlease attach it to any bug report\n\nContact support at https://karoltomaszewskimu.wixsite.com/mastergames/support")


#func _on_AcceptDialog_confirmed():
#	get_tree().quit()
#
#func _on_AcceptDialog_popup_hide():
#	get_tree().quit()
#func _on_AcceptDialog_about_to_show():
#	$AcceptDialog/Label2.set_text(str(OS.get_user_data_dir()) + "/" + str(OS.get_unix_time()) + ".log")
