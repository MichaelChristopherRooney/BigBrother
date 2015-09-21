--[[
	authorisation_type is how we chose who can view events
	"ulx" uses ulx ranks, "fadmin" uses fadmin ranks, and "specified" uses a list of specified SteamIDs
]]
authorisation_type = "ulx"
authorised_users = {"admin", "superadmin"}

--[[
	values relating to how often data is recorded and what data is recorded
]]
record_locations_frequency = 5 -- how often location should be record in seconds
event_lifespan = 1800 -- how long events should be stored for in seconds (600 = 10 min, 1800 = 30 min, etc)

events = {}


-- initialise the addon
function InitialiseBigBrother()

	if not verifyConfig() then return end
	
	timer.Create("record_locations_timer", record_locations_frequency, 0, recordLocations) 

end
hook.Add("Initialize", "InitialiseBB", InitialiseBigBrother )


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
	
	for k, v in pairs( authorised_users ) do
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
		temp_table.player_steam_id = plys[i]:SteamID()
		temp_table.event_type = "location_update"
		temp_table.timestamp = os.time()
		temp_table.position = plys[i]:GetPos()
		
		table.insert(events, temp_table)
		
    end

end


-- need to rework this into a command to open a gui clientside
function display_events( pl, text, teamonly )

	if (text == "!locations") then
	
		for k, v in pairs(events[1]) do
			print(k, v)
		end

	end
	
end
hook.Add( "PlayerSay", "Chat", display_events )
