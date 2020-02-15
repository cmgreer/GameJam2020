extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pop = get_child(2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_7UP_body_entered(body):
	if(body.get_name() == "Player"):
		pop.popup_centered(Vector2(239,64))
		pop.set_position(globalSingleton.playerPosition+Vector2(-119, 20))
	



func _on_PopupPanel_about_to_show():
	globalSingleton.player_frozen = true


func _on_PopupPanel_popup_hide():
	globalSingleton.player_frozen = false
