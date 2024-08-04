extends Node2D

@onready var plane = preload("res://Assets/plane.tscn")
@onready var level = $"../"
var speed = 20

var rng = RandomNumberGenerator.new()

func _ready():
	var random = rng.randi_range(0,1)
	if random == 1:
		var instance = plane.instantiate()
		instance.position = Vector2(rng.randf_range(-500, 500), rng.randf_range(-500, 500))
		add_child(instance)

func _process(delta):
	if position.y > 2500:
		level.spawnModule(position.y + (level.amt * level.offset))
		queue_free()
