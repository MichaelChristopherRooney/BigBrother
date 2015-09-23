-- this file contains functions that:
--	deletes old events
--	pulls data in response to client queries


-- this function places the event into the relevant table
-- if the table does not exist it is created
function insertIntoEventList(steam_id, event_type, event)

	if not player_list[steam_id] then
		player_list[steam_id] = {}
		player_list[steam_id].steam_id = steam_id
	end
		
	if not player_list[steam_id][event_type] then
		player_list[steam_id][event_type]  = {}
	end
	
	table.insert(player_list[steam_id][event_type], event)
	
	print("Recording event")
	
	for k, v in pairs(event) do
		print(k, v)
	end
	
end


-- this function checks if any events are old enough to be deleted
function deleteEvents()

end