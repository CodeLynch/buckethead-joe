extends Node2D

@onready var game_speed: float = $"..".game_speed 
@onready var spawn_timer: Timer = $SpawnCooldown
@export var obstacles: Array[PackedScene] = []
@export var X_MIN_LIMIT: int
@export var X_MAX_LIMIT: int
@export var MIN_COOLDOWN: float
@export var MAX_COOLDOWN: float


var rng = RandomNumberGenerator.new()

func spawn_obstacle() -> void:
	var obstacle_scene = obstacles.pick_random()
	var obstacle_node = obstacle_scene.instantiate()
	obstacle_node.position = Vector2i(rng.randi_range(X_MIN_LIMIT, X_MAX_LIMIT), -16)
	add_child(obstacle_node)
	
func _on_spawn_cooldown_timeout() -> void:
	spawn_obstacle() 
	spawn_timer.start(rng.randf_range(MIN_COOLDOWN, MAX_COOLDOWN))
		   
