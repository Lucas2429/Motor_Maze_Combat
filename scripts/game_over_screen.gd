class_name GameOverScreen
extends Control

var placements: Array[int] = []
var player_votes_by_id: Array[int] = []

@onready var game_over: Label = $PanelContainer/MarginContainer/VBoxContainer/GameOver
@onready var first_place: Label = $PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/FirstPlace
@onready var second_place: Label = $PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/SecondPlace
@onready var third_place: Label = $PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/ThirdPlace
@onready var play_again_button: Button = $PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/VBoxContainer/PlayAgainButton

@onready var vote_1: Label = $PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/VotesBox/Vote1
@onready var vote_2: Label = $PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/VotesBox/Vote2
@onready var vote_3: Label = $PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/VotesBox/Vote3
@onready var votes_box: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/CenterContainer/HBoxContainer/VotesBox


func _ready() -> void:
	visible = false
	votes_box.visible = false
	Game.vote_updated.connect(_on_vote_updated)

func _on_vote_updated(id: int) -> void:
	var player = Game.get_player(id)
	if player.vote:
		if not player_votes_by_id.has(player.id):
			player_votes_by_id.append(player.id)
			if player_votes_by_id.size() == 1:
				votes_box.visible = true
	else:
		player_votes_by_id.erase(player.id)
		if player_votes_by_id.size() == 0:
				votes_box.visible = false
	
	update_votes()
	
	var all_voted: bool = true
	for player_data in Game.players:
		if not player_data.vote:
			all_voted = false
			break
	if all_voted:
		await get_tree().create_timer(3.0).timeout
		Game.reset_votes()
		get_tree().reload_current_scene()
	

func update_votes() -> void:
	var votes = [vote_1, vote_2, vote_3]
	for i in votes.size():
		votes[i].text = ""

	for i in player_votes_by_id.size():
		var player = Game.get_player(player_votes_by_id[i])
		if player:
			votes[i].text = player.name

func update_placements(id: int) -> void:
	placements.append(id)
	var player = Game.get_player(id)
	if placements.size() == 1:
		third_place.text = "3rd Place: " + player.name
	elif placements.size() == 2:
		second_place.text = "2nd Place: " + player.name
		var p_id
		for p in Game.players:
			if !placements.has(p.id):
				p_id = p.id
				first_place.text = "1st Place: " + p.name
				break
				
		if multiplayer.get_unique_id() == p_id:
			game_over.text = "YOU WIN"
			game_over.modulate = Color.GREEN
		else:
			game_over.text = "YOU LOSE"
			game_over.modulate = Color.RED
			
		visible = true


func _on_play_again_button_pressed() -> void:
	Game.set_current_player_vote(not Game.get_current_player().vote)
	if Game.get_current_player().vote:
		play_again_button.text = "Cancel"
	else:
		play_again_button.text = "Play Again"
	Debug.log(Game.get_current_player().vote)
