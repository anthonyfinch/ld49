extends Control

onready var _level_holder = $Level

var _max_time = 100
var _state = preload("res://src/GameState.tres")
var _loader


func enter():
	_load_level(_state.level)


func _load_level(path):
	_loader = ResourceLoader.load_interactive(path)
	if _loader == null:
		# show_error()
		return

func _process(delta):
	if _loader == null:
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + _max_time:
		var err = _loader.poll()

		if err == ERR_FILE_EOF:
			var resource = _loader.get_resource()
			_loader = null
			_set_level(resource)
			break
		elif err == OK:
			pass
		# update_progress()
		else: # Error during loading.
			# show_error()
			_loader = null
			break


func _set_level(level):
	var instance = level.instance()
	for old in _level_holder.get_children():
		old.queue_free()

	_level_holder.add_child(instance)
