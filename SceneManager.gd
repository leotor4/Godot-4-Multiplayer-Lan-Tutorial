extends Node2D

@export var PlayerScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var hearts = get_node("/root/Node2D/UI/Life")
	
	var index = 0
	for i in GameManager.Players:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.Players[i].id)
		currentPlayer.connect("life_changed", hearts.on_player_life_changed)
		add_child(currentPlayer)
		currentPlayer.add_to_group("players")
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
		index += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
