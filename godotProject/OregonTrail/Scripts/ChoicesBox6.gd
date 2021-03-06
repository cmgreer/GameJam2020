extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selected_option
var someoneInjured = 0
var popoutText
var chosen = 0
var changed = 0
onready var popupPan = get_parent().get_parent().get_child(3)#getting popup panel



func change_scene(): #Unfinished
	if someoneInjured==1 && globalSingleton.character_status[2]>0 && globalSingleton.witch_potion>0: #if there is an injured character this scene, witch is alive and has potion
		#should jump to injured scene - need to change path
		globalSingleton.next_scene = 2
		get_tree().change_scene("res://OregonTrail/Scenes/injury.tscn")
	elif globalSingleton.character_status[0]==0: #if player is dead
		get_tree().change_scene("res://OregonTrail/Scenes/8.tscn")
	else: #Next Scene
		get_tree().change_scene("res://OregonTrail/Scenes/7.tscn")

func setPopout(text):#called when popup before next scene
	popupPan.popup_centered(Vector2(300,160))
	popupPan.set_position(Vector2(10,10))
	popupPan.get_child(0).add_text(text)

func choice0(): #Climb Over
	popoutText = "You attempt to clamber over the ROCKSLIDE. In the process, Player falls and is injured."
	for i in range (6,0,-1): #if have injury death
		if globalSingleton.character_status[i]==1:
			change_status(i,0)
			popoutText = "You attempt to clamber over the ROCKSLIDE. Due to their injury, " + globalSingleton.character_name[i] + " falls between the rocks and is killed."
			changed = 1
			break
	if changed == 0:
		for i in range(6,-1,-1): #injure first healthy character
			print (i, globalSingleton.character_status[i])
			if globalSingleton.character_status[i]==2: #find first unlocked character
				change_status(i,1) #injured character
				popoutText = "You attempt to clamber over the ROCKSLIDE. In the process, " + globalSingleton.character_name[i] + " falls and is injured."
				break
	setPopout(popoutText)

func choice1(): #go long way around
	if globalSingleton.run_beast==1:
		for i in range(6,-1,-1): #kill first health character from bottom up
			if globalSingleton.character_status[i]>0: #find first unlocked character
				change_status(i,0) #injured character
				popoutText = "You attempt to navigate around the ROCKSLIDE. However, it is slow going, and the TERRIBLE BEAST catches up with you and kills " + globalSingleton.character_name[i] + "."
				break
	else:
		popoutText = "You attempt to navigate around the ROCKSLIDE. It takes a little longer, but otherwise you’re fine."
	setPopout(popoutText)


func choice2(): #move the rocks
	popoutText = "In a great feat of strength, the Player shoves the rocks aside. However, they overexert themselves, earning an injury."
	if globalSingleton.character_status[3]==2: #miner is healthy
		popoutText = "Using their expertise in stonecunning, the stout MINER chips away just enough of the rocks to clear a path. You make it through without incident."
	elif globalSingleton.run_beast==1:
		for i in range(6,-1,-1): #kill first health character from bottom up
			if globalSingleton.character_status[i]>0: #find first unlocked character
				change_status(i,0) #kill character
				popoutText = "In a great feat of strength, the " + globalSingleton.character_name[i] + " shoves the rocks aside. However, the TERRIBLE BEAST catches up with you and rends them asunder!"
				break
	else:
		for i in range(6,-1,-1): #injure first health character from bottom up
			if globalSingleton.character_status[i]==2: #find first unlocked character
				change_status(i,0) #kill character
				popoutText = "In a great feat of strength, the " + globalSingleton.character_name[i] + " shoves the rocks aside. However, they overexert themselves, earning an injury."
				break
	setPopout(popoutText)
		

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
				2:
					if chosen == 0:
						choice2()
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


