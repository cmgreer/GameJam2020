extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selected_option
var someoneInjured = 0
var popoutText
var chosen = 0
var killed = 0
var allChar = 1
var endingNum
var injuredNum=0
var deadNum=0
var endpath
onready var popupPan = get_parent().get_parent().get_child(3)#getting popup panel



func change_scene(): #Unfinished
	if someoneInjured==1 && globalSingleton.character_status[2]>0 && globalSingleton.witch_potion>0: #if there is an injured character this scene, witch is alive and has potion
		#should jump to injured scene - need to change path
		globalSingleton.next_scene = 3
		get_tree().change_scene("res://OregonTrail/Scenes/injury.tscn")
	elif globalSingleton.character_status[0]==0: #if player is dead
		get_tree().change_scene("res://OregonTrail/Scenes/8.tscn")
	else: #Next Scene
		if endingNum==8 or endingNum==13 or endingNum==12:
			endpath = "res://OregonTrail/Scenes/" + str(endingNum) +".tscn"
			get_tree().change_scene(endpath)
		else:
			#number of injured
			for i in range(0,7):
				if globalSingleton.character_status[i]==1:
					injuredNum = injuredNum + 1
				elif globalSingleton.character_status[i]==0:
					deadNum = deadNum + 1
			#alone and injured
			if globalSingleton.character_status[0]==1 and deadNum==6:
				endingNum = 9
			#alone
			elif globalSingleton.character_status[0]==2 and deadNum==6:
				endingNum = 10
			elif deadNum>1:
				endingNum = 11
			elif deadNum==0 and injuredNum>0:
				endingNum = 12
			endpath = "res://OregonTrail/Scenes/" + str(endingNum) +".tscn"
			get_tree().change_scene(endpath)	



func setPopout(text):#called when popup before next scene
	popupPan.popup_centered(Vector2(300,160))
	popupPan.set_position(Vector2(10,10))
	popupPan.get_child(0).add_text(text)

func choice0(): #One at a time
	for i in range(6,-1,-1): #injure first healthy character
		if globalSingleton.character_status[i]==1: #find first unlocked character
			change_status(i,0) #injure character
			popoutText = "You attempt to make your way across the RIVER individually. However, the injured " + globalSingleton.character_name[i] + " falls and is swept away by the RIVER."
			killed = 1
			break
	if killed == 0:
		for i in range(6,-1,-1): #injure first healthy character
			if globalSingleton.character_status[i]==2: #find first unlocked character
				change_status(i,1) #injure character
				popoutText = "You attempt to make your way across the RIVER individually. Along the way, the hardy " + globalSingleton.character_name[i] + " slips and nearly falls, injuring themselves on the rocks."
				break
	setPopout(popoutText)

func choice1(): #Work together
	for i in range(0,7):
		if globalSingleton.character_status[i]==0:
			allChar = 0
	if allChar==0: #if don't have every character, all die
		setPopout("You join together, attempting to ford the RIVER as a group. However, you simply don’t have enough people to maintain your hold, and everyone is swept away.")
		endingNum = 8
	else:
		setPopout("You link arms, attempting to ford the RIVER as you’ve done the rest of this adventure: TOGETHER. You make your way to the other side, stronger for your companions’ support.")
		endingNum = 13
		for i in range(0,7):
			if globalSingleton.character_status[i]==1:
				endingNum = 12
				break
		
		

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


