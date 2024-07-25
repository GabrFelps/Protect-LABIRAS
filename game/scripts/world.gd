extends Node2D

var enemy = preload("res://scenes/enemies/enemy.tscn")
@onready var top = $Top
@onready var bottom = $Bottom

func _ready():
	move_camera_to_place();

func _get_random_position() -> Vector2:
	return Vector2(top.global_position.x, randf_range(top.global_position.y, bottom.global_position.y))
	
func _on_spawn_timer_timeout():
		var enemy_instance = enemy.instantiate()
		enemy_instance.global_position = _get_random_position()
		add_child(enemy_instance)
		
		var nodes = get_tree().get_nodes_in_group("spawn")
		var node = nodes[randi() % nodes.size()]

func move_camera_to_place():
	$CanvasLayer/TextureRect.global_position = Vector2(0 ,-480);
	$Camera2D.zoom = Vector2(1.0,1.0);
	$Camera2D.position = Vector2(-480.0,270.0);
	var _bgTween = get_tree().create_tween();
	var _cameraPosTween = get_tree().create_tween();
	var _cameraZoomTween = get_tree().create_tween();
	_cameraZoomTween.tween_property($Camera2D, "zoom", Vector2(0.67,0.67), 3).set_trans(Tween.TRANS_QUART);
	_cameraPosTween.tween_property($Camera2D, "position", Vector2(654, 140), 3).set_trans(Tween.TRANS_QUART);
	_bgTween = _bgTween.tween_property($CanvasLayer/TextureRect, "position", Vector2(-480,-540), 3).set_trans(Tween.TRANS_QUART);
	
	
