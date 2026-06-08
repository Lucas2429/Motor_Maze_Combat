extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var damage=30
var already_damaged_ids := {}
var damaging_animation=true

@export var cooldown_explode: float =0.2
var cooldown_explode_delta: float = -1

func _ready() -> void:
	play_explosion.rpc()

@rpc("call_local")
func play_explosion():
	animation_player.play("exploding")

func _process(delta):



	cooldown_explode_delta-=delta
	if cooldown_explode_delta<0:
		cooldown_explode_delta = cooldown_explode
		explode()

func interact(area) -> void:
	pass

func not_a_damaging_animation() -> void:
	damaging_animation=false

func explode() -> void:
	if multiplayer.is_server() and damaging_animation:
		var origen = global_position
		var bodies = get_overlapping_bodies()
		
		print(
		"Explosion:",
		get_instance_id(),
		" already_damaged:",
		already_damaged_ids.size()
		)
			
		
		
		for body in bodies:
			
			if "hp" not in body:
				continue
			var id = body.player_id

			

			if already_damaged_ids.has(id):
				continue
			var destino=body.global_position
			var query = PhysicsRayQueryParameters2D.create(origen, destino)
			query.exclude = [self]
			var resultado = get_world_2d().direct_space_state.intersect_ray(query)

			if resultado and resultado.collider==body:
				body.take_damage.rpc(damage)
				already_damaged_ids[id] = true

func terminate()-> void:
	queue_free()
