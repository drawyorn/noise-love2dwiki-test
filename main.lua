--noise code extracted from love2d wiki

local grid = {}
camera = {x = 0,y = 0}

function camera:Move(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - 140*dt
    end

    if love.keyboard.isDown("s") then
        self.y = self.y + 140*dt
    end

    if love.keyboard.isDown("a") then
        self.x = self.x - 140*dt
    end

    if love.keyboard.isDown("d") then
        self.x = self.x + 140*dt
    end
end

local function generateNoiseGrid()
	-- Fill each tile in our grid with noise.
	local baseX = 1000 * love.math.random()
	local baseY = 1000 * love.math.random()
	for y = 1, 24 do
		grid[y] = {}
		for x = 1, 24 do
			grid[y][x] = love.math.noise(baseX+.1*x, baseY+.2*y)
		end
	end
end

function love.load()
	generateNoiseGrid()
end
function love.keypressed(key)
	if key == "space" then
        generateNoiseGrid()
    end
end

function love.update(dt)
    camera:Move(dt)
end

function love.draw()
	local tileSize = 8
	for y = 1, #grid do
		for x = 1, #grid[y] do
			love.graphics.setColor(grid[y][x], grid[y][x], grid[y][x])
			love.graphics.rectangle("fill", x*tileSize-camera.x, y*tileSize-camera.y, tileSize, tileSize)
		end
	end
end