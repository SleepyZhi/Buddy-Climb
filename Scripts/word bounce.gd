extends Sprite2D

var time : float
var rng = RandomNumberGenerator.new()
var initialPos : float

func _ready():
	time = rng.randi_range(0, 10000)
	initialPos = global_position.y

func _process(delta):
	time += delta
	
	global_position.y = initialPos + sin(time * 2) * 50
