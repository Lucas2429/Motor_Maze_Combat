extends CharacterBody2D

@export var max_angle=999999999
@export var angular_acceleration=3

@export var max_speed=800
@export var acceleration=1000

@onready var label: Label = $Label

@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer

func _process(delta: float) -> void:
	label.rotation = 0

func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		var turn_direction: float = Input.get_axis("turn_anticlockwise","turn_clockwise")
		if turn_direction != 0:
			rotation = move_toward(rotation, max_angle * turn_direction, angular_acceleration * delta)
		var move_direction: float = Input.get_axis("forward","backwards")
		var speed = move_toward(velocity.length(), max_speed,acceleration * delta)
		velocity.y = speed*cos(rotation) * move_direction
		velocity.x = speed*sin(-rotation) * move_direction
		move_and_slide()
	

func setup(data: Statics.PlayerData) -> void:
	name = str(data.id)
	label.text = data.name
	set_multiplayer_authority(data.id, false)
	multiplayer_synchronizer.set_multiplayer_authority(data.id, false)
