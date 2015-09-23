-- this file contains functions to initialise the addon

include("config.lua")
include("record_functions.lua")
include("event_functions.lua")

player_list = {}


-- initialise the addon
function initialiseBigBrother()

	if not verifyConfig() then return end
	
	createHooks()
	
	timer.Create("record_locations_timer", record_locations_frequency, 0, recordLocations) 
	timer.Create("delete_events_timer", delete_events_frequency, 0, deleteEvents)

end
hook.Add("Initialize", "InitialiseBB", initialiseBigBrother)


-- ensure all config values are well formed
function verifyConfig()
	
	if type(record_locations_frequency) ~= "number" then
		print("*** BigBrother error: record_locations_frequency must be a number ***")
		return false
	end
	
	if type(event_lifespan) ~= "number" then
		print("*** BigBrother error: event_lifespan must be a number ***")
		return false
	end
	
	print("BigBrother log: Initialization ok")
	print("BigBrother log: Authorised users are: ")
	
	for k, v in pairs(authorised_ranks) do
		print(k, v)
	end
	
	for k, v in pairs(authorised_steam_ids) do
		print(k, v)
	end
	
	return true

end

function createHooks()
	
	hook.Add("PlayerSay", "displayEvents", displayEvents)
	
	if events_to_record["spawned_prop"] == True then
		hook.Add("PlayerSpawnedProp", "PlayerSpawnedPropBB", playerSpawnedPropBB)
	end
	
	if events_to_record["spawned_sent"] == True then
		hook.Add("PlayerSpawnedSENT", "playerSpawnedSentBB", playerSpawnedSentBB)
	end
	
	if events_to_record["spawned_swep"] == True then
		hook.Add("PlayerSpawnedSWEP", "playerSpawnedSwepBB", playerSpawnedSwepBB)
	end
	
	if events_to_record["was_killed"] == True then
		hook.Add("PlayerDeath", "playerWasKilledBB", playerWasKilledBB)
	end
	
	if events_to_record["suicide"] == True then
		hook.Add("PlayerDeath", "playerSuicideBB", playerSuicideBB)
	end
	
	if events_to_record["killed_player"] == True then
		hook.Add("PlayerDeath", "playerKilledPlayerBB", playerKilledPlayerBB)
	end
	
	if events_to_record["disconnected"] == True then
		hook.Add("PlayerDisconnected", "playerDisconnectedBB", playerDisconnectedBB)
	end
	
	if events_to_record["say"] == True then
		hook.Add("PlayerSay", "sayBB", sayBB)
	end
	
	if events_to_record["changed_team_or_job"] == True then
		hook.Add("OnPlayerChangedTeam", "playerChangedTeamOrJobBB", playerChangedTeamOrJobBB)
	end
	
	if events_to_record["spawned"] == True then
		hook.Add("PlayerSpawn", "spawnedBB", spawnedBB)
	end
	
end



