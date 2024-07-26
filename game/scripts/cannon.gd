extends Area2D
@onready var cannonBall : PackedScene = preload("res://scenes/cannonball.tscn");
@onready var launchDirection : float;
@onready var shootingMarker: Marker2D = $CannonBarrel/ShootingPosition;
@onready var trajectory : Line2D = %Trajectory;
@onready var firingParticles : PackedScene = preload("res://scenes/firing_particles.tscn");

var launchPower : float = 0.0;
var maxPoints : int = 125;
var damage = 10;

@export var launchPowMultiplier: float;

func _ready():
	#update_cannon_damage();
	trajectory.hide();

func _physics_process(delta: float):
	look_to_mouse($CannonBarrel);
	_update_trajectory(delta);
	
	# Aumenta a força
	if launchPower > 0:
		launchPower = min(launchPower + 0.7, 100.0);
	trajectory.modulate.a = launchPower/45; # estética de aumento de opacidade

## Input do mouse
func _input(event: InputEvent) -> void:
	#print(event);
	if event is InputEventMouseButton:
		if event.button_index == 1:
			# Aumentar a força da bola
			if event.is_pressed():
				trajectory.show();
				launchPower += 0.1;
				
			# Soltar a bola
			if event.is_released():
				launchDirection = $CannonBarrel.rotation_degrees;
				var _shootingPos = shootingMarker.global_position;
				shoot(launchPower, _shootingPos);
				launchPower = 0.0;
				trajectory.hide();
				emit_firing_particles();

## Atualiza o dano da bala de canhão de acordo com a wave atual
func update_cannon_damage() -> void:
	damage = int(Global.game_db[str(Global.current_wave)]["cannon_damage"]);
	print("cannon damage: ",damage);

## Atira uma bola de canhão com a força e posição setadas
func shoot(launchPower: float, shootingPosition) -> void:
	#print("Projétil disparado com %s na direção %s graus." %[launchPower, launchDirection]);
	# Instancia da bola
	var _cannonball = cannonBall.instantiate();
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

## Atualiza a trajetória do projétil
func _update_trajectory(delta):
	trajectory.clear_points(); # limpa a trajetoria anterior
	#print(shootingMarker.global_position)
	var pos = Vector2.ZERO;
	var vel = shootingMarker.global_transform.x * launchPower*launchPowMultiplier;
	for i in maxPoints:
		trajectory.add_point(pos);
		trajectory.global_rotation = 0;
		vel.y += gravity * delta;
		pos += vel * delta;
		if pos.y > get_node("/root/World/Ground").position.y - 225:
			break
			
## Emite as particulas do tiro do canhão
func emit_firing_particles():
	var _particles : CPUParticles2D = firingParticles.instantiate();
	_particles.one_shot = true;
	_particles.set_emitting(true);
	_particles.global_position = Vector2.ZERO
	shootingMarker.add_child(_particles)
