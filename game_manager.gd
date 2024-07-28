extends Node

signal game_over

var player: Player
var player_position: Vector2
var is_game_over: bool  = false

var time_elapsed = 0.0
var time_elapsed_str:String = "00:00"
var meat_amount:int = 0
var gold_amount:int = 0
var monsters_defeated:int = 0



func _process(delta):
	time_elapsed += delta
	var elapsed_seconds:int = floori(time_elapsed)
	var minutes:int = elapsed_seconds / 60
	var seconds:int = elapsed_seconds % 60
	time_elapsed_str = "%02d:%02d" % [minutes, seconds]

func end_game():
	if is_game_over: return
	is_game_over = true
	game_over.emit()
	
func reset():
	time_elapsed = 0.0
	time_elapsed_str = "00:00"
	meat_amount = 0
	gold_amount = 0
	monsters_defeated = 0
	player = null
	player_position = Vector2.ZERO
	is_game_over = false
	for connection in game_over.get_connections():
		game_over.disconnect(connection.callable)

func on_meat_collected(amount: int):
	meat_amount += amount
