extends CharacterBody2D

@export var game_speed = 70
var screen_size: Vector2i

func _ready() -> void:
	screen_size = get_window().size

func _process(delta: float) -> void:
	position.y += game_speed * delta

	if position.y > screen_size.y:
		position.y -= screen_size.y - 16;
