extends Node2D
@onready var label = $Node2D/Label

var value: int =0 

func _ready():
	label.text = str(value)
