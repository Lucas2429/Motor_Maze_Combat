class_name BasicPlayer
extends CharacterBody2D

@export var max_angle=999999999
@export var angular_acceleration=3

@export var cooldown_shoot:float
@onready var cooldown_max:float=cooldown_shoot

@export var max_speed=800
@export var acceleration=1000
@export var bullet_scene: PackedScene 

@onready var label: Label = $Label
@onready var label_position= Vector2(-21,-91)
@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner

@rpc("authority","call_local")
func shoot() -> void:
	return

func _process(delta: float) -> void:
	label.position=position+label_position

func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		var turn_direction: float = Input.get_axis("turn_anticlockwise","turn_clockwise")
		if turn_direction != 0:
			rotation = move_toward(rotation, max_angle * turn_direction, angular_acceleration * delta)
		var move_direction: float = Input.get_axis("forward","backwards")
		var speed = move_toward(velocity.length(), max_speed,acceleration * delta)
		velocity.y = speed*cos(rotation) * move_direction
		velocity.x = speed*sin(-rotation) * move_direction
		
		cooldown_shoot-=delta
		if Input.is_action_pressed("shoot") and cooldown_shoot<0:
			shoot.rpc()
		move_and_slide()
	
func setup(data: Statics.PlayerData) -> void:
	name = str(data.id)
	label.text = data.name
	set_multiplayer_authority(data.id, false)
	multiplayer_synchronizer.set_multiplayer_authority(data.id, false)
