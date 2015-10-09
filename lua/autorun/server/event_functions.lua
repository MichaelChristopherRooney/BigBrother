-- this file contains functions that:
--	manages storage of new events
--	manages deletion of old events
--	pulls data in response to client queries


-- this function places the event into the relevant table
-- if the table does not exist it is created
function bb_insertIntoEventList(ply, event_type, event)

	local steam_id = ply:SteamID()
	
	if not bb_player_list[steam_id] then
		bb_player_list[steam_id] = {}
	end
		
	if not bb_player_list[steam_id][event_type] then
		bb_player_list[steam_id][event_type]  = {}
	end
	
	local name_index
	local nick_index
	
	-- record the name/nick in a table that is accessed via an index
	-- each event will reference an entry in the name/nick table
	if not bb_player_nick_and_name_list[steam_id] then
	
		nick_index = 1
		name_index = 1
		
		bb_player_nick_name_list[steam_id] = {
			["name"] = {},
			["nick"] = {}
		}
		
		table.insert(bb_player_nick_and_name_list[steam_id]["name"], ply:Name())
		table.insert(bb_player_nick_and_name_list[steam_id]["nick"], ply:Nick())
		
		
	else
		
		name_index = #bb_player_nick_and_name_list[steam_id]["name"]
		nick_index = #bb_player_nick_and_name_list[steam_id]["nick"]
		
		if bb_player_nick_and_name_list[steam_id]["name"][name_index] != ply:Name() then
			table.insert(bb_player_nick_and_name_list[steam_id]["name"], ply:Name())
		end
		
		if bb_player_nick_and_name_list[steam_id]["nick"][nick_index] != ply:Nick() then
			table.insert(bb_player_nick_and_name_list[steam_id]["nick"], ply:Nick())
		end
		
	end
	
	event.name = name_index
	event.nick = nick_index
	
	table.insert(bb_player_list[steam_id][event_type], event)
	
	print("Recording event")
	
end


-- this function checks if any events are old enough to be deleted
function bb_deleteEvents()
	print("hi")
end


-- need to rework this into a command to open a gui clientside
function bb_displayEvents(ply, text, teamChat)

	if (text == bb_open_command) then
		if bb_authenticateUser(ply) == True then
			bb_playerListRequest(ply)
		end
	end
	
end


function bb_playerListRequest(ply)
	
	local t = {}
	
	for k, v in pairs(bb_player_list) do
		table.insert(t, k)
	end
	
	net.Start("bb_client_request_player_list")
		net.WriteTable(t)
	net.Send(ply)
	
end


function bb_authenticateUser(ply)
	
	steam_id = ply:SteamID()
	rank = ply:GetUserGroup()
	
	if bb_use_bb_use_steam_ids_for_authorisation == False and bb_use_ranks_for_authorisation == False then
		return true -- authentication is disabled
	end
	
	if bb_use_bb_use_steam_ids_for_authorisation == True then
		for k, v in pairs(bb_authorised_steam_ids) do
			if steam_id == v then
				return true
			end
		end
	end
	
	if bb_use_ranks_for_authorisation == True then
		for k, v in pairs(bb_authorised_ranks) do
			if rank == v then
				return true
			end
		end
	end
	
	return false
	
end


function bb_verifyRequest(steam_id, event_key)

	if player_list[steam_id] == nil then
		net.Start("bb_client_receive_data")
			net.WriteInt(1)
			net.WriteString("The requested player does not exist")
		net.Send()
		return false
	end
		
	if player_list[steam_id][event_key] == nil then
		net.Start("bb_client_receive_data")
			net.WriteInt(1)
			net.WriteString("The requested event type does not exist or is not enabled")
		net.Send()
		return false
	end
	
	return true
	
end


net.Receive("bb_client_request_data", function(len, ply)
		
	local steam_id = net.ReadString()
	local event_key = net.ReadString()
	
	if not bb_authenticateUser(ply) then return end
	if not bb_verifyRequest(steam_id, event_key) then return end
		
	local names = {}
	local nicks = {}
	local events = {}
		
	for k, v in pairs(player_list[steam_id][event_key]) do
		table.insert(events, v)
	end
	
end)


