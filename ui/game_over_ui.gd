class_name GameOverUI
extends CanvasLayer

@onready var label_time_score = %LabelTimeScore
@onready var label_monsters_score = %LabelMonstersScore

@export var restart_delay: float = 5.0
var restar_cooldown: float

func _ready():
	label_time_score.text = str(GameManager.time_elapsed_str)
	label_monsters_score.text = str(GameManager.monsters_defeated)
	restar_cooldown = restart_delay
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	restar_cooldown -= delta
	if restar_cooldown <= 0.0:
		restart_game()
		
func restart_game():
	GameManager.reset()
	get_tree().reload_current_scene()
