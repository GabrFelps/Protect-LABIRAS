extends Node2D

signal finish_anim;

@onready var popUp : Label = get_node("CanvasLayer/Label");

func _ready():
	popUp.visible = false;
	Global.showingPopUp = false;
	_bg_start_anim();
	_camera_start_anim();
	await (get_tree().create_timer(3).timeout);
	Global.showingPopUp = true;

func _physics_process(delta):
	if Global.showingPopUp:
		get_node("Cannon").set_physics_process(false);
		popUp.visible = true;


func _bg_start_anim():
	var _bg : TextureRect = $BG/TextureRect;
	_bg.position.y = -60;
	var _tween = get_tree().create_tween();
	_tween.tween_property(
		_bg,
		"position",
		Vector2(0.0,-480.0),
		1.0
	).set_trans(Tween.TRANS_QUAD);


func _camera_start_anim():
	var _camera : Camera2D = $Camera2D;
	_camera.position.y = -600;
	var _tween = get_tree().create_tween();
	_tween.tween_property(
		_camera,
		"position",
		Vector2(654,140),
		1.0
	).set_trans(Tween.TRANS_QUAD);
