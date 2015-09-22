-- this file contains configuration values that the server owner can change


use_ranks_for_authorisation = True
use_steam_ids_for_authorisation = True

authorised_ranks = {"admin", "superadmin"}
authorised_steam_ids = {}

record_locations_frequency = 5 -- how often location updates should be recorded in seconds
event_lifespawn = 1800 -- how long events should be stored for in seconds (600 = 10 min, 1800 = 30 min, etc)
delete_events_frequency = 5 -- how often the addon should check for old events to delete in seconds

-- what events should be recorded
-- change True to False if you do not want that event to be recorded
events_to_record = {
	["spawned_prop"] = True,			-- the player spawned a prop
	["spawned_sent"] = True,			-- the player spawned a scripted entity
	["spawned_swep"] = True,			-- the player spawned a scripted weapon
	["was_killed"] = True,				-- the player was killed_player
	["suicide"] = True,					-- the player committed suicide
	["killed_player"] = True,			-- the player killed another player
	["connected"] = True,				-- the player connected to the game
	["disconnected"] = True,			-- the player disconnected from the game
	["say"] = True,						-- the player said something in chat
	["changed_team_or_job"] = True,		-- the player changed their team or job
	["spawned"] = True					-- the player spawned
}
