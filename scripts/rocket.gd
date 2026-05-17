extends Area2D

var speed = -750
@export var player_id="-1"
var damage=50

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
