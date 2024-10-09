extends Control

var debt: int
var debtLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	debt = 0
	
	debtLabel = $debtLabel

	update_debt(0)

func update_debt(change: int) -> void:
	debt += change
	# Format debt with commas
	var debtString = str(debt)
	for i in range(debtString.length() - 3, 0, -3):
		debtString = debtString.insert(i, ",")
	
	$debtLabel.text = debtString + "$"
