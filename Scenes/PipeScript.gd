extends Node2D

var main:Main

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main = get_tree().current_scene


# Called every frame. 'delta' is the elapsed time sicne the previous frame.
func _process(delta: float) -> void:
	var groundSpeed:float = main.groundSpeed
	
	position.x -= groundSpeed * delta
	
	if position.x < -50:
		queue_free()
		
