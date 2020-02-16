extends KinematicBody2D

export var speed = 200

var velocity = Vector2()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pop = get_child(2)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_sync_to_physics(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (globalSingleton.player_frozen >= 0):
		pass




func _on_PopupPanel_about_to_show():
	globalSingleton.player_frozen -=1


func _on_PopupPanel_popup_hide():
	globalSingleton.player_frozen +=1


func _on_Area2D_body_entered(body):
	if(body.get_name() == "Player"):
		pass
		#pop.popup_centered(Vector2(360,110))
		#pop.set_position(globalSingleton.playerPosition+Vector2(-178, 60))
