extends Node2D

@export var player_scene_submachinegun: PackedScene
@export var player_scene_shotgun: PackedScene
@export var player_scene_rocketlauncher: PackedScene
@onready var spawn_points: Node2D = $SpawnPoints
@onready var players: Node2D = $Players
@onready var nametags: Node2D = $Nametags

func _ready() -> void:
	for i in Game.players.size():
		var player_data = Game.players[i]
		var player_inst
		if (player_data.role==1):
			player_inst=player_scene_submachinegun.instantiate()
		elif (player_data.role==2):
			player_inst=player_scene_shotgun.instantiate()
		else:
			player_inst=player_scene_rocketlauncher.instantiate()
			
		players.add_child(player_inst, true)
		var spawn_point = spawn_points.get_child(i)
		player_inst.global_position = spawn_point.global_position
		player_inst.setup(player_data)
