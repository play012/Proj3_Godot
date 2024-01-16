extends MultiplayerSynchronizer
@export var cursorPos := Vector3()
@export var redPos := Vector3()
@export var greenPos := Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())

@rpc("reliable")
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if multiplayer.is_server():
			rpc("spawn_redboat")
			var boatScene = load("res://Prefabs/redboat.tscn")
			var boat = boatScene.instantiate()
		
			get_tree().current_scene.add_child(boat)
			boat.position = cursorPos
			boat.position.y = 0
		if not multiplayer.is_server():
			rpc("spawn_greenboat")
			var boatScene = load("res://Prefabs/greenboat.tscn")
			var boat = boatScene.instantiate()
		
			get_tree().current_scene.add_child(boat)
			boat.position = cursorPos
			boat.position.y = 0

@rpc("any_peer")
func spawn_redboat():
	if not multiplayer.is_server():
		var boatScene = load("res://Prefabs/redboat.tscn")
		var boat = boatScene.instantiate()
		
		get_tree().current_scene.add_child(boat)
		boat.position = redPos
		boat.position.y = 0

@rpc("any_peer")
func spawn_greenboat():
	if multiplayer.is_server():
		var boatScene = load("res://Prefabs/greenboat.tscn")
		var boat = boatScene.instantiate()
		
		get_tree().current_scene.add_child(boat)
		boat.position = greenPos
		boat.position.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousepos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	cursorPos = camera.project_position(mousepos, 200.0)
	
	if cursorPos.z > 0 and multiplayer.is_server():
		cursorPos.z = 0
	
	if cursorPos.z < 0 and not multiplayer.is_server():
		cursorPos.z = 0
	
	if multiplayer.is_server():
		redPos = cursorPos
	
	if not multiplayer.is_server():
		greenPos = cursorPos
	pass
