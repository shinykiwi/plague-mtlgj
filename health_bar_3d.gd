extends Sprite3D
@onready var bar = $SubViewport/HealthBar2D




# Called when the node enters the scene tree for the first time.
func _ready():
	texture = $SubViewport.get_texture()
	
func update(value, full):
	bar.update_bar(value, full)
