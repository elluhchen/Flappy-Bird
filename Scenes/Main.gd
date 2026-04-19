extends Node2D
class_name Main

enum GameStates {Idle, Playing, GameOver}
var gameState:GameStates = GameStates.Idle
var groundSpeed:float = 170.0

var score:int = 0

var pipeScene:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FlappyPlayer.gravity_scale = 0
	pipeScene = preload("res://Scenes/pipe_group.tscn")


func _on_timer_timeout() -> void:
	if gameState == GameStates.Playing:
		addPipesToStage()

func addPipesToStage():
	var pipes = pipeScene.instantiate()
	pipes.position.x = get_viewport_rect().size.x + 50
	pipes.position.y = randi_range(130,370)
	$PipesFolder.add_child(pipes)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flap"):
		match gameState:
			GameStates.Idle:
				startGame()
			GameStates.Playing:
				$FlappyPlayer.flap()
				$FlapSound.play()
				pass
			GameStates.GameOver:
				if $FlappyPlayer.position.y > 650:
					get_tree().reload_current_scene()
				
func startGame():
	gameState = GameStates.Playing
	$FlappyPlayer.gravity_scale = 1.2
	$FlappyPlayer.flap()
	$Timer.start()
	addPipesToStage()
	
func updateScore():
	score+=1
	$CanvasLayer/Label.text = str(score)
	$GOSound.play()

func startGameOver():
	gameState = GameStates.GameOver
	groundSpeed = 0
	$CanvasLayer/Label.text = str(score) + "\n\nGAME OVER"
