-- this file contains configuration values that the server owner can change


-- should the addon use ranks (admin, superadmin etc) and/or Steam IDs to authorise users
bb_use_ranks_for_authorisation = True
bb_use_steam_ids_for_authorisation = False

-- what ranks and/or Steam IDs should be authorised to use the addon
bb_authorised_ranks = {"admin", "superadmin"}
bb_authorised_steam_ids = {}

bb_record_locations_frequency = 5 -- how often location updates should be recorded in seconds
bb_event_lifespan = 1800 -- how long events should be stored for in seconds (600 = 10 min, 1800 = 30 min, etc)
bb_delete_events_frequency = 5 -- how often the addon should check for old events to delete in seconds

-- what the user has to type to open the addon's GUI
bb_open_command = "!events"


-- BE VERY CAREFUL CHANGING THE BELOW TABLES
-- EDITING THE KEY VALUES _WILL_ BREAK THE ADDON
-- IN events_to_record ONLY SET KEYS EQUAL TO True or False


-- what events should be recorded
-- change True to False if you do not want that event to be recorded
bb_events_to_record = {
	["location_update"] = True,	-- where the player was at a given time
	["spawned_prop"] = True,	-- the player spawned a prop
	["spawned_sent"] = True,	-- the player spawned a scripted entity
	["spawned_swep"] = True,	-- the player spawned a scripted weapon
	["was_killed"] = True,		-- the player was killed_player
	["suicide"] = True,		-- the player committed suicide
	["killed_player"] = True,	-- the player killed another player
	["disconnected"] = True,	-- the player disconnected from the game
	["player_say"] = True,		-- the player said something in chat
	["changed_team_or_job"] = True,	-- the player changed their team or job
	["player_spawned"] = True	-- the player spawned
}