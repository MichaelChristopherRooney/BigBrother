-- this file contains functions to initialise the addon

AddCSLuaFile("autorun/client/cl_init.lua")

include("config.lua")
include("record_functions.lua")
include("event_functions.lua")

bb_player_list = {}
bb_player_nick_and_name_list = {}


-- initialise the addon
function initialiseBigBrother()

	if not bb_verifyConfig() then return end -- if config values are not well-formed
	
	bb_printConfigInfo()
	
	bb_createHooks()
	
	util.AddNetworkString("bb_client_request_player_list")
	util.AddNetworkString("bb_client_request_data")
	
	if bb_events_to_record["location_update"] == True then
		timer.Create("bb_record_locations_timer", bb_record_locations_frequency, 0, bb_recordLocations)
	end
	
	--timer.Create("bb_delete_events_timer", bb_delete_events_frequency, 0, bb_deleteEvents)

end
hook.Add("Initialize", "Initialise", initialiseBigBrother)


-- ensure all config values are well formed
function bb_verifyConfig()
	
	if bb_verify_config == False then
		-- addon has been told not to verify the config file
		-- need to return true or the addon will not start
		return true
	end
	
	if type(bb_record_locations_frequency) ~= "number" then
		print("BigBrother error: record_locations_frequency must be a number")
		return false
	end
	
	if type(bb_event_lifespan) ~= "number" then
		print("BigBrother error: event_lifespan must be a number")
		return false
	end
	
	return true

end


function bb_printConfigInfo()
	
	print("BigBrother log: Initialization ok")

	if bb_use_ranks_for_authorisation == True then
		print("BigBrother log: Authorised ranks are: ")
		for k, v in pairs(bb_authorised_ranks) do
			print("Bigbrother log: " .. k, v)
		end
	end
	
	if bb_use_steam_ids_for_authorisation == True then
		print("BigBrother log: Authorised Steam IDs are: ")
		for k, v in pairs(bb_authorised_steam_ids) do
			print("Bigbrother log: " .. k, v)
		end
	end
	
	print("Bigbrother: The following events will be recorded")
	
	for k, v in pairs(bb_events_to_record) do
		print("Bigbrother log: " .. k)
	end
	
end


function bb_createHooks()
	
	hook.Add("PlayerSay", "bb_displayEvents", bb_displayEvents)
	
	if bb_events_to_record["spawned_prop"] == True then
		hook.Add("PlayerSpawnedProp", "bb_playerSpawnedProp", bb_playerSpawnedProp)
	end
	
	if bb_events_to_record["spawned_sent"] == True then
		hook.Add("PlayerSpawnedSENT", "bb_playerSpawnedSent", bb_playerSpawnedSent)
	end
	
	if bb_events_to_record["spawned_swep"] == True then
		hook.Add("PlayerSpawnedSWEP", "bb_playerSpawnedSwep", bb_playerSpawnedSwep)
	end
	
	if bb_events_to_record["was_killed"] == True then
		hook.Add("PlayerDeath", "bb_playerWasKilled", bb_playerWasKilled)
	end
	
	if bb_events_to_record["suicide"] == True then
		hook.Add("PlayerDeath", "bb_playerSuicide", bb_playerSuicide)
	end
	
	if bb_events_to_record["killed_player"] == True then
		hook.Add("PlayerDeath", "bb_playerKilledPlayer", bb_playerKilledPlayer)
	end
	
	if bb_events_to_record["disconnected"] == True then
		hook.Add("PlayerDisconnected", "bb_playerDisconnected", bb_playerDisconnected)
	end
	
	if bb_events_to_record["player_say"] == True then
		hook.Add("PlayerSay", "bb_playerSay", bb_playerSay)
	end
	
	if bb_events_to_record["changed_team_or_job"] == True then
		hook.Add("OnPlayerChangedTeam", "bb_playerChangedTeamOrJob", bb_playerChangedTeamOrJob)
	end
	
	if bb_events_to_record["player_spawned"] == True then
		hook.Add("PlayerSpawn", "bb_playerSpawned", bb_playerSpawned)
	end
	
end