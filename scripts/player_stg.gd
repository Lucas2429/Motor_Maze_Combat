class_name PlayerSTG
extends BasicPlayer

@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d: Marker2D = $Marker2D

var booleano: bool=true

func shoot() -> void:
	cooldown_shoot=0.5
	booleano=booleano==false
	var bullets = []

	for i in 7:
		var b = bullet_scene.instantiate()
		multiplayer_spawner.add_child(b, true)
		bullets.append(b)
	var marker:Marker2D
	if booleano:
		marker=marker_2d
	else:
		marker=marker_2d_2

	var i: int=-30
	for b in bullets:
		b.transform = marker.global_transform
		b.rotation_degrees = rotation_degrees + i
		i+=10
