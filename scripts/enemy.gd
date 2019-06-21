extends KinematicBody2D


const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)
const BULLET_VELOCITY = 1000
const WALK_SPEED = 70
const STATE_WALKING = 0
const STATE_KILLED = 1
var shoot_time=99999
var linear_velocity = Vector2()
var direction = -1
var anim=""

var state = STATE_WALKING

onready var detect_floor_left = $detect_floor_left
onready var detect_wall_left = $detect_wall_left
onready var detect_floor_right = $detect_floor_right
onready var detect_wall_right = $detect_wall_right
onready var sprite = $sprite
func _ready():
	$ProgressBar.value == 100
func _physics_process(delta):
	var new_anim = "idle"

	if state==STATE_WALKING:
		linear_velocity += GRAVITY_VEC * delta
		linear_velocity.x = direction * WALK_SPEED
		linear_velocity = move_and_slide(linear_velocity, FLOOR_NORMAL)

		if not detect_floor_left.is_colliding() or detect_wall_left.is_colliding():
			direction = 1.0

		if not detect_floor_right.is_colliding() or detect_wall_right.is_colliding():
			direction = -1.0

		sprite.scale = Vector2(direction, 1.0)
		new_anim = "walk"
	else:
		new_anim = "explode"


	if anim != new_anim:
		anim = new_anim
		$anim.play(anim)


func hit_by_bullet():
	state = STATE_WALKING
	$ProgressBar.value -= 4
	if $ProgressBar.value == 0:
		state = STATE_KILLED
		get_node("/root/game_experience").points += 2
		get_node("/root/killed_enemies").points += 1

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		state = STATE_KILLED
		get_node("/root/game_experience").points += 2
		get_node("/root/killed_enemies").points += 1
		if body.has_method("jump"):
			body.call("jump")
