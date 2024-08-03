extends Control

signal finish;
@onready var audio_player : AudioStreamPlayer = $AudioPlayer

func _ready():
	audio_player.stream.set_loop(true);
	blank_nodes();
	bg_starting_animation();
	await finish;
	title_starting_animation();
	await finish;
	buttons_starting_animation();

func _on_start_pressed():
	Global.restore_properties_game();
	for node in get_children():
		if node is Control:
			var _tween = get_tree().create_tween();
			_tween.tween_property(node, "modulate", Color(1.0,1.0,1.0,0.0), 1.0);
			if node.get_index() == 2:
				_tween.tween_property($CanvasLayer/Image, "modulate", Color(0.86,0.86,0.86,1.0),0.5)
				await _tween.finished;
				
	get_tree().change_scene_to_file("res://scenes/world.tscn");

func _on_tutorial_pressed():
	for node in get_children():
		if node is Control:
			var _tween = get_tree().create_tween();
			_tween.tween_property(node, "modulate", Color(1.0,1.0,1.0,0.0), .7);
			if node.get_index() == 2:
				_tween.tween_property($CanvasLayer/Image, "modulate", Color(0.86,0.86,0.86,1.0),0.5)
				await _tween.finished;
	bg_up_animation();
	await finish;
	Global.seek_music = audio_player.get_playback_position()
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn");

func _on_exit_pressed():
	get_tree().quit();

func bg_starting_animation():
	$CanvasLayer/Image.position.y = -60;
	var _tween = get_tree().create_tween();
	_tween.tween_property (
		$CanvasLayer/Image,
		"position",
		Vector2(0.0,
		-480.0),
		1.5
	).set_trans(Tween.TRANS_CUBIC);
	await _tween.finished
	emit_signal("finish");

func bg_up_animation():
	var _tween = get_tree().create_tween();
	_tween.tween_property (
		$CanvasLayer/Image,
		"position",
		Vector2(0.0,
		-60.0),
		2.0
	).set_trans(Tween.TRANS_QUINT);
	await _tween.finished
	emit_signal("finish");

func blank_nodes():
	for node in get_children():
		for leaf in node.get_children():
			if leaf.get_class() in ["Button", "Panel", "Label"]:
				leaf.modulate.a = 0;
			

func title_starting_animation():
	for node in $Title.get_children():
		var _tween = get_tree().create_tween();
		_tween.tween_property(node,"modulate", Color(1,1,1,1), 1.5).set_trans(Tween.TRANS_LINEAR);
		if node.get_index() == 1:
			await _tween.finished;
			emit_signal("finish");


func buttons_starting_animation():
	for button in $Buttons.get_children():
		var _tween = get_tree().create_tween();
		var _tween1 = get_tree().create_tween();
		_tween.tween_property (
			button,
			"position",
			Vector2(button.position.x + 500,
			button.position.y),
			0.15
			);
		_tween1.tween_property(button, "modulate", Color(1,1,1,1), .3);
		
		await(_tween1.finished);

