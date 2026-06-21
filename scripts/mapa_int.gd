extends Node2D

func _ready() -> void:
	Game.vote_updated.connect(func (id): check())
	await get_tree().create_timer(0.5).timeout
	Game.set_current_player_vote(true)

func check() -> void:
	if not is_multiplayer_authority():
		return
	if Game.all_voted():
		Debug.log("All players voted: int")
		await get_tree().create_timer(1.0).timeout
		Game.reset_votes()
		change_map.rpc()

@rpc("any_peer", "call_local", "reliable")
func change_map() -> void:
	get_tree().change_scene_to_file("res://Mapas/main_level.tscn")
