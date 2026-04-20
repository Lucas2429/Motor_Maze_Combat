class_name PlayerSMG
extends BasicPlayer

@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d: Marker2D = $Marker2D

var booleano: bool=true

func shoot() -> void:
	cooldown_shoot=0.1
	booleano=booleano==false
	var b = bullet_scene.instantiate()
	multiplayer_spawner.add_child(b, true)
	if booleano:
		b.transform = marker_2d.global_transform
	else:
		b.transform = marker_2d_2.global_transform
	b.rotation=rotation
