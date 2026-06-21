class_name MapSelect
extends Control

@onready var h_box_container: HBoxContainer = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer
@onready var map_1: Label = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer/Map1VBoxContainer/Map1
@onready var map_1_select_button: Button = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer/Map1VBoxContainer/Map1SelectButton
@onready var map_1_vote_count: Label = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer/Map1VBoxContainer/Map1VoteCount

@onready var map_2: Label = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer/Map2VBoxContainer2/Map2
@onready var map_2_select_button: Button = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer/Map2VBoxContainer2/Map2SelectButton
@onready var map_2_vote_count: Label = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer/Map2VBoxContainer2/Map2VoteCount

@onready var map_3: Label = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer/Map3VBoxContainer3/Map3
@onready var map_3_select_button: Button = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer/Map3VBoxContainer3/Map3SelectButton
@onready var map_3_vote_count: Label = $PanelContainer/MarginContainer/MapSelectionContainer/HBoxContainer/Map3VBoxContainer3/Map3VoteCount

func _ready() -> void:
	Game.vote_updated.connect(_on_vote_updated)
	map_1_select_button.pressed.connect(func (): _on_map_select_button_pressed(1))
	map_2_select_button.pressed.connect(func (): _on_map_select_button_pressed(2))
	map_3_select_button.pressed.connect(func (): _on_map_select_button_pressed(3))
	
func _on_vote_updated(id: int) -> void:
	if Game.all_voted():
		var map_votes_count = [map_1_vote_count, map_2_vote_count, map_3_vote_count]
		
		var map_emited = false
		for i in map_votes_count.size():
			var vote = int(map_votes_count[i].text)
			if vote > 1:
				Debug.log("Mapa emitido: " + str(i + 1))
				Game.map_chosen = i + 1
				map_emited = true
				break
		
		# RANDOM MAP
		if not map_emited:
			Game.map_chosen = 4
		Debug.log("All players voted: map_select")
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://Mapas/mapa_int.tscn")
	
func _on_map_select_button_pressed(id: int) -> void:
	if id == 1:
		map_1_select_button.text = "✓"
		update_votes.rpc(1)
	elif id == 2:
		map_2_select_button.text = "✓"
		update_votes.rpc(2)
	elif id == 3:
		map_3_select_button.text = "✓"
		update_votes.rpc(3)
	
	map_1_select_button.disabled = true
	map_2_select_button.disabled = true
	map_3_select_button.disabled = true
	Game.set_current_player_vote(true)
	
@rpc("any_peer", "call_local", "reliable")
func update_votes(id: int) -> void:
	var map_votes_count = [map_1_vote_count, map_2_vote_count, map_3_vote_count]
	var count = int(map_votes_count[id - 1].text)
	map_votes_count[id - 1].text = str(count + 1)
