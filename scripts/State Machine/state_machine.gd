extends Node

signal change_state(state_name)

var states_map = {};
var current_state = null;

var _active = false setget set_active;

func _ready():
	for child in get_children():
		child.connect("finished",self,"change_state");
	set_active(false)
	return owner.connect("finished", self, "change_state") or emit_signal("change_state","Idle");

func _input(event):
	current_state.handle_input(event);

func _physics_process(delta):
	current_state.update(delta);

func change_state(state_name):
	if !_active:
		return
	current_state = states_map[state_name];
	current_state.enter();

func set_active(value):
	_active = value;
	set_physics_process(value);
	set_process_input(value);
	
	if !_active:
		current_state = null;