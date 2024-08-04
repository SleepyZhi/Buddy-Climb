extends Node2D

@export var sprite1 : Sprite2D
@export var sprite2 : Sprite2D

@export var sprites : Array[CompressedTexture2D]
var rng = RandomNumberGenerator.new()

func _ready():
	var rnd = rng.randi_range(0, sprites.size()-1)
	sprite1.texture = sprites[rnd]
	sprite1.get_parent().spriteID = rnd
	sprite1.get_parent().oriSprite = sprites[rnd]
		
	rnd = rng.randi_range(0, sprites.size()-1)
	sprite2.texture = sprites[rnd]
	sprite2.get_parent().spriteID = rnd
	sprite2.get_parent().oriSprite = sprites[rnd]
	while sprite1.texture == sprite2.texture:
		rnd = rng.randi_range(0, sprites.size()-1)
		sprite2.get_parent().spriteID = rnd
		sprite2.get_parent().oriSprite = sprites[rnd]
		sprite2.texture = sprites[rnd]
