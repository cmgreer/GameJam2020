extends ColorRect



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func acceptInput():
	get_parent().get_parent().visible = false
	var acceptRef = funcref(self, 'foo')

func foo():
	pass

var acceptRef = funcref(self, 'acceptInput')


func acceptPassthrough():
	acceptRef.call_func()

func onShow():
	globalSingleton.interactingAccept = funcref(self, 'acceptPassthrough')

