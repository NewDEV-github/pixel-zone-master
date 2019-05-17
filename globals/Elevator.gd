extends StaticBody2D

export(String, "x", "y", "xy") var axis = "x"
export(float) var modif = 60
var vel
onready var pre_pos = global_position
var passenger = null

func _ready():
	$Area2D.connect("body_entered", self, "on_enter")
	$Area2D.connect("body_exited", self, "on_exit")

func _physics_process(delta):
	vel = pre_pos - global_position
	pre_pos = global_position
	if passenger == null:
		return
	
	vel *= -modif

	if axis == "xy":
		passenger.linear_velocity += vel

	elif axis == "x":
		passenger.linear_velocity.x += vel.x
	
	elif axis == "y":
		passenger.linear_velocity.y += vel.y



func on_enter(body):
	if body.name != "Player":
		return

	passenger = body
	

func on_exit(body):
	if body.name != "Player":
		return
		
	passenger = null