extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var messagePanel = get_child(2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Boat_body_entered(body):
	var count = 0
	for character in globalSingleton.character_status:
		if(character != 0):
			count += 1
	
	$MessageBox/ChoicesBorder/ChoicesBox/Description.text = str("You have ", count-1, " other people in your PACK. Do you wish to embark on your journey?")
	messagePanel.popup_centered(Vector2(360,90))
	messagePanel.set_position(globalSingleton.playerPosition+Vector2(-178, 80))


func _on_MessageBox_popup_hide():
	print("test")
	globalSingleton.player_frozen +=1


func _on_MessageBox_about_to_show():
	print("test2")
	globalSingleton.player_frozen -=1
