extends RigidBody2D

var main:Main
const FLAP_VELOCITY = -350

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main = get_tree().current_scene
	
func flap():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play("flap")
	linear_velocity.y = FLAP_VELOCITY


func _on_area_2d_area_entered(area: Area2D) -> void:
	if main.gameState == Main.GameStates.Playing:
		if area.name == "ScoreArea":
			main.updateScore()
		else:
			main.startGameOver()
			$AnimatedSprite2D.play("die")
			linear_velocity = Vector2(FLAP_VELOCITY, FLAP_VELOCITY)
