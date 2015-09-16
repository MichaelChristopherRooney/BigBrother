--[[
	authorisation_type is how we chose who can view events
	"ulx" uses ulx ranks, "fadmin" uses fadmin ranks, and "specified" uses a list of specified SteamIDs
]]
local authorisation_type = "ulx"
local authorised_users = {"admin", "superadmin"}

--[[
	values relating to how often data is recorded and what data is recorded
]]
local record_locations_frequency = 5 -- how often location should be record in seconds
local event_lifespan = 1800 -- how long events should be stored for in seconds (600 = 10 min, 1800 = 30 min, etc)

local events = {}


-- initialise the addon
function InitialiseBigBrother()

	if not verifyConfig() then return end
	
	timer.Create("record_locations_timer", 5, 0, recordLocations) 

end
hook.Add("Initialise", "InitialiseBB", InitialiseBigBrother )

-- ensure all config values are well formed
function verifyConfig()

	if not authorisation_type == "ulx" and not authorisation_type == "fadmin" and not authorisation_type == "specified" then
		print("*** BigBrother error: authorisation_type is not a recognised value ***")
		return false
	end
	
end


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
function donateCommand( pl, text, teamonly )
            if (text == "!locations") then
                for k, v in pairs(player.GetAll()) do v:ChatPrint( "Player " .. pl:Nick() .. " has donated to the server via !donate" )

        end
    end
end
hook.Add( "PlayerSay", "Chat", donateCommand )


--[[

	plys = player.GetAll()
	
	for i = 1, #plys, 1 do
		print(plys[i]:SteamID())
		print(plys[i]:GetPos()[0])
		print(plys[i]:GetPos())
    end
	
	for n = 1, #events, 1 do
		print(events[n].player_steam_id)
		print(events[n].event_type)
		print(events[n].timestamp)
		print(events[n].position)
	end
	
]]