class_name PlayerSubmachinegun
extends BasicPlayer
@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d: Marker2D = $Marker2D


@export var bullet:PackedScene

var booleano: bool=true


func shoot() -> void:
	cooldown_shoot=cooldown_max
	booleano=booleano==false
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	if booleano:
		b.transform = marker_2d.global_transform
	else:
		b.transform = marker_2d_2.global_transform
	b.rotation=rotation
