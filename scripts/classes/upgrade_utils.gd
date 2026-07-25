# General data structures shared related to upgrades
class_name UpgradeUtils
extends Node

class Upgrade:
	var upgrade_id: String
	var button_text: String
	var type: UpgradeType
	var cost: int
	var render_cost: int # cost for upgrade to show up
	var upgradeCalculator: UpgradeFormula

enum UpgradeType {SINGLE_USE, GENERATOR_UPGRADE_LINEAR, GENERATOR_UPGRADE_LOGARITHMIC}

# This is a not idea situation, since it'd be better to use
# composition instead of inheritance. However, I just can't
# figure out for the life of me a better way to handle this
# without creating 
@abstract
class UpgradeFormula:
	
	@abstract
	func calculateNextCost(prev_cost: int) -> int
		
class LinearUpgradeFormula extends UpgradeFormula:
	var increment: int
	
	func calculateNextCost(prev_cost: int) -> int:
		return prev_cost + increment
		
