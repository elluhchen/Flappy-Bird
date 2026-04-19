extends TileMapLayer

@export var speedFactor:float = 1.0
var initX:float
var main:Main
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initX = position.x
	main = get_tree().current_scene
	
	
	# Called every frame. 'delta' is the elapsed time sicne the previous frame.
func _process(delta: float) -> void:
	var groundSpeed:float = main.groundSpeed
	position.x -= speedFactor * groundSpeed * delta
	
	if position.x <= initX - tile_set.tile_size.x:
		position.x += tile_set.tile_size.x
