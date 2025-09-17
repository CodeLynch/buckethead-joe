extends ParallaxBackground

@export var game_speed = 70

func _process(delta: float) -> void:
	scroll_offset.y += game_speed * delta
