extends CharacterBody2D

@export var other : CharacterBody2D
@export var id : int
@export var spriteID : int

@export var sprites : Array[CompressedTexture2D]
@export var oriSprite : CompressedTexture2D

var selected : bool = false
var speed : float = 12
var count : int = 0
var physics : bool = false
var playing : bool = false

# I love couting circles
@export var radius : float
@export var grounded1 : bool = false
@export var grounded2 : bool = false
@export var scene : Node

func _ready():
	Engine.time_scale = 1

func _process(delta):
	groundedHandling()
	scene.playing = playing
	
	if !grounded1 and name == "RopeHolder":
		$Sprite2D.texture = sprites[spriteID]
	elif !grounded2 and name == "RopeEnd":
		$Sprite2D.texture = sprites[spriteID]
	elif grounded1 and name == "RopeHolder":
		$Sprite2D.texture = oriSprite
	elif grounded2 and name == "RopeEnd":
		$Sprite2D.texture = oriSprite

func groundedHandling():
	if $RayCast2D.is_colliding():
		var platform = $RayCast2D.get_collider()
		if platform.is_in_group("platform"):
			if name == "RopeHolder":
				grounded1 = true
			elif name == "RopeEnd":
				grounded2 = true
	elif $RayCast2D2.is_colliding():
		var platform = $RayCast2D2.get_collider()
		if platform.is_in_group("platform"):
			if name == "RopeHolder":
				grounded1 = true
			elif name == "RopeEnd":
				grounded2 = true
	elif $RayCast2D3.is_colliding():
		var platform = $RayCast2D3.get_collider()
		if platform.is_in_group("platform"):
			if name == "RopeHolder":
				grounded1 = true
			elif name == "RopeEnd":
				grounded2 = true
	else:
		if name == "RopeHolder":
			grounded1 = false
		elif name == "RopeEnd":
			grounded2 = false

func _input(event):
	if event is InputEventScreenTouch: 
		if event.index > 0:
			playing = true
		else:
			playing = false
	if event is InputEventScreenDrag and selected and scene.dead == false:
		if event.index == 0 and id == 0:
			var direction = (event.position - global_position).normalized()
			if global_position.distance_to(other.global_position) > radius:
				# velocity breaks it, I have to somehow set the global position while still able to use velocity to act on collision objects
				# maybe do a switchero when his area2D hits a platform to velocity mode? 
				if physics:
					var angle = atan2(event.position.y - other.global_position.y, event.position.x - other.global_position.x)
					velocity.x = other.global_position.x + radius * cos(angle)
					velocity.y = other.global_position.y + radius * sin(angle)
				else:
					var angle = atan2(event.position.y - other.global_position.y, event.position.x - other.global_position.x)
					global_position.x = other.global_position.x + radius * cos(angle)
					global_position.y = other.global_position.y + radius * sin(angle)
			velocity = direction * speed
			move_and_collide(velocity)
			other.id = 1
		if event.index == 1 and id == 1:
			var direction = (event.position - global_position).normalized()
			velocity = direction * speed
			move_and_collide(velocity)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if event.pressed:
			selected = true
		else:
			selected = false
			other.id = 0
	

func _on_area_2d_area_entered(area):
	physics = true

func _on_area_2d_area_exited(area):
	physics = false


