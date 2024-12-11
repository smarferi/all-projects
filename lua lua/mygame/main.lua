-- 2D RPG with Gun Mechanics in Love2D
-- By Severrir

local state = "menu" -- Game states: menu, shop, battle
local player, enemy, bullets, shopItems

-- Initialize player and enemy data
function resetGame()
    player = {
        x = 100, y = 200, health = 100, bullets = 10, score = 0, gold = 50
    }
    enemy = {
        x = 400, y = 200, health = 100, reloadTime = 2, lastShot = 0
    }
    bullets = {}
end

resetGame()

-- Shop Items
shopItems = {
    { name = "Health Pack", price = 20, apply = function(p) p.health = math.min(100, p.health + 20) end },
    { name = "Ammo Pack", price = 10, apply = function(p) p.bullets = p.bullets + 5 end }
}

-- Load assets
function love.load()
    font = love.graphics.newFont(20)
    love.graphics.setFont(font)
end

-- Update game logic
function love.update(dt)
    if state == "battle" then
        -- Handle player bullets
        for i, bullet in ipairs(bullets) do
            bullet.x = bullet.x + bullet.speed * dt
            if bullet.x > enemy.x and math.abs(bullet.y - enemy.y) < 10 then
                enemy.health = enemy.health - 10
                table.remove(bullets, i)
            end
        end

        -- Enemy AI
        enemy.lastShot = enemy.lastShot + dt
        if enemy.lastShot >= enemy.reloadTime then
            player.health = player.health - 10
            enemy.lastShot = 0
        end

        -- Check for end of battle
        if player.health <= 0 then state = "menu" resetGame() end
        if enemy.health <= 0 then
            player.score = player.score + 1
            player.gold = player.gold + 20
            resetGame()
            state = "menu"
        end
    end
end

-- Draw the game
function love.draw()
    if state == "menu" then
        drawMenu()
    elseif state == "shop" then
        drawShop()
    elseif state == "battle" then
        drawBattle()
    end
end

-- Handle key presses
function love.keypressed(key)
    if state == "menu" then
        if key == "s" then state = "shop"
        elseif key == "b" then state = "battle"
        elseif key == "q" then love.event.quit() end

    elseif state == "shop" then
        if key == "1" then buyItem(1)
        elseif key == "2" then buyItem(2)
        elseif key == "q" then state = "menu" end

    elseif state == "battle" then
        if key == "space" then
            if player.bullets > 0 then
                player.bullets = player.bullets - 1
                table.insert(bullets, { x = player.x, y = player.y, speed = 300 })
            end
        elseif key == "q" then
            state = "menu"
            resetGame()
        end
    end
end

-- Draw the main menu
function drawMenu()
    love.graphics.printf("2D RPG Game", 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("Press 'B' to Battle", 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Press 'S' to Shop", 0, 250, love.graphics.getWidth(), "center")
    love.graphics.printf("Press 'Q' to Quit", 0, 300, love.graphics.getWidth(), "center")
end

-- Draw the shop
function drawShop()
    love.graphics.printf("Shop - Gold: " .. player.gold, 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("1. Health Pack - 20 Gold", 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("2. Ammo Pack - 10 Gold", 0, 250, love.graphics.getWidth(), "center")
    love.graphics.printf("Press 'Q' to return to the menu", 0, 300, love.graphics.getWidth(), "center")
end

-- Buy an item in the shop
function buyItem(index)
    local item = shopItems[index]
    if item and player.gold >= item.price then
        player.gold = player.gold - item.price
        item.apply(player)
    end
end

-- Draw the battle scene
function drawBattle()
    love.graphics.printf("Battle!", 0, 20, love.graphics.getWidth(), "center")
    love.graphics.printf("Player Health: " .. player.health .. " | Bullets: " .. player.bullets, 0, 50, love.graphics.getWidth(), "center")
    love.graphics.printf("Enemy Health: " .. enemy.health, 0, 80, love.graphics.getWidth(), "center")
    love.graphics.rectangle("fill", player.x, player.y, 20, 20) -- Player
    love.graphics.rectangle("fill", enemy.x, enemy.y, 20, 20)   -- Enemy

    -- Draw bullets
    for _, bullet in ipairs(bullets) do
        love.graphics.rectangle("fill", bullet.x, bullet.y, 10, 5)
    end
end
