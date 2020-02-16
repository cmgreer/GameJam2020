extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selected_option
var someoneInjured = 0
var popoutText
var chosen = 0
onready var popupPan = get_parent().get_parent().get_child(3)#getting popup panel



func change_scene(): #Unfinished
	if someoneInjured==1 && globalSingleton.character_status[2]>0 && globalSingleton.witch_potion>0: #if there is an injured character this scene, witch is alive and has potion
		#should jump to injured scene - need to change path
		globalSingleton.next_scene = 3
		get_tree().change_scene("res://OregonTrail/Scenes/injury.tscn")
	elif globalSingleton.character_status[0]==0: #if player is dead
		get_tree().change_scene("res://OregonTrail/Scenes/8.tscn")
	else: #Next Scene
		if globalSingleton.beast_status == 1: #if beast alive
			get_tree().change_scene("res://OregonTrail/Scenes/4.tscn")
		else:#if beast not alive
			get_tree().change_scene("res://OregonTrail/Scenes/5.tscn")

func setPopout(text):#called when popup before next scene
	popupPan.popup_centered(Vector2(300,160))
	popupPan.set_position(Vector2(10,10))
	popupPan.get_child(0).add_text(text)

func choice0(): #force way through
	popoutText = "The brave Player attempts to force their way through the THICK FOLIAGE. They clear a path for the rest of you, but injure themselves in the process."
	if globalSingleton.character_status[5]>0: #if hunter is healthy
		setPopout("The mighty WOODMAN hacks their way through the THICK FOLIAGE, clearing the way for the rest of you. You continue on your way.")
	else:
		for i in range(6,-1,-1): #injure first healthy character
			if globalSingleton.character_status[i]==2: #find first unlocked character
				change_status(i,1) #injure character
				popoutText = "The brave " + globalSingleton.character_name[i] + " attempts to force their way through the THICK FOLIAGE. They clear a path for the rest of you, but injure themselves in the process."
				break
		setPopout(popoutText)

func choice1(): #Go long way round
	if globalSingleton.run_beast==1:
		for i in range(6,-1,-1): #kill first healthy character
			if globalSingleton.character_status[i]>0: #find first unlocked character
				change_status(i,1) #kill character
				popoutText = "You attempt to navigate around the THICK FOLIAGE. However, it is slow going, and the TERRIBLE BEAST catches up with you and kills " + globalSingleton.character_name[i] + "."
				break
	else:
		popoutText = "You attempt to navigate around the THICK FOLIAGE. It takes a little longer, but otherwise you’re fine."
	setPopout(popoutText)
		

func change_selected_color():
	$Pointer0.color = Color("3C2828")
	$Pointer1.color = Color("3C2828")
	
	match selected_option:
		0:
			$Pointer0.color = Color.yellow
		1:
			$Pointer1.color = Color.yellow


func _input(event):
	if event is InputEventKey:
		var just_pressed = event.pressed and not event.echo
		
		if event.scancode == KEY_RIGHT and just_pressed:
			selected_option = 1 - selected_option
			change_selected_color()
		elif event.scancode == KEY_LEFT and just_pressed:
			selected_option = 1 - selected_option
			change_selected_color()
		elif event.scancode == KEY_SPACE and just_pressed:
			match selected_option:
				0:
					if chosen == 0:
						choice0()
						chosen = 1
					elif chosen == 1:
						change_scene()
				1:
					if chosen == 0:
						choice1()
						chosen = 1
					elif chosen == 1:
						change_scene()


func change_status(characterNum, status):
	globalSingleton.character_status[characterNum] = status
	if status == 1:
		globalSingleton.injured_char = characterNum
		someoneInjured = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#reset menu choice
	selected_option = 0
	change_selected_color()


