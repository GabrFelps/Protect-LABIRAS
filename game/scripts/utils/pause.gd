extends CanvasLayer

func _ready():
	visible = false;

## Pausa ou despausa o jogo
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = !visible;
		get_tree().paused = !get_tree().paused;

## Resume o jogo
func _on_resume_pressed():
	visible = !visible;
	get_tree().paused = !get_tree().paused;

## Volta para o menu
func _on_menu_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://scenes/menu.tscn");
