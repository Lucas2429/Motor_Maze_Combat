class_name PlayerRocketLauncher
extends BasicPlayer
@onready var marker_2d: Marker2D = $Marker2D


@export var bullet:PackedScene

var booleano: bool=true


func shoot() -> void:
	cooldown_shoot=cooldown_max
	booleano=booleano==false
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = marker_2d.global_transform
	b.rotation=rotation
