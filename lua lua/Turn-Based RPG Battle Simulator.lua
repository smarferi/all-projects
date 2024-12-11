-- Turn-Based RPG Battle Simulator
-- By Severrir

-- Utility function for pausing between actions
local function wait(seconds)
    local start = os.time()
    repeat until os.time() > start + seconds
end

-- Character Class
local Character = {}
Character.__index = Character

function Character:new(name, health, attack, defense, magic)
    local character = setmetatable({}, Character)
    character.name = name
    character.health = health
    character.maxHealth = health
    character.attack = attack
    character.defense = defense
    character.magic = magic
    character.isAlive = true
    return character
end

function Character:takeDamage(damage)
    local mitigated = math.max(0, damage - self.defense)
    self.health = self.health - mitigated
    print(self.name .. " takes " .. mitigated .. " damage!")
    if self.health <= 0 then
        self.health = 0
        self.isAlive = false
        print(self.name .. " has fallen!")
    end
end

function Character:heal(amount)
    if self.isAlive then
        self.health = math.min(self.maxHealth, self.health + amount)
        print(self.name .. " heals for " .. amount .. " health!")
    end
end

function Character:attackTarget(target)
    if self.isAlive then
        local damage = self.attack + math.random(-5, 5)
        print(self.name .. " attacks " .. target.name .. " for " .. damage .. " damage!")
        target:takeDamage(damage)
    end
end

function Character:castSpell(target)
    if self.isAlive then
        local damage = self.magic + math.random(-10, 10)
        print(self.name .. " casts a powerful spell on " .. target.name .. " for " .. damage .. " damage!")
        target:takeDamage(damage)
    end
end

function Character:displayStats()
    print("\n" .. self.name .. "'s Stats:")
    print("Health: " .. self.health .. "/" .. self.maxHealth)
    print("Attack: " .. self.attack)
    print("Defense: " .. self.defense)
    print("Magic: " .. self.magic)
end

-- Player Class (inherits from Character)
local Player = setmetatable({}, {__index = Character})

function Player:new(name)
    local player = Character:new(name, 100, 15, 10, 20)
    setmetatable(player, {__index = Player})
    player.level = 1
    player.experience = 0
    return player
end

function Player:gainExperience(exp)
    print(self.name .. " gains " .. exp .. " experience points!")
    self.experience = self.experience + exp
    if self.experience >= self.level * 10 then
        self:levelUp()
    end
end

function Player:levelUp()
    self.level = self.level + 1
    self.experience = 0
    self.maxHealth = self.maxHealth + 20
    self.health = self.maxHealth
    self.attack = self.attack + 5
    self.defense = self.defense + 3
    self.magic = self.magic + 5
    print("\nCongratulations! " .. self.name .. " leveled up to Level " .. self.level .. "!")
    self:displayStats()
end

-- Enemy Class (inherits from Character)
local Enemy = setmetatable({}, {__index = Character})

function Enemy:new(name, health, attack, defense, magic)
    local enemy = Character:new(name, health, attack, defense, magic)
    setmetatable(enemy, {__index = Enemy})
    return enemy
end

-- Battle System
local function battle(player, enemy)
    print("\nA wild " .. enemy.name .. " appears!")
    while player.isAlive and enemy.isAlive do
        -- Player Turn
        print("\nYour turn! What will you do?")
        print("1. Attack")
        print("2. Cast Spell")
        print("3. Heal")
        io.write("Choose an action (1-3): ")
        local choice = tonumber(io.read())

        if choice == 1 then
            player:attackTarget(enemy)
        elseif choice == 2 then
            player:castSpell(enemy)
        elseif choice == 3 then
            player:heal(20)
        else
            print("Invalid choice! You lose your turn.")
        end

        -- Enemy Turn
        if enemy.isAlive then
            print("\nThe enemy attacks!")
            if math.random(1, 2) == 1 then
                enemy:attackTarget(player)
            else
                enemy:castSpell(player)
            end
        end
        wait(1)
    end

    if player.isAlive then
        print("\nYou defeated the " .. enemy.name .. "!")
        local expGained = math.random(5, 15)
        player:gainExperience(expGained)
    else
        print("\nYou were defeated by the " .. enemy.name .. ". Game over!")
    end
end

-- Main Game Loop
local function gameLoop()
    print("Welcome to the RPG Battle Simulator!")
    io.write("Enter your character's name: ")
    local playerName = io.read()
    local player = Player:new(playerName)

    local enemies = {
        Enemy:new("Goblin", 50, 10, 5, 0),
        Enemy:new("Orc", 80, 15, 8, 0),
        Enemy:new("Dark Mage", 60, 10, 5, 15),
        Enemy:new("Dragon", 150, 25, 10, 20)
    }

    for i, enemy in ipairs(enemies) do
        if player.isAlive then
            battle(player, enemy)
        else
            break
        end
    end

    if player.isAlive then
        print("\nCongratulations! You have defeated all the enemies and emerged victorious!")
    end
end

-- Start the game
gameLoop()
