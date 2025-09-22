extends Resource

class_name Item

@export var id : int
@export var item_name : String
@export var item_block : String
@export var units : int
@export var max_stack : int
@export var sprite : String

func _init(Id : int, Item_Name : String, Item_Block : String, Sprite : String) -> void:
	id = Id
	item_name =Item_Name
	item_block = Item_Block
	sprite = Sprite
	units = 1
	max_stack = 5
	
func _birth():
	#Cria uma cópia de sí mesmo
	return Item.new(id, item_name, item_block, sprite)
