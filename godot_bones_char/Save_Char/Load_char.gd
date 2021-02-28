extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	load character 
	var character = load(OS.get_executable_path().get_base_dir().plus_file("Save_Char")+"/Unknow.tscn").instance()
	add_child(character)
	
	



