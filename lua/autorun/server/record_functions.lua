-- this file contains functions that record events


-- need to rework this into a command to open a gui clientside
function displayEvents(sender, text, teamChat)

	if (text == "!events") then
	
		local count = 0
		for _ in pairs(player_list) do count = count + 1 end
		print(count)

	end
	
end


-- record the location of every player
-- called at a given interval specified in "record_locations_frequency"
function recordLocations()

	plys = player.GetAll()
	
	for i = 1, #plys, 1 do
	
		local temp_table = {}
		temp_table.name = plys[i]:Name()
		temp_table.nick = plys[i]:Nick()
		temp_table.timestamp = os.time()
		temp_table.position = plys[i]:GetPos()
		
		insertIntoEventList(plys[i]:SteamID(), "location_update", temp_table)
		
		print("LOG: location_update")
		
	end

end


-- record a spawned_prop event
function playerSpawnedPropBB(ply, model, entity)

	local temp_table = {}
	temp_table.name = ply:Name()
	temp_table.nick = ply:Nick()
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.model = model
	
	insertIntoEventList(ply:SteamID(), "spawned_prop", temp_table)
	
	print("LOG: spawned_prop")
	
end


function playerSpawnedSentBB(ply, ent)

	local temp_table = {}
	temp_table.name = ply:Name()
	temp_table.nick = ply:Nick()
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.ent_name = ent:GetName()
	
	insertIntoEventList(ply:SteamID(), "spawned_sent", temp_table)
	
	print("LOG: Player spawned SENT")
	
end


function playerSpawnedSwepBB(ply, weapon, info)
	print("LOG: Player spawned SWEP")
end


function playerWasKilledBB(victim, inflictor, attacker)

	if(victim ~= attacker) then
	
		local temp_table = {}
		temp_table.name = victim:Name()
		temp_table.nick = victim:Nick()
		temp_table.timestamp = os.time()
		temp_table.position = victim:GetPos()
		temp_table.weapon = inflictor:GetName()
		temp_table.attacker_steam_id = attacker:SteamID()
		temp_table.attacker_name = attacker:Name()
		temp_table.attacker_nick = attacker:Nick()
		temp_table.attacker_position = attacker:GetPos()
	
		insertIntoEventList(victim:SteamID(), "was_killed", temp_table)
	
		print("LOG: Player was killed")
		
	end
	
end


function playerSuicideBB(victim, inflictor, attacker)

	if(victim == attacker) then
	
		local temp_table = {}
		temp_table.name = ply:Name()
		temp_table.nick = ply:Nick()
		temp_table.timestamp = os.time()
		temp_table.position = ply:GetPos()
	
		insertIntoEventList(victim:SteamID(), "suicide", temp_table)
		
		print("LOG: Player suicided")
		
	end
	
end


function playerKilledPlayerBB(victim, inflictor, attacker)

	if(victim ~= attacker) then
	
		local temp_table = {}
		temp_table.name = attacker:Name()
		temp_table.nick = attacker:Nick()
		temp_table.timestamp = os.time()
		temp_table.position = attacker:GetPos()
		temp_table.weapon = inflictor:GetName()
		temp_table.victim_steam_id = victim:SteamID()
		temp_table.victim_name = victim:Name()
		temp_table.victim_nick = victim:Nick()
		temp_table.victim_position = victim:GetPos()
	
		insertIntoEventList(attacker:SteamID(), "killed_player", temp_table)
		
		print("LOG: Player killed another player")
		
	end
	
end


function playerDisconnectedBB(ply)

	local temp_table = {}
	temp_table.name = ply:Name()
	temp_table.nick = ply:Nick()
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	
	insertIntoEventList(ply:SteamID(), "disconnected", temp_table)
	
	print("LOG: Player disconnected")
	
end


function sayBB(sender, text, teamChat)

	local temp_table = {}
	temp_table.name = ply:Name()
	temp_table.nick = ply:Nick()
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.text = text
	
	insertIntoEventList(ply:SteamID(), "say", temp_table)
	
	print("LOG: Player said something")
	
end


function playerChangedTeamOrJobBB(ply, old_team, new_team)

	local temp_table = {}
	temp_table.name = ply:Name()
	temp_table.nick = ply:Nick()
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.old_team = team.GetName(old_team)
	temp_table.new_team = team.GetName(new_team)
	
	insertIntoEventList(ply:SteamID(), "changed_team_or_job", temp_table)
	
	print("LOG: Player changed team or job")
	
end


function spawnedBB(ply)

	local temp_table = {}
	temp_table.name = ply:Name()
	temp_table.nick = ply:Nick()
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	
	insertIntoEventList(ply:SteamID(), "spawned", temp_table)
	
	print("LOG: Player spawned")
	
end