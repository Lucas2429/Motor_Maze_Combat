extends Area2D

var speed = -1000
@export var player_id="-1"
var damage=20
@export var explosion_scene: PackedScene
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner

func _ready() -> void:
	if multiplayer.is_server():
		body_entered.connect(_on_body_entered)
		area_entered.connect(_on_area_entered)

func _physics_process(delta):
	position += transform.y * speed * delta

func interact(area: Area2D)-> void:
	pass

@rpc("call_local")
func spawn_explosion(pos):
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)

var exploded := false

func terminate() -> void:
	if exploded:
		return

	exploded = true

	spawn_explosion.rpc(global_position)
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	area.interact(self)

func _on_body_entered(body: Node2D) -> void:
	terminate()
