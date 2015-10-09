-- this file contains functions that record various events


-- record the location of every bb_player
-- called at a given interval specified in "record_locations_frequency"
function bb_recordLocations()

	plys = player.GetAll()
	
	for i = 1, #plys, 1 do
	
		local temp_table = {}
		temp_table.timestamp = os.time()
		temp_table.position = plys[i]:GetPos()
		
		insertIntoEventList(plys[i], "location_update", temp_table)
		
		print("LOG: location_update")
		
	end

end


function bb_playerSpawnedProp(ply, model, entity)

	local temp_table = {}
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.model = model
	
	insertIntoEventList(ply, "spawned_prop", temp_table)
	
	print("LOG: spawned_prop")
	
end


function bb_playerSpawnedSent(ply, ent)

	local temp_table = {}
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.ent_name = ent:GetName()
	
	insertIntoEventList(ply, "spawned_sent", temp_table)
	
	print("LOG: Player spawned SENT")
	
end


function bb_playerSpawnedSwep(ply, weapon, info)
	print("LOG: Player spawned SWEP")
end


function bb_playerWasKilled(victim, inflictor, attacker)

	if(victim ~= attacker) then
	
		local temp_table = {}
		temp_table.timestamp = os.time()
		temp_table.position = victim:GetPos()
		temp_table.weapon = inflictor:GetName()
		temp_table.attacker_steam_id = attacker:SteamID()
		temp_table.attacker_name = attacker:Name()
		temp_table.attacker_nick = attacker:Nick()
		temp_table.attacker_position = attacker:GetPos()
	
		insertIntoEventList(victim, "was_killed", temp_table)
	
		print("LOG: Player was killed")
		
	end
	
end


function bb_playerSuicide(victim, inflictor, attacker)

	if(victim == attacker) then
	
		local temp_table = {}
		temp_table.timestamp = os.time()
		temp_table.position = ply:GetPos()
	
		insertIntoEventList(victim, "suicide", temp_table)
		
		print("LOG: Player suicided")
		
	end
	
end


function bb_playerKilledPlayer(victim, inflictor, attacker)

	if(victim ~= attacker) then
	
		local temp_table = {}
		temp_table.timestamp = os.time()
		temp_table.position = attacker:GetPos()
		temp_table.weapon = inflictor:GetName()
		temp_table.victim_steam_id = victim:SteamID()
		temp_table.victim_name = victim:Name()
		temp_table.victim_nick = victim:Nick()
		temp_table.victim_position = victim:GetPos()
	
		insertIntoEventList(attacker, "killed_bb_player", temp_table)
		
		print("LOG: Player killed another bb_player")
		
	end
	
end


function bb_playerDisconnected(ply)

	local temp_table = {}
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	
	insertIntoEventList(ply, "disconnected", temp_table)
	
	print("LOG: Player disconnected")
	
end


function bb_say(ply, text, teamChat)

	local temp_table = {}
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.text = text
	
	insertIntoEventList(ply, "say", temp_table)
	
	print("LOG: Player said something")
	
end


function bb_playerChangedTeamOrJob(ply, old_team, new_team)

	local temp_table = {}
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.old_team = team.GetName(old_team)
	temp_table.new_team = team.GetName(new_team)
	
	insertIntoEventList(ply, "changed_team_or_job", temp_table)
	
	print("LOG: Player changed team or job")
	
end


function bb_playerSpawned(ply)

	local temp_table = {}
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	
	insertIntoEventList(ply, "spawned", temp_table)
	
	print("LOG: Player spawned")
	
end