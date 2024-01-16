extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(Vector3(0, 0, -300) + Vector3.RIGHT, Vector3.UP)
	translate(Vector3(0, 0, -1))
	pass
