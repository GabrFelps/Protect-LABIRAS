extends Node
@onready var enemy_db: Dictionary = {};
@onready var game_db : Dictionary = {};
# tutorial controls
var showingPopUp: bool = false

# referência ao no do inimigo
var enemyNode = null;
# referência ao level
var levelNode = null;

# signal para atualizar as propiedades do jogo
signal update_game_properties;
signal wave_changed;
# array que ja foram iniciadas
var waves : Array = [1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50];
# inimigos ja instanciados
var enemies_already_instatiated = 0;
var points : int = 0;
var current_wave : int = 1; 
var enemy_database : Dictionary = {};
const base_number_enemies : int = 8;
var max_enemy_per_wave : int;
var dead_enemies_in_wave: int = 0;
var seek_music = 0

func _ready():
	max_enemy_per_wave = int((1.08 ** current_wave) + current_wave + 3);
	get_db("enemy_db");
	get_db("game_db");

func _physics_process(delta) -> void:
	if enemyNode != null:
		enemyNode.all_enemies_died.connect(change_wave);
		enemyNode = null;
	
## função para restaurar as propiedades do jogo
func restore_properties_game() -> void:

	current_wave = 40;
	points = 0;
	max_enemy_per_wave = int((1.08 ** current_wave) + current_wave + 3);
	enemies_already_instatiated = 0;
	dead_enemies_in_wave = 0;

## função que verifica quando pode ser atualizada as propiedades do jogo
func update_properties() -> void:
	if current_wave in waves:
		emit_signal("update_game_properties");

## Pega uma chave de valores do arquivo .csv para o inimigo
func get_enemy_struct(enemykey : String) -> Dictionary:
	return enemy_db.get(enemykey, {});
	
## função para mudar de wave
func change_wave() -> void:
	dead_enemies_in_wave = 0;
	current_wave += 1;
	update_properties();
	max_enemy_per_wave = int((1.08 ** current_wave) + current_wave + 3);
	# atualiza o valor de inimigos instanciados
	enemies_already_instatiated = 0;
	start_spawn_timer();
	print("current wave: ", current_wave);
	print("Max enemies in wave: ", max_enemy_per_wave);
	emit_signal("wave_changed");
	
## função para iniciar o spawn_timer quando mudar de uma wave para a outra
func start_spawn_timer() -> void:
	levelNode.spawn_timer.start();


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
			
func peido(prev, act):
	print('glopsol')
