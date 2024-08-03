extends Node2D

signal camera_finished;

func _ready() -> void:
	$CanvasLayer/Buttons.visible = false;
	move_camera_to_place();
	await camera_finished;
	show_result_final();
	
## Transição de câmera
func move_camera_to_place():
	$CanvasLayer/TextureRect.global_position = Vector2(0 ,-480);
	$Camera2D.zoom = Vector2(1.0,1.0);
	$Camera2D.position = Vector2(654,140.0);
	var _bgTween = get_tree().create_tween();
	var _cameraPosTween = get_tree().create_tween();
	var _cameraZoomTween = get_tree().create_tween();
	_cameraZoomTween.tween_property($Camera2D, "zoom", Vector2(0.67,0.67), 3).set_trans(Tween.TRANS_QUART);
	_cameraPosTween.tween_property($Camera2D, "position", Vector2(654, 140), 3).set_trans(Tween.TRANS_QUART);
	_bgTween = _bgTween.tween_property($CanvasLayer/TextureRect, "position", Vector2(-960,-480), 3).set_trans(Tween.TRANS_QUART);
	await _bgTween.finished;
	emit_signal("camera_finished");

func show_result_final() -> void:
	$CanvasLayer/Label.text = "Wall was destroyed!\nPoints: " + str(Global.points);
	$CanvasLayer/Label.visible = true;
	$CanvasLayer/Buttons.visible = true;
	$CanvasLayer/Label2.visible = true;

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn");
