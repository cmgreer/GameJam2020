extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selected_option
var changed = 0
onready var popupPan = get_parent().get_parent().get_child(3)#getting popup panel

func change_scene(): #called when scene is changed (unfinished)
	#player dead
	#character dead
	#next scene
	pass 

func setPoput(text):#called when popup before next scene
	popupPan.popup_centered(Vector2(300,160))
	popupPan.set_position(Vector2(10,10))
	text = "[center]"+"[/center]"
	popupPan.get_child(0).append_bbcode(text)

func choice0(): #fight
	if globalSingleton.character_status[1]==2:
		change_status(1,1) #hunter injured
		setPoput("The brave HUNTER fights the TERRIBLE BEAST! They are gravely injured, but they have slain the creature. You continue on your way.")
	else:
		for i in range(1,7):
			if globalSingleton.character_status[i]==2: #find first unlocked character
				change_status(i,0) #dead character
				changed = 1
		if changed==0:
			change_status(0,0)#player dead
			
func choice1(): #run
	pass
func choice2(): #intimidate
	pass

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
					choice0()
				1:
					choice1()
				2:
					choice2()

func change_status(characterNum, status):
	globalSingleton.character_status[characterNum] = status

# Called when the node enters the scene tree for the first time.
func _ready():
	#reset menu choice
	selected_option = 0
	change_selected_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
