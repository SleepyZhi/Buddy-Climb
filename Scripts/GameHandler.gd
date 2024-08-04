extends Node2D

#var score : int = 0
#var highscore : int

@export var levels : Array[PackedScene]
var amt : int = 3
var rng = RandomNumberGenerator.new()
@export var offset :float = 5 
@export var playing : bool
@export var holder : CharacterBody2D
@export var holder2 : CharacterBody2D
@export var dead : bool = false
@export var speed : float

func _ready():
	if !Bgm.is_playing():
		Bgm.play()
	
	for n in amt:
		spawnModule(n * offset)
	#score = 0


func _process(delta):
	if (holder.grounded1 and holder2.grounded2):
		for member in get_tree().get_nodes_in_group("bg"):
			member.position.y += speed * delta
		$Wave.position.y += speed * delta
		
		if !dead:
			$CanvasLayer.score += speed /100
		
	if !dead:
		if !playing:
			$CanvasLayer/Pause.set_visible(true)
		else:
			$CanvasLayer/Pause.set_visible(false)
	elif dead:
		$"CanvasLayer/Lose Screen BG".set_visible(true)
		$CanvasLayer/Pause.set_visible(false)

func spawnModule(n):
	rng.randomize()
	var num = rng.randi_range(0, levels.size()-1)
	var instance = levels[num].instantiate()
	instance.position.y = n
	add_child(instance)


func _on_wave_area_entered(area):
	if area.is_in_group("player"):
		$CanvasLayer.save_score()
		Bgm.stop()
		$WaveSounds.stop()
		$Lose.play()
		Engine.time_scale = 0
		dead = true
