extends Area2D

@export var initialSpeed : float
@export var acceleration : float
@export var rate : float

@export var canvas : Node

@export var slowdown : float
var speed : float
var finalSpeed : float

func _ready():
	speed = initialSpeed

func _process(delta):
	# do via higher the score, the harder it'll be
	rate = canvas.score / 100
	speed = acceleration * rate
	finalSpeed = (speed * delta) - slowdown
	if finalSpeed < 0:
		finalSpeed = 0
	position.y -= finalSpeed
	canvas.get_node("WaveSpeed").text = str(finalSpeed)
	
	if position.y > 1300:
		position.y = 1300

func _on_send_particles_area_entered(area):
	if area.is_in_group("Player"):
		area.get_parent().get_node("CPUParticles2D").set_emitting(true)



func _on_send_particles_area_exited(area):
	if area.is_in_group("Player"):
		area.get_parent().get_node("CPUParticles2D").set_emitting(false)
