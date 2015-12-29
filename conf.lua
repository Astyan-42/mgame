


-- Configuration
function love.conf(t)
	t.title = "MiniGames" -- The title of the window the game is in (string)
	t.version = "0.10.0"         -- The LÖVE version this game was made for (string)
	--t.screen.width = 400        -- we want our game to be long and thin.
	--t.screen.height = 700
    t.window.width = 800        -- we want our game to be long and thin.
	t.window.height = 600
    t.window.resizable = true

	-- For Windows debugging
	t.console = true
end
