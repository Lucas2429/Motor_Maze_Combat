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
		# El servidor lo carga para sí mismo inmediatamente
		cargar_mapa_por_indice(indice_mapa_elegido)
	else:
		# SI SOY CLIENTE: Le pido al servidor que me diga qué mapa toca
		# Usamos "any_peer" para que el cliente pueda llamar a esta función del servidor
		rpc_id(1, "solicitar_mapa_al_servidor")

# Esta función la ejecutan los clientes, pero corre EN EL SERVIDOR (ID 1)
@rpc("any_peer", "reliable")
func solicitar_mapa_al_servidor() -> void:
	# Averiguamos quién es el cliente que está preguntando
	var id_del_cliente = multiplayer.get_remote_sender_id()
	
	# El servidor le responde SOLO a ese cliente con el mapa correcto
	rpc_id(id_del_cliente, "cargar_mapa_por_indice", indice_mapa_elegido)

# Esta función la ejecutan todos para renderizar el mapa
@rpc("authority", "call_local", "reliable")
func cargar_mapa_por_indice(indice: int) -> void:
	if indice < 0 or indice >= lista_de_mapas.size():
		return
		
	# Limpieza por si acaso
	for hijo in get_children():
		hijo.queue_free()
			
	var ruta_mapa = lista_de_mapas[indice]
	var escena_mapa = load(ruta_mapa) as PackedScene
	
	if escena_mapa:
		var instancia = escena_mapa.instantiate()
		add_child(instancia)
