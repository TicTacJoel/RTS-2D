extends CanvasLayer

@onready var wood_label: Label = $WoodLabel

func _process(_delta: float) -> void:
	wood_label.text = "Wood: " + str(Global.Wood)
