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
	
		steam_id = plys[i]:SteamID()
		
		if not player_list[steam_id] then
			player_list[steam_id] = {}
		end
		
		if not player_list[steam_id]["location_update"] then
			player_list[steam_id]["location_update"]  = {}
		end
		
		local temp_table = {}
		temp_table.name = plys[i]:Name()
		temp_table.nick = plys[i]:Nick()
		temp_table.timestamp = os.time()
		temp_table.position = plys[i]:GetPos()
		
		table.insert(player_list[steam_id]["location_update"], temp_table)
		
		for k, v in pairs(player_list[steam_id]["location_update"][1]) do
			print(k, v)
		end
		
    end

end


-- record a spawned_prop event
function playerSpawnedPropBB(ply, model, entity)

	--[[	
	local temp_table = {}
	temp_table.steam_id = ply:SteamID()
	temp_table.name = ply:Name()
	temp_table.nick = ply:Nick()
	temp_table.event_type = "spawned_prop"
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.model = model
		
	table.insert(player_list, temp_table)
	]]
	print("LOG: spawned_prop")
	
end


function playerSpawnedSentBB(ply, ent)
	print("LOG: Player spawned SENT")
end


function playerSpawnedSwepBB(ply, weapon, info)
	print("LOG: Player spawned SWEP")
end


function playerWasKilledBB(victim, inflictor, attacker)
	if(victim ~= attacker) then
		print("LOG: Player was killed")
	end
end


function playerSuicideBB(victim, inflictor, attacker)
	if(victim == attacker) then
		print("LOG: Player suicided")
	end
end


function playerKilledPlayerBB(victim, inflictor, attacker)
	if(victim ~= attacker) then
		print("LOG: Player killed another player")
	end
end


function playerConnectedBB(name, ip)
	print("LOG: Player connected")
end


function playerDisconnectedBB(ply)
	print("LOG: Player disconnected")
end


function sayBB(sender, text, teamChat)
	print("LOG: Player said something")
end


function playerChangedTeamOrJobBB(ply, team)
	print("LOG: Player changed team or job")
end


function spawnedBB(ply)
	print("LOG: Player spawned")
end