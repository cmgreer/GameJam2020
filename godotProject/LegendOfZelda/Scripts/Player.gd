extends KinematicBody2D

export var speed = 400

var velocity = Vector2()
var escapeMenu = false
var sprites=[]
var quest
var quests=[]
var Items_collected=[]


func _draw():
	sprites=[]
	sprites.append($Sprite/ItemContainer)
	for x in range(1,globalSingleton.items_amount):
		sprites.append($Sprite/ItemContainer.duplicate(15))
		$Sprite.add_child(sprites[-1])
		sprites[-1].position+=Vector2(10,0)*x
	for x in range(len(Items_collected)):
		sprites.append(Items_collected[x].duplicate(15))
		$Sprite.add_child(sprites[-1])
		sprites[-1].position=$Sprite/ItemContainer.position + Vector2(10,0)*x
		var size=sprites[-1].get_viewport_rect().size
		size=Vector2(size.x*sprites[-1].scale.x,size.y*sprites[-1].scale.y)
		var scale=$Sprite/ItemContainer.get_rect().size[0]*$Sprite/ItemContainer.scale[0]/max(size[0],size[1])
		sprites[-1].scale=Vector2(scale,scale)

	for x in range(len(quests)):
		quest=$Sprite/Quests.duplicate(15)
		$Sprite.add_child(quest)
		quest.rect_position+=Vector2(0,6)*x+Vector2(0,10)
		quest.text=quests[x]
		quest.rect_scale=Vector2(.25,.25)
	
func walk(vel):
	$Standing.hide()
	$WalkingBackward.hide()
	$WalkingForward.hide()
	$WalkingLeft.hide()
	$WalkingRight.hide()
	if(vel.x>0):
		$WalkingRight.show()
	elif(vel.x<0):
		$WalkingLeft.show()
	elif(vel.y>0):
		$WalkingForward.show()
	elif(vel.y<0):
		$WalkingBackward.show()
	else:
		$Standing.show()

func get_input():
	# Detect up/down/left/right keystate and only move when pressed
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_just_pressed('ui_cancel'):
		$Sprite.visible=!$Sprite.visible
		if($Sprite.visible):
			globalSingleton.player_frozen -=1
		else:
			globalSingleton.player_frozen +=1
	if Input.is_action_just_pressed('ui_accept'):
		if(globalSingleton.interactingAccept != null):
			globalSingleton.interactingAccept.call_func()
		pass
	if Input.is_action_just_pressed('ui_right'):
		if(globalSingleton.interactingRight != null):
			globalSingleton.interactingRight.call_func()
	if Input.is_action_just_pressed('ui_left'):
		if(globalSingleton.interactingLeft != null):
			globalSingleton.interactingLeft.call_func()
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if(globalSingleton.player_frozen >= 0):
		get_input()
# warning-ignore:return_value_discarded
		move_and_collide(velocity * delta)
		walk(velocity)
		globalSingleton.playerPosition = get_position()
	else:
		get_input()
		walk(Vector2.ZERO)
	if (quests!=globalSingleton.currrent_quests):
		quests=globalSingleton.currrent_quests
		_draw()
	if (Items_collected!=globalSingleton.Items_collected):
		Items_collected=[]
		for x in globalSingleton.Items_collected:
			Items_collected.append(x)
		_draw()
