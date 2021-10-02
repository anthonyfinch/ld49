extends Resource

signal counts_updated
signal time_up
signal health_updated
signal player_death
signal player_respawn

export (float) var time_limit = 60.0 * 3.0
export var level = "res://src/levels/Level1.tscn"

var health = 100 setget set_health
var player = null
var people = null
var on_board = 0
var safe = 0
var died = 0
var time = 0.0


func reset_counts():
	on_board = 0
	safe = 0
	died = 0
	emit_signal("counts_updated")
	set_health(100)


func set_health(new_val):
	health = new_val
	emit_signal("health_updated")


func person_died():
	died += 1
	emit_signal("counts_updated")


func collect_person():
	on_board += 1
	emit_signal("counts_updated")


func drop_off():
	safe += on_board
	on_board = 0
	emit_signal("counts_updated")
