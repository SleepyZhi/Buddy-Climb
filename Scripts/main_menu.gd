extends Node2D

@export var levels : Array[PackedScene]
var amt : int = 3
var rng = RandomNumberGenerator.new()

@export var offset :float = 5 
@export var speed : float = 100

func _ready():
	for n in amt:
		spawnModule(n*offset)
	if !Bgm.is_playing():
		Bgm.play()

func _process(delta):
	for member in get_tree().get_nodes_in_group("bg"):
		member.position.y += speed * delta

func spawnModule(n):
	#rng.randomize()
	#var num = rng.randi_range(0, levels.size()-1)
	var instance = levels.pick_random().instantiate()
	instance.position.y = n
	add_child(instance)
	
#MENU HANDLING
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Level/test_scene.tscn")
	ButtonSound.play()

func _on_exit_button_pressed():
	get_tree().quit()
	ButtonSound.play()

func _on_close_button_pressed():
	$CanvasLayer/Tutorial.set_visible(false)
	ButtonSound.play()

func _on_tutorial_button_pressed():
	$CanvasLayer/Tutorial.set_visible(true)
	ButtonSound.play()
