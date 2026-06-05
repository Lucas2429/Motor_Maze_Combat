extends Area2D

@onready var parent=self.get_parent()

func interact(area: Area2D)-> void:
	
	if area.player_id!=parent.player_id:
		area.terminate()
