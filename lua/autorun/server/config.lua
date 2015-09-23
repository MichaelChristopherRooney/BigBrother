-- this file contains configuration values that the server owner can change


-- should the addon verify the values in this config file
-- if you know the values are well-formed set this to False to skip verifying them
verify_config = True

-- should the addon log its initialisation to console
-- useful for debugging but it logs a lot of data
-- set it to False if you do not want debug information spamming your console
log_config_info = True

-- should the addon use ranks (admin, superadmin etc) and/or Steam IDs to authorise users
use_ranks_for_authorisation = True
use_steam_ids_for_authorisation = True

-- what ranks and/or Steam IDs should be authorised to use the addon
authorised_ranks = {"admin", "superadmin"}
authorised_steam_ids = {}

record_locations_frequency = 5 -- how often location updates should be recorded in seconds
event_lifespan = 1800 -- how long events should be stored for in seconds (600 = 10 min, 1800 = 30 min, etc)
delete_events_frequency = 5 -- how often the addon should check for old events to delete in seconds


-- BE VERY CAREFUL CHANGING THE BELOW TABLES
-- EDITING THE KEY VALUES _WILL_ BREAK THE ADDON
-- IN events_to_record ONLY SET KEYS EQUAL TO True or False


-- what events should be recorded
-- change True to False if you do not want that event to be recorded
events_to_record = {
	["location_update"] = True,	-- where the player was at a given time
	["spawned_prop"] = True,	-- the player spawned a prop
	["spawned_sent"] = True,	-- the player spawned a scripted entity
	["spawned_swep"] = True,	-- the player spawned a scripted weapon
	["was_killed"] = True,		-- the player was killed_player
	["suicide"] = True,		-- the player committed suicide
	["killed_player"] = True,	-- the player killed another player
	["disconnected"] = True,	-- the player disconnected from the game
	["say"] = True,			-- the player said something in chat
	["changed_team_or_job"] = True,	-- the player changed their team or job
	["spawned"] = True		-- the player spawned
}

-- used to store easier to read event names
-- uses the same keys as "events_to_record" does
-- this allows for easy access throughout the code
events_pretty_printing = {
	["location_update"] = "Location update",
	["spawned_prop"] = "Spawned prop",
	["spawned_sent"] = "Spawned SENT",
	["spawned_swep"] = "Spawned SWEP",
	["was_killed"] = "Was killed",
	["suicide"] = "Suicide",
	["killed_player"] = "Killed player",
	["disconnected"] = "Disconnected",
	["say"] = "Chat say",
	["changed_team_or_job"] = "Changed team or job",
	["spawned"] = "Spawned"
}