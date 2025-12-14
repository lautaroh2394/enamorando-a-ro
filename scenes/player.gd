extends CharacterBody2D
@export var speed: int = 500
signal laser(pos)
static var streams = [
	load("res://audio/kiss-blown/beso-1.wav"),
	load("res://audio/kiss-blown/beso-2.wav"),
	load("res://audio/kiss-blown/beso-3.wav"),
	load("res://audio/kiss-blown/beso-4.wav"),
]

static var streams_damage = [
	load("res://audio/spaceship-hit/grito-1.wav"),
	load("res://audio/spaceship-hit/grito-2.wav"),
	load("res://audio/spaceship-hit/grito-3.wav"),
	load("res://audio/spaceship-hit/grito-4.wav"),
	load("res://audio/spaceship-hit/grito-5.wav"),
	load("res://audio/spaceship-hit/grito-6.wav"),
	load("res://audio/spaceship-hit/grito-7.wav"),
]

var rng: RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	
func _process(_delta):
	var direction = Input.get_vector("left", "right","up", "down")
	velocity= direction * speed 
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	pass

func play_collision_sound():
	$DamageSound.stream = streams_damage[rng.randi_range(0, len(streams_damage)-1)]
	$DamageSound.play()

func shoot():
	Global.total_shot += 1
	laser.emit($LaserStartPosition.global_position)
	$ShootTimer.start()
	$LaserSound.stream = streams[rng.randi_range(0, len(streams)-1)]
	$LaserSound.play()

func _on_shoot_timer_timeout() -> void:
	print("shoot")
	shoot()
