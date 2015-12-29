

local Players = {}


function Players:new (players)
    players = players or 2
    sights = Players:construct_sights(players)
    fluids = Players:construct_fluid_table(players)
    scores = Players:construct_score(players, 10)
    states = Players:construct_state(players)
    obj = 
    {
		players = players,
        sights = sights,
        fluids = fluids,
        scores = scores,
        states = states
	}
	setmetatable(obj, self)
	self.__index = self
	return obj
end

function Players:construct_sights(players)
    local sights = {}
    for i = 1, players do
        local position = {x = 0.5, y = 0.5}
        sights[i] = position
    end
    return sights
end

function Players:construct_fluid_table(players)
    local fluids = {}
    for i = 1, players do
        fluids[i] = {}
    end
    return fluids
end

function Players:construct_score(players, score)
    local scores = {}
    for i = 1, players do
        scores[i] = score
    end
    return scores
end

function Players:construct_state(players)
    local states = {}
    for i = 1, players do
        states[i] = true
    end
    return states
end

function Players:create_fluid(from, to, x, y)
    --score to decrease when created
    local fluid = {belong = from, x = x, y = y, t = 0}
    table.insert(self.fluids[to], fluid)
end

function Players:delete_fluid(playerboard, x, y)
    table.sort(self.fluids[playerboard], function(a, b)
        if a.t < b.t then
            return true
        elseif b.t < a.t then
            return false
        else
            return a.overallRank < b.overallRank
        end
    end)
    
    rm = nil
    for i, fluid in ipairs(self.fluids[playerboard]) do
        local dist = math.sqrt((fluid.x-x)*(fluid.x-x)+(fluid.y-y)*(fluid.y-y))
        -- the multiplicator is not sure
        if dist - fluid.t * 42 < 0 then 
            rm = i
            break
        end
    end

    table.remove(self.fluids[playerboard], rm)

end

function Players:update(dt)
    self:update_fluids(dt)
    self:update_scores(dt)
    self:update_states()
end

function Players:update_fluids(dt)
    for i = 1, self.players do
        for j, fluid in ipairs(self.fluids[i]) do
            fluid.t = fluid.t+dt
        end
    end
end

function Players:update_scores(dt)
    for i = 1, dt do
        for j = 1, #self.fluids do
            local to = j
            for k, fluid in ipairs(self.fluids[to]) do
                from = fluid["belong"]
                if self.scores[to] > 0 then
                    self.scores[to] = self.scores[to] - 1
                    self.scores[from] = self.scores[from] + 2
                end
            end
        end
    end
end


function Players:create_fluids_from()
    local fluids_from = {}
    for i = 1, self.players do
        fluids_from[i] = 0
    end
    for i = 1, self.players do
        for j = 1, #self.fluids[i] do
            fluids_from[self.fluids[i][j]["belong"]] = fluids_from[self.fluids[i][j]["belong"]] + 1
        end
    end
    return fluids_from
end

function Players:update_states()
    local fluids_from = self:create_fluids_from()
    for i = 1, self.players do
        if self.scores[i] == 0 and fluids_from[i] == 0 then
            self.states[i] = false
        end
    end

end

--[[
test2 = Players:new(2)
test3 = Players:new(3)
test4 = Players:new(4)
test3:create_fluid(2, 1, 0.3, 0.2)
print(test3.fluids[1][1]["t"])
test3:update(7)
print(test3.fluids[1][1]["t"])
print(test3.scores[1])
print(test3.states[1])
test3:delete_fluid(1, 0.3, 0.2)
]]--

return Players
