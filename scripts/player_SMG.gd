class_name PlayerSMG
extends BasicPlayer

@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_tree: AnimationTree = $Marker2D/AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var animation_tree_2: AnimationTree = $Marker2D2/AnimationTree
@onready var playback_2: AnimationNodeStateMachinePlayback = animation_tree_2["parameters/playback"]
@onready var mp_5: Sprite2D = $Mp5
@onready var mp_6: Sprite2D = $Mp6
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var booleano: bool=true

func spawn_bullet(data):
	var b: Bullet = bullet_scene.instantiate()

	b.player_id = data.player_id
	b.global_position  = data.marker
	b.rotation_degrees = data.rotation

	return b

func shoot() -> void:
	audio_stream_player.play()
	booleano=booleano==false
	var b = bullet_scene.instantiate()
	b.player_id=player_id
	var play: AnimationNodeStateMachinePlayback
	var marker: Marker2D
	if booleano:
		marker = marker_2d
		play=playback
	else:
		marker = marker_2d_2
		play=playback_2
	play.travel("shooting")
	b.rotation=rotation
	multiplayer_spawner.spawn({
		"player_id": player_id,
		"marker": marker.global_position,
		"rotation": global_rotation_degrees
	})
