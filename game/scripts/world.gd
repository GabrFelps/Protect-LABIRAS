extends Node2D

var enemy = preload("res://scenes/enemy.tscn")
@onready var top = $Top
@onready var bottom = $Bottom

func _ready():
	pass # Replace with function body.

func _get_random_position() -> Vector2:
	return Vector2(top.global_position.x, randf_range(top.global_position.y, bottom.global_position.y))
	
func _on_spawn_timer_timeout():
		var enemy_instance = enemy.instantiate()
		enemy_instance.global_position = _get_random_position()
		add_child(enemy_instance)
		
		var nodes = get_tree().get_nodes_in_group("spawn")
		var node = nodes[randi() % nodes.size()]
