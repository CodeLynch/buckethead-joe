extends ParallaxBackground

@onready var game_speed = get_parent().game_speed

func _process(delta: float) -> void:
	game_speed = get_parent().game_speed
	scroll_offset.y += game_speed * delta
