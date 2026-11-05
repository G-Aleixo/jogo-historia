extends Node

var save_path: String = "user://savefile.save"

#things to save and load
var to_save: Array

func save_save():
	assert(save_path.get_file(), "Save path is not a valid file")
	
	var save := {}
	
	for saving in to_save:
		save[saving.get_id()] = saving.serialize()
	
	var as_string = JSON.stringify(save)
	
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_file.store_var(as_string, true)
	
	save_file.close()

func load_save():
	assert(save_path.get_file(), "Save path is not a valid file")
	
	var save_file = FileAccess.open(save_path, FileAccess.READ)
	
	var as_dict = JSON.parse_string(save_file.get_var(true))
	
	for to_load in to_save:
		if as_dict[to_load.get_id()]:
			to_load.deserialize(as_dict[to_load.get_id()])
