extends Node
const PORT = 4433

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.server_relay = false
	if DisplayServer.get_name() == "headless":
		on_host_pressed.call_deferred()

func on_host_pressed():
	print("Host pressed")
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()

func on_connect_pressed():
	print("Client pressed")
	var peer = ENetMultiplayerPeer.new()
	if not $ControlPanel/joinButton/ipAddress.text == "":
		peer.create_client($ControlPanel/joinButton/ipAddress.text, PORT)
	multiplayer.multiplayer_peer = peer
	start_game()

func start_game():
	$ControlPanel.hide()
	if multiplayer.is_server():
		change_level.call_deferred(load("res://Scenes/TowerDefense.tscn"))

func change_level(scene: PackedScene):
	var level = $Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	level.add_child(scene.instantiate())
