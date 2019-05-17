extends Spatial

##	Simple Rotation character Select, like Golden Axe
##	Made by Cere_Ender, UnsignedFoo in Godot Discord Server.
##	Enjoy

#Max characters
var max_characters;
#current character
var current_character;
# The current angle
var current_angle = Vector3();
#Which angle to rotate
var target_rotation = Vector3();
export var speed = 3.0;

func _ready():
	#We set the number of characters and the current character
	current_character = 2;
	max_characters = 3;
	pass

func _process(delta):
	#if you press left and is the last character to the left...
	if(Input.is_action_just_pressed("ui_left") && current_character>1):
		#calc the angle to rotate
		target_rotation = target_rotation +  Vector3(0,90,0)
		current_character-=1
	#if you press right and is the last character to the right...
	if(Input.is_action_just_pressed("ui_right") && current_character<max_characters):
		#calc the angle to rotate
		target_rotation = target_rotation - Vector3(0,90,0)
		current_character+=1
	if current_character == 1:
		$Control/RichTextLabel.set_text("Player 1")
		$"/root/sprite".texture = load("res://textures/robot_demo.png")
	if current_character == 2:
		$Control/RichTextLabel.set_text("Robot")
		$"/root/sprite".texture = load("res://textures/robot_demo_2.png")
	if current_character == 3:
		$Control/RichTextLabel.set_text("Player 3")
		$"/root/sprite".texture = load("res://textures/robot_demo_2.png")
		
		
		
		
	#calc the current rotation of every frame
	#current_angle = Vector3(0,lerp(rotation_degrees.y,target_rotation.y,speed*delta),0);
	#print (current_angle)
	#print(max_characters)
	#print(current_character)

	#set the angle
	#rotation_degrees = current_angle
	rotation_degrees = Vector3(0,lerp(rotation_degrees.y,target_rotation.y,speed*delta),0);

