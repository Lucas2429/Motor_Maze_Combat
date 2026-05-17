class_name BasicPlayer
extends CharacterBody2D

@export var max_angle=999999999
@export var angular_acceleration=3

@onready var health_bar: ProgressBar = $HealthBar
@onready var health_bar_position= Vector2(-30.0,-68.0)

@export var cooldown_shoot:float
@onready var cooldown_max:float=cooldown_shoot

@export var hp=100

var player_id="-1"

@export var max_speed=800
@export var acceleration=1000
@export var bullet_scene: PackedScene 

@onready var label: Label = $Label
@onready var label_position= Vector2(-21,-91)
@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner

func spawn_bullet(data):
	pass

func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	multiplayer_spawner.spawn_function = spawn_bullet
	
@rpc("authority","call_local")
func shoot() -> void:
	return
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if "player_id" in area and "damage" in area:
		print(area.player_id)
		if area.player_id!=player_id:
			hp-=area.damage
			if hp<=0:
				queue_free()
			health_bar.value = hp

func _process(delta: float) -> void:
	label.position=position+label_position
	health_bar.position=position+health_bar_position

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
		if (Input.is_action_pressed("shoot")) and cooldown_shoot<0:
			shoot.rpc()
		move_and_slide()
	
func setup(data: Statics.PlayerData) -> void:
	player_id = str(data.id)
	label.text = data.name
	set_multiplayer_authority(data.id, false)
	multiplayer_synchronizer.set_multiplayer_authority(data.id, false)
