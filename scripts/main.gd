extends Node2D

@export var JOE_START_POS: Vector2i
@export var DOG_START_POS: Vector2i
@export var START_GAME_SPEED: float = 50
@export var MAX_GAME_SPEED: float = 150
@export var SPEED_MOD: float = 0.00005
@export var SCORE_MOD: float = 0.0005
@onready var score_text: RichTextLabel = $"UI/TextBox/ScoreLabel"

var score: int = 0
var game_speed: float

func game_over() -> void:
	get_tree().paused = true
	ScoreManager.setScore(ceil(score * SCORE_MOD))
	$Joe/AnimatedSprite2D.animation = "lose"
	$Dog/AnimatedSprite2D.animation = "lose"
	MusicManager.play_bgm('game_over')
	# buffer before scene change
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://scenes/score.tscn")
	
func _ready() -> void:
	game_speed = START_GAME_SPEED
	MusicManager.play_bgm('game')
	$Joe.got_hit.connect(game_over)
	$Dog.got_hit.connect(game_over)
	reset() 
	
func reset() -> void:
	$Dog.position = DOG_START_POS
	$Joe.position = JOE_START_POS
	game_speed = START_GAME_SPEED
	score = 0

func _process(_delta: float) -> void:
	game_speed = ceil(START_GAME_SPEED + score * SPEED_MOD)
	if game_speed > MAX_GAME_SPEED:
		game_speed = MAX_GAME_SPEED
	score += int(game_speed)
	score_text.text = "Score: %d" % ceil(score * SCORE_MOD)
