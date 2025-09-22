extends Resource

var f_quest = Quest.new('Test Quest', 'This is a test quest, you have to pick up a box for me, that´s it, just do it bro',[QuestRequirements.new(Global.bank.items['placeholder'], 2,0,'Get placeholder')],QuestReward.new(0,0,[Global.bank.items['shawarma']._birth(), Global.bank.items['sprite'].give_units(2)]))



@export var quests = {
	'first' : f_quest
		}


# FALAS -----------------------------------------------------------------------

@export var falas = {
	"test" : ['hola', 'belo pinto bro'],
	'greet' : ['Hello!{p=0.4} my name is [rainbow]John Godot[/rainbow] {p=0.4},nice to meet you!',
		'This island is very small and very[shake] lonely[/shake]{p=0.2}.{p=0.2}.{p=0.2}. I`m glad i have a [wave]friend[/wave] now!',
		'So{p=0.5} I need you to do this quest for me,{p=0.5} I will give you [rainbow]two shawarmas and a Sprite![/rainbow]',
		Callable(QuestManager, 'quest_pop_up').bind(quests['first']), 'thank u'],
	'first_accept' : ['Thank you']
	}

# QUESTS ----------------------------------------------------------------------
