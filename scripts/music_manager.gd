extends Node2D

# BGM
var TITLE_SCREEN_THEME:AudioStream = load("res://assets/music/Title.wav")
var GAME_THEME:AudioStream = load("res://assets/music/Game.wav")
var GAME_OVER_THEME:AudioStream = load("res://assets/music/GameOver.wav")

# SFX
var BARK_SFX: AudioStream = load("res://assets/sfx/bark.wav")

@onready var BGMNode: AudioStreamPlayer = $BGM
@onready var SFXNode: AudioStreamPlayer = $SFX

func play_bgm(title: String) -> void:
	if title == "title":
		BGMNode.stream = TITLE_SCREEN_THEME
	elif title == "game":
		BGMNode.stream = GAME_THEME
	elif title == "game_over":
		BGMNode.stream = GAME_OVER_THEME
	else:
		print('Audio not found')
		return;
	BGMNode.play()

func stop_bgm() -> void:
	BGMNode.stop()

func play_sfx(title: String) -> void:
	if title == "bark":
		SFXNode.stream = BARK_SFX
	else:
		print('Audio not found')
		return;
	SFXNode.play() 
