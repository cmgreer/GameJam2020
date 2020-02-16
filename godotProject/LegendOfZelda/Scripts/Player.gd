extends KinematicBody2D

export var speed = 400

var velocity = Vector2()
var escapeMenu = false
var Items_collected = [0,0,0,0,0]
var sprites=[]


func _draw():
	sprites.append($Sprite/ItemContainer)
	for x in range(1,len(Items_collected)):
		sprites.append($Sprite/ItemContainer.duplicate(15))
		$Sprite.add_child(sprites[-1])
		sprites[-1].position+=Vector2(10,0)*x

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
