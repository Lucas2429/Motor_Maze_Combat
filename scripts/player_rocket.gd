class_name PlayerRocket
extends BasicPlayer

@onready var marker_2d: Marker2D = $Marker2D

var booleano: bool=true

func shoot() -> void:
	cooldown_shoot=1
	booleano=booleano==false
	var b = bullet_scene.instantiate()
	multiplayer_spawner.add_child(b, true)
	b.transform = marker_2d.global_transform
	b.rotation=rotation
