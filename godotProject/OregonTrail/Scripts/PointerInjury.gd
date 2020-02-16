extends ColorRect

var selected_option
var nextScene
var scenePath

func change_selected_color():
	$Pointer0.color = Color("3C2828")
	$Pointer1.color = Color("3C2828")
	
	match selected_option:
		0:
			$Pointer0.color = Color.yellow
		1:
			$Pointer1.color = Color.yellow

func _input(event):
	scenePath = "res://OregonTrail/Scenes/" + str(globalSingleton.next_scene) + ".tscn"
	
	
	if event is InputEventKey:
		var just_pressed = event.pressed and not event.echo
		
		if event.scancode == KEY_UP and just_pressed:
			selected_option = 1 - selected_option;
			change_selected_color()
		elif event.scancode == KEY_DOWN and just_pressed:
			selected_option = 1 - selected_option;
			change_selected_color()
		elif event.scancode == KEY_SPACE and just_pressed:
			match selected_option:
				0:
					globalSingleton.witch_potion = 0
					globalSingleton.character_status[globalSingleton.injured_char] = 2
					get_tree().change_scene(scenePath)
				1:
					get_tree().change_scene(scenePath)



# Called when the node enters the scene tree for the first time.
func _ready():
	selected_option = 0
	change_selected_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
