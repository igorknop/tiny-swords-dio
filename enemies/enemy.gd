class_name Enemy
extends Node2D

@export var health: int = 10

func damage(amount: int)->void:
	health -= amount
	print("I lost ", amount, " hit points! Now I have ", health, " hp.")
