extends Node

var player_position: Vector2 = Vector2.ZERO
var coins: int = 0
var gems: int = 0

var collectedCoinIDs: Array = []

const SAVE_PATH = "user://savegame.json"

func CollectCoinWithID(coin_id: String, value: int):
	if not coin_id in collectedCoinIDs:
		collectedCoinIDs.append(coin_id)
		coins += value
		EventController.emit_signal("coinsCollected", coins)
		print("collected coin: ", coin_id)

func ResetGameStats():
	player_position = Vector2.ZERO
	coins = 0
	gems = 0
	collectedCoinIDs.clear()
	EventController.emit_signal("coinsCollected", coins)
	EventController.emit_signal("gemsCollected", gems)
	print("reset game")

func SaveGame():
	var player_nodes = get_tree().get_nodes_in_group("players")
	if not player_nodes.is_empty():
		var player = player_nodes[0]
		player_position = player.global_position
	
	var save_data = {
		"player_position_x": player_position.x,
		"player_position_y": player_position.y,
		"coins": coins,
		"gems": gems
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(save_data)
		file.store_string(json_string)

func LoadGame():
	if not FileAccess.file_exists(SAVE_PATH):
		ResetGameStats()
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var data = JSON.parse_string(content)

		if data:
			player_position.x = data.get("player_position_x", 0)
			player_position.y = data.get("player_position_y", 0)
			coins = data.get("coins", 0)
			gems = data.get("gems", 0)
			EventController.emit_signal("coinsCollected", coins)
			EventController.emit_signal("gemsCollected", gems)
		else:
			ResetGameStats()
