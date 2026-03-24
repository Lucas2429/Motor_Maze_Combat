extends CharacterBody2D

@export var max_angle=999999999
@export var angular_acceleration=3

@export var max_speed=800
@export var acceleration=1000


func _physics_process(delta: float) -> void:
	var turn_direction: float = Input.get_axis("turn_anticlockwise","turn_clockwise")
	if turn_direction!=0:
		rotation=move_toward(rotation,max_angle*turn_direction,angular_acceleration*delta)
	var move_direction: float = Input.get_axis("forward","backwards")
	var speed=move_toward(velocity.length(),max_speed,acceleration*delta)
	velocity.y=speed*cos(rotation)*move_direction
	velocity.x=speed*sin(-rotation)*move_direction
	move_and_slide()
