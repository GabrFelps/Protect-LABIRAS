extends Area2D
@onready var cannonBall : PackedScene = preload("res://scenes/cannonball.tscn");
@onready var launchDirection : float;
@onready var shootingMarker: Marker2D = $CannonBarrel/ShootingPosition;

var launchPower: float = 0.0;

@export var launchPowMultiplier: float

func _physics_process(delta: float):
	look_to_mouse($CannonBarrel);
	if launchPower > 0:
		launchPower = min(launchPower + 0.7, 100.0);
		#print("Power: ", launchPower)

## Input do mouse
func _input(event: InputEvent) -> void:
	#print(event);
	if event is InputEventMouseButton:
		# Aumentar a força da bola
		if event.is_pressed():
			launchPower += 0.1;
			
		# Soltar a bola
		if event.is_released():
			launchDirection = $CannonBarrel.rotation_degrees;
			var _shootingPos = shootingMarker.global_position
			shoot(launchPower, _shootingPos);
			launchPower = 0.0;

## Atira uma bola de canhão com a força e posição setadas
func shoot(launchPower: float, shootingPosition) -> void:
	print("Projétil disparado com %s na direção %s graus." %[launchPower, launchDirection]);
	# Instancia da bola
	var _cannonball = cannonBall.instantiate() as RigidBody2D;
	# Posicao da bola começa sendo a do marker
	_cannonball.global_position = shootingPosition;
	
	# Angulo do tiro em radianos e suas funções trigonometricas
	var _launchRadians = deg_to_rad(launchDirection);
	var _x = cos(_launchRadians) * launchPowMultiplier;
	var _y = sin(_launchRadians) * launchPowMultiplier;
	
	# Aplica uma força na bola de canhão e adiciona ela no mundo
	_cannonball.apply_central_impulse(Vector2(_x * launchPower, _y * launchPower));
	get_node("/root/World").add_child(_cannonball);

## Faz um node "olhar" para o mouse
func look_to_mouse(node: Node):
	node.look_at(get_global_mouse_position());
	node.rotation_degrees = clamp(rad_to_deg(get_angle_to(get_global_mouse_position())),-60,60);
