

local FluidWar = {}

local idsp = love.window.toPixels(100)

function FluidWar:new (players)
	players, screens = FluidWar:setscreens(players)
    backgrounds = FluidWar:setbackgroundcanvas(players, screens)
    obj = 
    {
		players = players or 2,
        screens = screens,
        backgrounds = backgrounds
	}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function FluidWar:setscreens(players)
    screens = nil
    if players == 2 or players == nil then
        players = 2
        screens = 2
    else
        screens = 4
    end
    return players, screens
end

function FluidWar:setbackgroundcanvas(players, screens)
    width, height, flags = love.window.getMode( )
    --independant scale pixel
    idsp = love.window.toPixels(100)
    
    local backgroundcanvas = {}
    
    local canvas = love.graphics.newCanvas(idsp, idsp)
    love.graphics.setCanvas(canvas)
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.rectangle("fill", 0, 0, idsp, idsp)
    table.insert(backgroundcanvas, canvas)
    
    local canvas = love.graphics.newCanvas(idsp, idsp)
    love.graphics.setCanvas(canvas)
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle("fill", 0, 0, idsp, idsp)
    table.insert(backgroundcanvas, canvas)
    
    local canvas = love.graphics.newCanvas(idsp, idsp)
    love.graphics.setCanvas(canvas)
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(0, 0, 255, 255)
    love.graphics.rectangle("fill", 0, 0, idsp, idsp)
    table.insert(backgroundcanvas, canvas)
    
    local canvas = love.graphics.newCanvas(idsp, idsp)
    love.graphics.setCanvas(canvas)
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(255, 255, 0, 255)
    love.graphics.rectangle("fill", 0, 0, idsp, idsp)
    table.insert(backgroundcanvas, canvas)
    
    --avoid the bug
    love.graphics.setCanvas()
    return backgroundcanvas
end


function FluidWar:drawboard()
    width, height, flags = love.window.getMode( )
    width = love.window.toPixels(width)
    height = love.window.toPixels(height)
    if self.players == 2 then
        love.graphics.draw(self.backgrounds[1], 0, 0, 0, (width/idsp)/2, height/idsp)
        love.graphics.draw(self.backgrounds[2], width/2, 0, 0, (width/idsp)/2, height/idsp)
    elseif self.players == 3 then
        love.graphics.draw(self.backgrounds[1], 0, 0, 0, (width/idsp)/2, (height/idsp)/2)
        love.graphics.draw(self.backgrounds[2], width/2, 0, 0, (width/idsp)/2, (height/idsp)/2)
        love.graphics.draw(self.backgrounds[3], 0, height/2, 0, (width/idsp)/2, (height/idsp)/2)
    elseif self.players == 4 then
        love.graphics.draw(self.backgrounds[1], 0, 0, 0, (width/idsp)/2, (height/idsp)/2)
        love.graphics.draw(self.backgrounds[2], width/2, 0, 0, (width/idsp)/2, (height/idsp)/2)
        love.graphics.draw(self.backgrounds[3], 0, height/2, 0, (width/idsp)/2, (height/idsp)/2)
        love.graphics.draw(self.backgrounds[4], width/2, height/2, 0, (width/idsp)/2, (height/idsp)/2)
    end
end

function FluidWar:drawfluid()
    local canvas = love.graphics.newCanvas(200, 200)
    love.graphics.setCanvas(canvas)
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", 210, 210, 50, 100)
    love.graphics.setCanvas()
    love.graphics.draw(canvas, 0, 0, 0, 1, 1)

end



function FluidWar:draw ()
    self:drawboard()
    self:drawfluid()
end


return FluidWar
