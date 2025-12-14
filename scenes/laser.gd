extends Area2D

static var textures = [
	load("res://graphics/hearts/heart1-50x50.png"),
	load("res://graphics/hearts/heart2-50x50.png"),
	load("res://graphics/hearts/heart3-50x50.png"),
	load("res://graphics/hearts/heart4-50x50.png"),
	load("res://graphics/hearts/heart5-50x50.png"),
]

@export var speed = 650
var rotation_speed = 0

func _ready():
	$LaserImage.scale = Vector2(0,0)
	var rng = RandomNumberGenerator.new()
	$LaserImage.texture = textures[rng.randi_range(0, len(textures)-1)]
	var tween = create_tween()
	tween.tween_property($LaserImage, "scale", Vector2(1,1), 0.1)
	rotation_speed = rng.randf_range(-120, 120)

func _process(delta: float) -> void:
	position += Vector2(0, -1) * speed * delta
	rotation_degrees += rotation_speed * delta
	
