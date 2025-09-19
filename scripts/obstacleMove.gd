extends CharacterBody2D

@onready var game_speed = $'../..'.game_speed
var screen_size: Vector2i

func _ready() -> void:
	screen_size = get_window().size

func _process(delta: float) -> void:
	position.y += game_speed * delta
	
	if position.y > screen_size.y:
		queue_free()
