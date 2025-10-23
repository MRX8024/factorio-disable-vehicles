local DEBUG = false
local vehicles = {"car", "tank"}

local function deactivate()
    local total_cars = 0
    local total_tanks = 0
    local disabled_cars = 0
    local disabled_tanks = 0
    for _, surface in pairs(game.surfaces) do
        for _, v in pairs(surface.find_entities_filtered{
            type = "car", vehicles
        }) do
            if v.name == "car" then
                total_cars = total_cars + 1
            end
            if v.name == "tank" then
                total_tanks = total_tanks + 1
            end
            if v.valid and v.active then
                v.active = false
                if v.name == "tank" then
                    disabled_tanks = disabled_tanks + 1
                end
                if v.name == "car" then
                    disabled_cars = disabled_cars + 1
                end
            end
        end
    end
    if DEBUG then
        game.print(string.format("total/disabled cars: %d/%d", total_cars, disabled_cars))
        game.print(string.format("total/disabled tanks: %d/%d", total_tanks, disabled_tanks))
    end
end

script.on_init(deactivate)
script.on_configuration_changed(deactivate)
script.on_event(defines.events.on_player_joined_game, deactivate)
script.on_event(defines.events.on_game_created_from_scenario, deactivate)

commands.add_command("disable_vehicles", "make vehicles disabled", function()
    deactivate()
end)
