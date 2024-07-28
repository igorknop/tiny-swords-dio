extends CanvasLayer


@onready var timer_label = $TimerLabel
@onready var gold_label = $ScorePanel/GoldLabel
@onready var meat_label = $ScorePanel/MeatLabel


func _process(delta):
	meat_label.text = str(GameManager.meat_amount)
	gold_label.text = str(GameManager.gold_amount)
	timer_label.text = GameManager.time_elapsed_str


