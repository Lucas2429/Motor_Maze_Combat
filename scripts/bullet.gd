class_name Bullet
extends Area2D

var speed = -1000
@export var player_id="-1"
var damage=10

func _ready() -> void:
	if multiplayer.is_server():
		body_entered.connect(_on_body_entered)
		area_entered.connect(_on_area_entered)

func _physics_process(delta):
	position += transform.y * speed * delta

func interact(area: Area2D)-> void:
	pass

func terminate()-> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	area.interact(self)


func _on_body_entered(body: Node2D) -> void:
	queue_free()
