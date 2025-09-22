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

## Verifica se possui o mesmo id de [param item]
func equal(item : Item) -> bool:
	if not item is Item:
		return false
	return item.id == id

## Retorna uma copia do item com unidade igual a [param unit]
func give_units(unit) -> Item:
	var new = _birth()
	new.units = unit
	return new

##Cria uma cópia de sí mesmo com 1 unidade
func _birth():
	return Item.new(id, item_name, item_block, sprite)
