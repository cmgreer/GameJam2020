extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selected_option
var selected_character
signal status_character(charnum, status)

func change_selected_color():
	$Pointer0.color = Color("3C2828")
	$Pointer1.color = Color("3C2828")
	$Pointer2.color = Color("3C2828")
	
	match selected_option:
		0:
			$Pointer0.color = Color.yellow
		1:
			$Pointer1.color = Color.yellow
		2:
			$Pointer2.color = Color.yellow

func _input(event):
	if event is InputEventKey:
		var just_pressed = event.pressed and not event.echo
		
		if event.scancode == KEY_RIGHT and just_pressed:
			selected_option = (selected_option + 1) % 3;
			change_selected_color()
		elif event.scancode == KEY_LEFT and just_pressed:
			if selected_option > 0:
				selected_option = selected_option - 1
			else:
				selected_option = 2
			change_selected_color()
		elif event.scancode == KEY_SPACE and just_pressed:
			match selected_option:
				0:
					pass #TODO: choice 0
				1:
					pass #TODO: choice 1
				2:
					pass #TODO: choice 2

func status_character(): #unfinished
	for i in range(1,7):
		emit_signal("status_character", i, global.)
	
	match selected_character:
		0:
			$Pointer0.color = Color.yellow
		1:
			$Pointer1.color = Color.yellow
		2:
			$Pointer2.color = Color.yellow
		3:
			$Pointer2.color = Color.yellow
		4:
			$Pointer2.color = Color.yellow
		5:
			$Pointer2.color = Color.yellow

# Called when the node enters the scene tree for the first time.
func _ready():
	#reset menu choice
	selected_option = 0
	change_selected_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
