extends Node

var peer: ENetMultiplayerPeer

const IP_ADDRESS := "127.0.0.1"
const PORT := 42070


func start_server() -> void:
	peer = ENetMultiplayerPeer.new()

	var error := peer.create_server(PORT)

	if error != OK:
		print("Failed to create server: ", error)
		return

	multiplayer.multiplayer_peer = peer

	print("Server started on port ", PORT)
	print("Server peer ID: ", multiplayer.get_unique_id())


func start_client() -> void:
	peer = ENetMultiplayerPeer.new()

	var error := peer.create_client(IP_ADDRESS, PORT)

	if error != OK:
		print("Failed to create client: ", error)
		return

	multiplayer.multiplayer_peer = peer

	print("Client connecting...")
