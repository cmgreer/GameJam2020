extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var popL1 = get_child(2)
onready var popL2 = get_child(3)
onready var popL3 = get_child(4)
onready var popReject = get_child(5)
onready var popJoin = get_child(6)

var dialogLevel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_7UP_body_entered(body):
	if(body.get_name() == "Player"):
		if(dialogLevel == 0):
			dialogLevel = 1
			popL1.popup_centered(Vector2(360,90))
			popL1.set_position(globalSingleton.playerPosition+Vector2(-178, 80))
	



func _on_PopupPanel_about_to_show():
	globalSingleton.player_frozen = true


func _on_PopupPanel_popup_hide():
	globalSingleton.player_frozen = false


func _on_ChoicesBox_dialogBoxCheck(boxNum):
	match dialogLevel:
		1:
			match boxNum:
				0:
					#good answer, launch L2
					dialogLevel = 2
					popL2.popup_centered(Vector2(360,90))
					popL2.set_position(globalSingleton.playerPosition+Vector2(-178, 80))
					globalSingleton.player_frozen = true
				1:
					#bad answer, launch backout
					backout()
		2:
			match boxNum:
				0:
					#bad answer
					backout()
				1:
					#good answer, launch l3
					dialogLevel = 3
					popL3.popup_centered(Vector2(360,90))
					popL3.set_position(globalSingleton.playerPosition+Vector2(-178, 80))
					globalSingleton.player_frozen = true
		3:
			match boxNum:
				0:
					#good answer, join team, print thank you message
					join_team()
				1:
					#bad answer
					backout()

func backout():
	dialogLevel = 10
	popReject.popup_centered(Vector2(360,90))
	popReject.set_position(globalSingleton.playerPosition+Vector2(-178, 80))
	globalSingleton.character_status[3] = 0
	globalSingleton.player_frozen = true

func join_team():
	dialogLevel = 10
	popJoin.popup_centered(Vector2(360,90))
	popJoin.set_position(globalSingleton.playerPosition+Vector2(-178, 80))
	globalSingleton.character_status[3] = 2
	globalSingleton.player_frozen = true
