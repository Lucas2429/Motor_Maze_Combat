class_name PlayerSMG
extends BasicPlayer

@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_tree: AnimationTree = $Marker2D/AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var animation_tree_2: AnimationTree = $Marker2D2/AnimationTree
@onready var playback_2: AnimationNodeStateMachinePlayback = animation_tree_2["parameters/playback"]

var booleano: bool=true

func shoot() -> void:
	cooldown_shoot=0.1
	booleano=booleano==false
	var b = bullet_scene.instantiate()
	multiplayer_spawner.add_child(b, true)
	var play: AnimationNodeStateMachinePlayback
	if booleano:
		b.transform = marker_2d.global_transform
		play=playback
	else:
		b.transform = marker_2d_2.global_transform
		play=playback_2
	play.travel("shooting")
	b.rotation=rotation
