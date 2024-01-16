extends Node3D

@export var player := 1 :
	set(id):
		player = id
		$PlayerInput.set_multiplayer_authority(id)

@onready var input = $PlayerInput

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if multiplayer.is_server() and not player == 1:
		$Label3D.text = "Player 2"
	if not multiplayer.is_server() and not player == 1:
		$Label3D.text = "Player 2"
	
	global_position = input.cursorPos
	global_position.y = 0
	pass
