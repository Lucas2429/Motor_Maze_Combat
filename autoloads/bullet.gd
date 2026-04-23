extends Area2D

var speed = -750

func _physics_process(delta):
	position += transform.y * speed * delta

func _on_Area2D_body_entered(body):
	queue_free()
func _on_body_entered(body):
	print("hit!")
	queue_free()
func _ready() -> void:
	area_entered.connect(_on_Area2D_body_entered)
