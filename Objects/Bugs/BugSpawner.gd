extends Node2D

var bug_library = {
	0: "res://Objects/Bugs/Worm.tscn",
	1: "res://Objects/Bugs/Mantis.tscn",
}

var is_instantiated : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("get_hit") and not is_instantiated:
		var number = randi_range(0,1)
		var bug = load(bug_library[number]).instantiate()
		print("aaa",self.position)
		self.add_child(bug)
		bug.setup(self.position)
		is_instantiated = true
	
