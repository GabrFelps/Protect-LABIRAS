extends CanvasLayer

signal fade_out

func _ready():
	visible = false;

## Pausa ou despausa o jogo
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if not visible:
			_pause_animation("pause")

		else:
			_pause_animation("unpause")
		


## Resume o jogo
func _on_resume_pressed():
	_pause_animation("unpause")

## Volta para o menu
func _on_menu_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://scenes/menu.tscn");
	

func _pause_animation(mode: String):
	match mode:
		"pause":
			get_tree().paused = !get_tree().paused;
			visible = true;
			for child in get_children():
				child.modulate.a = 0;
				var _tween = get_tree().create_tween();
				_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS);
				_tween.tween_property(child, "modulate", Color(1.0,1.0,1.0,1.0),0.4);

		"unpause":
			for child in get_children():
				var _tween = get_tree().create_tween();
				_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS);
				_tween.tween_property(child, "modulate", Color(1.0,1.0,1.0,0.0),0.2);
				if child.get_index() == get_child_count() - 1:
					await _tween.finished;
			visible = false;
			get_tree().paused = !get_tree().paused;
			
