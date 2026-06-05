class_name PlayerRocket
extends BasicPlayer

@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_tree: AnimationTree = $Marker2D/AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

var booleano: bool=true

func spawn_bullet(data):
	var b = bullet_scene.instantiate()

	b.player_id = data.player_id
	b.global_position  = data.marker
	b.rotation_degrees = data.rotation

	return b
	
func shoot() -> void:
	booleano=booleano==false
	var b = bullet_scene.instantiate()
	b.player_id=player_id
	b.transform = marker_2d.global_transform
	b.rotation=rotation
	b.player_id=name
	playback.travel("shooting")
	multiplayer_spawner.spawn({
		"player_id": player_id,
		"marker": marker_2d.global_position,
		"rotation": global_rotation_degrees
	})
