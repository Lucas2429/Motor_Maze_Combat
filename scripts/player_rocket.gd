class_name PlayerRocket
extends BasicPlayer

@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_tree: AnimationTree = $Marker2D/AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

var booleano: bool=true

func shoot() -> void:
	cooldown_shoot=1
	booleano=booleano==false
	var b = bullet_scene.instantiate()
	multiplayer_spawner.add_child(b, true)
	b.transform = marker_2d.global_transform
	b.rotation=rotation
	playback.travel("shooting")
