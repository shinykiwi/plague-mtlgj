extends Camera3D

@onready var player = get_node("../Player")
var camera_cut = Vector3(-2,0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not is_position_behind(camera_cut):
		position.x = player.position.x
