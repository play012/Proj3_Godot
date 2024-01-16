extends MultiplayerSynchronizer
@export var cursorPos := Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if multiplayer.is_server():
			var boat = preload("res://Prefabs/redboat.tscn").instantiate()
			get_tree().get_root().get_node("Multiplayer/Level/TowerDefense/RedBoats").add_child(boat, true)
		
			boat.position = cursorPos
			boat.position.y = 0
		if not multiplayer.is_server():
			var boat = preload("res://Prefabs/greenboat.tscn").instantiate()
			get_tree().get_root().get_node("Multiplayer/Level/TowerDefense/GreenBoats").add_child(boat, true)
		
			boat.position = cursorPos
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
	pass
