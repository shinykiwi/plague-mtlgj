extends Control

var green = preload("res://green_style.tres")
var yellow = preload("res://yellow_style.tres")
var red = preload("res://red_style.tres")
@onready var bar = $ProgressBar

func _ready():
	bar.value = 10
	

func update_bar(amount, full):
	bar.value = amount
	print(bar.value)
	if amount < full:
		add_theme_stylebox_override("normal", yellow)
#	if value < 0.45 * full:
#		add_theme_stylebox_override("focus", red)
	

