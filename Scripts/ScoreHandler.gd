extends CanvasLayer

const SAVEFIlE = "user://savefille.save"

@export var score : int = 0
var highscore : int

func _ready():
	load_score()

func _process(delta):
	$Score.text = "Score: \n" + str(score)
	$"Pause/High Score".text = "HighScore: \n" + str(highscore)
	$"Lose Screen BG/High Score".text = "HighScore: \n" + str(highscore)
	$"Lose Screen BG/Score".text = "Score: \n" + str(score)
	if score > highscore:
		highscore = score


func save_score():
	var file = FileAccess.open(SAVEFIlE, FileAccess.WRITE_READ)
	file.store_32(highscore)
	file = null


func load_score():
	var file = FileAccess.open(SAVEFIlE, FileAccess.READ)
	if FileAccess.file_exists(SAVEFIlE):
		highscore = file.get_32()


func _on_restart_button_pressed():
	ButtonSound.play()
	get_tree().reload_current_scene()


func _on_exit_button_pressed():
	ButtonSound.play()
	get_tree().change_scene_to_file("res://Level/main_menu.tscn")
	
