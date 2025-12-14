extends Area2D

@export var speed_y = 500
var speed_x: int
var rotation_speed: float
var direction_x: float
var rng: RandomNumberGenerator
var meteorsTypePaths = ["meteorGrey", "meteorBrown"]
var can_collide = true
signal collision

static var streams = [
	load("res://audio/meteor-hit/heart-hit-1.wav"),
	load("res://audio/meteor-hit/heart-hit-2.wav"),
	load("res://audio/meteor-hit/heart-hit-3.wav"),
	load("res://audio/meteor-hit/heart-hit-4.wav"),
	load("res://audio/meteor-hit/heart-hit-5.wav"),
	load("res://audio/meteor-hit/heart-hit-6.wav"),
	load("res://audio/meteor-hit/heart-hit-7.wav"),
	load("res://audio/meteor-hit/heart-hit-8.wav"),
	load("res://audio/meteor-hit/heart-hit-9.wav"),
	load("res://audio/meteor-hit/heart-hit-10.wav"),
	load("res://audio/meteor-hit/heart-hit-11.wav"),
	load("res://audio/meteor-hit/heart-hit-12.wav"),
	load("res://audio/meteor-hit/heart-hit-13.wav"),
	load("res://audio/meteor-hit/heart-hit-14.wav"),
	load("res://audio/meteor-hit/heart-hit-15.wav"),
	load("res://audio/meteor-hit/heart-hit-16.wav"),
	load("res://audio/meteor-hit/heart-hit-17.wav"	),
]

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	#var path: String = "res://graphics/PNG/Meteors/" + str(meteorsTypePaths[rng.randi_range(0,1)]) + "_big" + str(rng.randi_range(1,4)) + ".png"
	#$MeteorImage.texture = load(path)
	$MeteorImage.scale = Vector2(1,1) * rng.randf_range(0.5,1)
	speed_y = speed_y * rng.randf_range(0.5,1)
	
	var screen_width = get_viewport().get_visible_rect().size[0]
	var screen_height = get_viewport().get_visible_rect().size[1]
	var random_x = rng.randi_range(0, screen_width)
	position = Vector2(random_x, 20)
	var top_variance_speed_x = (speed_y * screen_width * .6) / screen_height
	speed_x = rng.randi_range(-1 * top_variance_speed_x, top_variance_speed_x)
	rotation_speed = rng.randf_range(-120, 120)
	pass

func _process(delta: float) -> void:
	position += Vector2(1 * speed_x, 1 * speed_y)  * delta
	rotation_degrees += rotation_speed * delta
	pass

func _on_body_entered(_body: Node2D) -> void:
	if can_collide:
		collision.emit()
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	Global.total_hit += 1
	get_tree().call_group('ui', 'update_score')
	area.queue_free()
	$Explosion.stream = streams[rng.randi_range(0, len(streams)-1)]
	$Explosion.play()
	hide()
	position = Vector2(-100,-100)
	can_collide = false
	await get_tree().create_timer(1).timeout
	queue_free()
