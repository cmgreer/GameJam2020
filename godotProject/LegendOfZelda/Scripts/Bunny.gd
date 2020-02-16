extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pop = get_child(2)

var rand
var count=0
var origin
# Called when the node enters the scene tree for the first time.
func _ready():
	rand=randi()%100
	origin=self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	count+=1
	if count==rand:
		self.position=Vector2(self.origin.x+randi()%401-200,self.origin.y+randi()%401-200)
		count=0
		rand=randi()%100
	elif rand-count<30:
		$Particles2D.show()
	else:
		$Particles2D.hide()


func _on_Bunny_body_entered(body):
	if(body.get_name() == "Player"):
		self.position=Vector2(5000,5000)
		origin=self.position
		globalSingleton.Items_collected.append($AnimatedSprite)
