extends Node2D

# Añade aquí las rutas de tus mapas en texto para no depender del inspector
var lista_de_mapas: Array[String] = [
	"res://Mapas/mapas.tscn",
	"res://Mapas/mapas_1.tscn", 
	"res://Mapas/mapas_2.tscn", 
	"res://Mapas/mapas_3.tscn"
]

var indice_mapa_elegido: int = -1

func _ready() -> void:
	if multiplayer.is_server():
		randomize()
		indice_mapa_elegido = randi() % lista_de_mapas.size()
		cargar_mapa_por_indice(indice_mapa_elegido)
	else:
		rpc_id(1, "solicitar_mapa_al_servidor")

@rpc("any_peer", "reliable")
func solicitar_mapa_al_servidor() -> void:
	var id_del_cliente = multiplayer.get_remote_sender_id()
	
	rpc_id(id_del_cliente, "cargar_mapa_por_indice", indice_mapa_elegido)

@rpc("authority", "call_local", "reliable")
func cargar_mapa_por_indice(indice: int) -> void:
	if indice < 0 or indice >= lista_de_mapas.size():
		return
		
	for hijo in get_children():
		hijo.queue_free()
			
	var ruta_mapa = lista_de_mapas[indice]
	var escena_mapa = load(ruta_mapa) as PackedScene
	
	if escena_mapa:
		var instancia = escena_mapa.instantiate()
		add_child(instancia)
