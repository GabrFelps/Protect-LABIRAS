extends Node


@onready var enemy_db: Dictionary = {};
@onready var game_db : Dictionary = {};

var current_wave : int = 1; 

func _ready():
	get_db("enemy_db");
	get_db("game_db");
	
## Pega informações de um banco de dados .csv
func get_db(page_name: String):
	# arquivo
	var _file = FileAccess.open("res://data/"+page_name+".csv", FileAccess.READ);
	# cabecalho do arquivo
	var _header = _file.get_csv_line();
	
	# enquanto não estiver no fim da linha
	while !_file.eof_reached():
		# essa linha
		var this_line = _file.get_csv_line();
		match page_name:
			"enemy_db":
				enemy_db[this_line[0]] = {}; # cria um dicionário para o primeiro elemento da linha
				for i in range(1, len(_header)):
					# para cada item na linha, adiciona-se uma chave-valor
					# dentro do dicionario do primeiro elemento da linha
					enemy_db[this_line[0]][_header[i]] = this_line[i];
			"game_db":
				game_db[this_line[0]] = {};
				for i in range(1, len(_header)):
					game_db[this_line[0]][_header[i]] = this_line[i];
			
