extends Node2D

@onready var game_speed: float = $"..".game_speed 
@onready var spawn_timer: Timer = $SpawnCooldown
@export var obstacle: PackedScene
@export var X_MIN_LIMIT: int
@export var X_MAX_LIMIT: int
@export var MIN_COOLDOWN: float
@export var MAX_COOLDOWN: float


var rng = RandomNumberGenerator.new()

func spawn_obstacle() -> void:
	var obstacle_node = obstacle.instantiate()
	obstacle_node.position = Vector2i(rng.randi_range(X_MIN_LIMIT, X_MAX_LIMIT), -16)
	obstacle_node.add_to_group("obstacles")
	add_child(obstacle_node)
	
func _on_spawn_cooldown_timeout() -> void:
	spawn_obstacle() 
	spawn_timer.start(rng.randf_range(MIN_COOLDOWN, MAX_COOLDOWN))
		   
