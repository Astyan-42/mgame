debug = true

local Menu = require 'menu'
local FluidWar = require 'fluidwar'

state = nil


function love.load(arg)
    state = "game"
    -- create the menu
    testmenu = Menu:new()
    testmenu:addItem
    {
        name = 'Start Game',
        action = function()
            state = "game"
        end
    }
    testmenu:addItem
    {
        name = 'Quit',
        action = function()
            love.event.push('quit')
        end
    }
    --create the game board
    fluidwar = FluidWar:new(2)
end

function love.update(dt)
    if state == "menu" then
        testmenu:update(dt)
    --elseif state == "game" then
    --
    end
    
end

function love.draw(dt)
    if state == "menu" then
        testmenu:draw(10, 10)
    elseif state == "game" then
        fluidwar:draw()
    end
    
end

function love.keypressed(key)
    if state == "menu" then
        testmenu:keypressed(key)
    --elseif state == "game" then
      --  testmenu:draw(10, 20)
    end
end
