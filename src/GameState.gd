extends Resource

signal counts_updated
signal time_up

export (float) var time_limit = 60.0 * 3.0

var player = null
var people = null
var on_board = 0
var safe = 0
var died = 0
var time = 0.0


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
