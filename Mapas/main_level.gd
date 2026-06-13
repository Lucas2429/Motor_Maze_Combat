extends Node2D

@export var player_scene_submachinegun: PackedScene
@export var player_scene_shotgun: PackedScene
@export var player_scene_rocketlauncher: PackedScene
@onready var spawn_points: Node2D = $SpawnPoints
@onready var players: Node2D = $Players
@onready var nametags: Node2D = $Nametags
@onready var game_over_screen: GameOverScreen = $CanvasLayer/GameOverScreen


func _ready() -> void:
	for i in Game.players.size():
		var player_data = Game.players[i]
		var player_inst: BasicPlayer
		if (player_data.role==1):
			player_inst=player_scene_submachinegun.instantiate()
		elif (player_data.role==2):
			player_inst=player_scene_shotgun.instantiate()
		else:
			player_inst=player_scene_rocketlauncher.instantiate()
		
		player_inst.name = str(player_data.id)
		players.add_child(player_inst, true)
		var spawn_point = spawn_points.get_child(i)
		player_inst.global_position = spawn_point.global_position
		player_inst.setup(player_data)
		
		player_inst.player_died.connect(_on_player_died)

func _on_player_died(id: int) -> void:
	game_over_screen.update_placements(id)
