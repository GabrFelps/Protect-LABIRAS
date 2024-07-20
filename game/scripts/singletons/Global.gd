extends Node


@onready var enemy_db: Dictionary = {};
@onready var game_db: Dictionary = {};

func _ready():
	get_db("enemy_db");
	get_db("game_db");
	
	
func get_db(page_name: String):
	var _file = FileAccess.open("res://data/"+page_name+".csv", FileAccess.READ);
	var _header = _file.get_csv_line();
	while !_file.eof_reached():
		var this_line = _file.get_csv_line();
		match page_name:
			"enemy_db":
				enemy_db[this_line[0]] = {};
				for i in range(1, len(_header)):
					enemy_db[this_line[0]][_header[i]] = this_line[i];
			"game_db":
				game_db[this_line[0]] = {};
				for i in range(1, len(_header)):
					game_db[this_line[0]][_header[i]] = this_line[i];
			
