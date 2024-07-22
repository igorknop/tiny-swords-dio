extends CanvasLayer

var time_elapsed = 0.0
var meat_amount:int = 0
var gold_amount:int = 0
@onready var timer_label = $TimerLabel
@onready var gold_label = $ScorePanel/GoldLabel
@onready var meat_label = $ScorePanel/MeatLabel

func _ready():
	GameManager.player.meat_collected.connect(on_meat_collected)

func _process(delta):
	time_elapsed += delta
	var elapsed_seconds:int = floori(time_elapsed)
	var minutes:int = elapsed_seconds / 60
	var seconds:int = elapsed_seconds % 60
	
	timer_label.text = "%02d:%02d" % [minutes, seconds]
	meat_label.text = str(meat_amount)
	gold_label.text = str(gold_amount)

func on_meat_collected(amount: int):
	meat_amount += amount
