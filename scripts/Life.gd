extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_player_life_changed(player_hearts: float):
	$Health.text = str("HP: ") + str(player_hearts)
