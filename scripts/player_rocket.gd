class_name PlayerRocket
extends BasicPlayer

@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_tree: AnimationTree = $Marker2D/AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var mp_5: Sprite2D = $Mp5
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var booleano: bool=true

func spawn_bullet(data):
	var b = bullet_scene.instantiate()

	b.player_id = data.player_id
	b.global_position  = data.marker
	b.rotation_degrees = data.rotation

	return b
	
func shoot() -> void:
	audio_stream_player.play()
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

func disable_player():
	label.text = ""
	sprite.visible = false
	collision.disabled = true
	hurtbox_collision.disabled = true
	hurtbox.set_collision_layer_value(5, false)
	hurtbox.set_collision_mask_value(5, false)
	health_bar.visible = false
	mp_5.visible = false
