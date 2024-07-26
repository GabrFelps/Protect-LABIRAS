extends Node
@onready var enemy_db: Dictionary = {};
@onready var game_db : Dictionary = {};
#var sprite_dict : Dictionary = {
	#"porco" : preload("res://animations/porco.tres"),
	#"preguica" : preload("res://animations/preguica.tres"),
	#"café" : preload("res://animations/cafe.tres"),
	#"prostiranha" : preload("res://animations/prostiranha.tres"),
	#"formiga" : preload("res://animations/formiga.tres"),
#};

# referência ao no do inimigo
var enemyNode = null;

# array que ja foram iniciadas
var waves_already_started : Array = ["1"];

var current_wave : int = 1; 
var enemy_database : Dictionary = {};
var base_number_enemies : int = 8;
var max_enemy_per_wave : int;
var dead_enemies_in_wave: int = 0;

func _ready():
	get_db("enemy_db");
	get_db("game_db"); 

func _process(delta) -> void:
	max_enemy_per_wave = int(base_number_enemies * (1.08 ** current_wave));
	if enemyNode != null:
		enemyNode.all_enemies_died.connect(change_wave);
		enemyNode = null;
	
func get_enemy_struct(enemykey : String) -> Dictionary:
	return enemy_db.get(enemykey, {})
	
#func get_enemy_sprite(enemykey: String) -> SpriteFrames:
	#return sprite_dict.get(enemykey)
	
## função para mudar de wave
func change_wave() -> void:
	dead_enemies_in_wave = 0;
	current_wave = next_wave(game_db);
	print("current wave: ", current_wave);
	
## função que retorna o valor da próxima wave
func next_wave(dict : Dictionary) -> int:
	var _waves_started = waves_already_started;
	var _keys_of_dict = dict.keys();
	for key in _keys_of_dict:
		if key in _waves_started:
			continue;
		waves_already_started.append(key);
		return int(key);
	return 0;
	
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
			
