extends Resource

var placeholder = Item.new(0, 'Placeholder', "res://UI/Item1x1.tscn","res://icon.svg" )
var other = Item.new(1, 'Other',"res://UI/Item1x1.tscn","res://Assets/Personagem/Modelo Personagem padrao v.J.png" )
var shawarma = Item.new(2, 'Shawarma', "res://UI/Item1x1.tscn","res://icon.svg" )
var sprite = Item.new(3, 'Sprite', "res://UI/Item1x1.tscn","res://icon.svg" )
@export var items = {
	'placeholder' : placeholder,
	'other' : other,
	'shawarma' : shawarma,
	'sprite' : sprite
	
}
