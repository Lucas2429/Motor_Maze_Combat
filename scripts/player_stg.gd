class_name PlayerSTG
extends BasicPlayer

@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_tree: AnimationTree = $Marker2D/AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var animation_tree_2: AnimationTree = $Marker2D2/AnimationTree
@onready var playback_2: AnimationNodeStateMachinePlayback = animation_tree_2["parameters/playback"]


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
	var play: AnimationNodeStateMachinePlayback
	if booleano:
		marker=marker_2d
		play=playback
	else:
		marker=marker_2d_2
		play=playback_2

	var i: int=-30
	for b in bullets:
		play.travel("shooting")
		b.transform = marker.global_transform
		b.rotation_degrees = rotation_degrees + i
		i+=10
