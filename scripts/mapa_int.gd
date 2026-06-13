extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.vote_updated.connect(func (id): check())
	Game.set_current_player_vote(true)
	

	
func check() -> void:
	if not is_multiplayer_authority():
		return
	if Game.all_voted():
		Game.reset_votes()
		change_map.rpc()
		
@rpc("any_peer", "call_local", "reliable")
func change_map() -> void:
	get_tree().change_scene_to_file("res://Mapas/main_level.tscn")
