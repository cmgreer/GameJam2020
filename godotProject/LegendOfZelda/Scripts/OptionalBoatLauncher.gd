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
	
	match selected_option:
		0:
			$Pointer0.color = Color.yellow
		1:
			$Pointer1.color = Color.yellow

#func _input(event):
#	if event is InputEventKey:
#		var just_pressed = event.pressed and not event.echo
#
#		if event.scancode == KEY_RIGHT and just_pressed:
#			selected_option = (selected_option + 1) % 2;
#			change_selected_color()
#		elif event.scancode == KEY_LEFT and just_pressed:
#			if selected_option > 0:
#				selected_option = selected_option - 1
#			else:
#				selected_option = 1
#			change_selected_color()
#		elif event.scancode == KEY_SPACE and just_pressed:
#			get_parent().get_parent().visible = false
#			emit_signal("dialogBoxCheck",selected_option)


func status_character(): #unfinished
	for i in range(1,7):
		#emit_signal("status_character", i, global.)
		pass
	
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
func acceptInput():
	get_parent().get_parent().visible = false
	var acceptRef = funcref(self, 'foo')
	var leftRef = funcref(self, 'foo')
	var rightRef = funcref(self, 'foo')
	if(selected_option == 1):
		launch_boat()
func leftInput():
	if selected_option > 0:
		selected_option = selected_option - 1
	else:
		selected_option = 1
	change_selected_color()
func rightInput():
	selected_option = (selected_option + 1) % 2;
	change_selected_color()

func foo():
	pass

var acceptRef = funcref(self, 'acceptInput')
var leftRef = funcref(self, 'leftInput')
var rightRef = funcref(self, 'rightInput')

func acceptPassthrough():
	acceptRef.call_func()
func leftPassthrough():
	leftRef.call_func()
func rightPassthrough():
	rightRef.call_func()


func onShow():
	globalSingleton.interactingAccept = funcref(self, 'acceptPassthrough')
	globalSingleton.interactingLeft = funcref(self, 'leftPassthrough')
	globalSingleton.interactingRight = funcref(self, 'rightPassthrough')
	
func launch_boat():
	get_tree().change_scene("res://OregonTrail/Scenes/OregonTrailRoot.tscn")


