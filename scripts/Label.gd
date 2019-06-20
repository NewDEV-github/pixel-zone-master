extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func save():
	var save_dict = {
		"Number of log" : OS.get_unix_time(),
		
		
		
		"Process ID" : OS.get_process_id(),
		"All resources" : OS.print_all_resources("user://logs/" + str(OS.get_unix_time()) + "_all_resources.log"),
		"Textures (by size)" : OS.print_all_textures_by_size(),
		"Used Resources" : OS.print_resources_in_use(),
		"The number of processor cores" : OS.get_processor_count(),
		"The nuber of audio drivers" : OS.get_audio_driver_count(),
		"Static memory used" : OS.get_static_memory_usage(),
		"Time from starting the engine (seconds)" : OS.get_ticks_msec(),
        "Operating System" : OS.get_name(),
		"Locale" : OS.get_locale(),
		"Enumeration" : text,
		"Data" : OS.get_date(),
		"Video Driver" : OS.get_current_video_driver(),
		"Device Type" : OS.get_model_name(),
		"Killed Enemies" : get_node("/root/killed_enemies").points,
		"Game State" : get_node("/root/game_state").points,
		"Game Experience" : get_node("/root/game_experience").points,
		"Game Health" : get_node("/root/game_health").points
	}
	return save_dict