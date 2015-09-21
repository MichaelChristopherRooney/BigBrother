--[[
	authorisation_type is how we chose who can view events
	"ulx" uses ulx ranks, "fadmin" uses fadmin ranks, and "specified" uses a list of specified SteamIDs
]]
authorisation_type = "ulx"
authorised_users = {"admin", "superadmin"}

--[[
	values relating to how often data is recorded and what data is recorded
]]
record_locations_frequency = 0.01 -- how often location updates should be recorded in seconds
event_lifespan = 1800 -- how long events should be stored for in seconds (600 = 10 min, 1800 = 30 min, etc)

events = {}


-- initialise the addon
function initialiseBigBrother()

	if not verifyConfig() then return end
	
	timer.Create("record_locations_timer", record_locations_frequency, 0, recordLocations) 

end
hook.Add("Initialize", "InitialiseBB", initialiseBigBrother)


-- ensure all config values are well formed
function verifyConfig()

	if (authorisation_type ~= "ulx") and (authorisation_type ~= "fadmin") and (authorisation_type ~= "specified") then
		print("*** BigBrother error: authorisation_type is not a recognised value ***")
		return false
	end
	
	if type(record_locations_frequency) ~= "number" then
		print("*** BigBrother error: record_locations_frequency must be a number ***")
		return false
	end
	
	if type(event_lifespan) ~= "number" then
		print("*** BigBrother error: event_lifespan must be a number ***")
		return false
	end
	
	print("BigBrother log: Initialization ok")
	print("BigBrother log: Authorisation type is " .. authorisation_type)
	print("BigBrother log: Authorised users are: ")
	
	for k, v in pairs(authorised_users) do
		print(k, v)
	end
	
	return true

end


-- record the location of every player
-- called at a given interval by a "record_locations_timer"
function recordLocations()

	plys = player.GetAll()
	
	for i = 1, #plys, 1 do
	
		local temp_table = {}
		temp_table.steam_id = plys[i]:SteamID()
		temp_table.name = plys[i]:Name()
		temp_table.nick = plys[i]:Nick()
		temp_table.event_type = "location_update"
		temp_table.timestamp = os.time()
		temp_table.position = plys[i]:GetPos()
		
		table.insert(events, temp_table)
		
    end

end


-- record a PlayerSpawnProp event_lifespan
function playerSpawnedPropBB(ply, model, entity)
	
	local temp_table = {}
	temp_table.steam_id = ply:SteamID()
	temp_table.name = ply:Name()
	temp_table.nick = ply:Nick()
	temp_table.event_type = "spawned_prop"
	temp_table.timestamp = os.time()
	temp_table.position = ply:GetPos()
	temp_table.model = model
		
	table.insert(events, temp_table)
	
end
hook.Add("PlayerSpawnedProp", "PlayerSpawnedPropBB", playerSpawnedPropBB)


-- need to rework this into a command to open a gui clientside
function displayEvents(pl, text, teamonly)

	if (text == "!events") then
	
		local count = 0
		for _ in pairs(events) do count = count + 1 end
		print(count)

	end
	
end
hook.Add("PlayerSay", "Chat", displayEvents)
