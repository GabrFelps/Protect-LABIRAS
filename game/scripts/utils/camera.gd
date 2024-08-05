extends Camera2D

@export var randomShakeStrenght : float = 30.0;
@export var shakeDecayRate : float = 5.0;
@export var noise  = FastNoiseLite.new();


@onready var rng = RandomNumberGenerator.new();
var shakeStrength : float = 0.0;

func _ready() -> void:
	rng.randomize(); # randomiza o rng

func apply_shake() -> void:
	shakeStrength = randomShakeStrenght; # tremor fica em seu maximo
	
	
func _physics_process(delta: float) -> void:
	# reduz a intensidade do tremor com o tempo
	shakeStrength = lerp(shakeStrength, 0.0, shakeDecayRate * delta);

	# vai mudando a posicao da camera pra criar o efeito de tremor de tela
	offset = get_random_offset();

func get_random_offset() -> Vector2:
	return Vector2(
		rng.randf_range(-shakeStrength, shakeStrength),
		rng.randf_range(-shakeStrength, shakeStrength)
	);
