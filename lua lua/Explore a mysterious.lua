-- Text-Based Adventure Game
-- By Severrir
-- Explore a mysterious forest and survive as long as you can.

-- Welcome Message
print("Welcome to the Mysterious Forest Adventure!")
print("You must make the right choices to survive.")
print("Type your choices as instructed and press Enter.")

-- Initialize Player Stats
local health = 100
local inventory = {}

-- Display Stats Function
local function displayStats()
    print("\nPlayer Stats:")
    print("Health: " .. health)
    print("Inventory: " .. (#inventory > 0 and table.concat(inventory, ", ") or "Empty"))
    print("-------------------")
end

-- Encounter: River
local function riverEncounter()
    print("\nYou hear the sound of rushing water.")
    print("You arrive at a fast-flowing river. You must cross it.")
    print("Do you:")
    print("1. Swim across")
    print("2. Look for a bridge")
    print("3. Turn back")

    local choice = io.read()
    if choice == "1" then
        print("\nYou dive into the river. The current is strong!")
        health = health - 30
        print("You make it to the other side but lose 30 health.")
    elseif choice == "2" then
        print("\nYou find a sturdy bridge and cross safely.")
    elseif choice == "3" then
        print("\nYou turn back and avoid the river. But time is wasted.")
    else
        print("\nInvalid choice. You stumble and lose 10 health.")
        health = health - 10
    end
end

-- Encounter: Wolf
local function wolfEncounter()
    print("\nYou hear a growl behind you.")
    print("A wild wolf appears!")
    print("Do you:")
    print("1. Fight it with a stick")
    print("2. Run away")
    print("3. Offer it food from your inventory")

    local choice = io.read()
    if choice == "1" then
        print("\nYou grab a stick and fight fiercely.")
        health = health - 20
        print("You scare the wolf away but lose 20 health.")
    elseif choice == "2" then
        print("\nYou run as fast as you can.")
        health = health - 10
        print("The wolf nips at your heels, losing 10 health.")
    elseif choice == "3" and #inventory > 0 then
        print("\nYou offer food from your inventory.")
        table.remove(inventory, 1)
        print("The wolf eats the food and leaves you alone.")
    else
        print("\nYou hesitate, and the wolf attacks!")
        health = health - 30
    end
end

-- Encounter: Treasure Chest
local function treasureEncounter()
    print("\nYou find a hidden treasure chest.")
    print("Do you:")
    print("1. Open it")
    print("2. Leave it alone")

    local choice = io.read()
    if choice == "1" then
        print("\nYou open the chest and find a health potion!")
        table.insert(inventory, "Health Potion")
    elseif choice == "2" then
        print("\nYou leave the chest alone and move on.")
    else
        print("\nInvalid choice. You trip and lose 5 health.")
        health = health - 5
    end
end

-- Main Game Loop
while health > 0 do
    displayStats()

    print("\nYou continue through the forest...")
    print("What do you want to do?")
    print("1. Explore a new area")
    print("2. Rest and recover")
    print("3. Use an item from your inventory")

    local choice = io.read()
    if choice == "1" then
        local event = math.random(1, 3)
        if event == 1 then
            riverEncounter()
        elseif event == 2 then
            wolfEncounter()
        else
            treasureEncounter()
        end
    elseif choice == "2" then
        print("\nYou rest under a tree and recover 20 health.")
        health = math.min(100, health + 20)
    elseif choice == "3" then
        if #inventory > 0 and inventory[1] == "Health Potion" then
            print("\nYou use the Health Potion and restore 50 health.")
            health = math.min(100, health + 50)
            table.remove(inventory, 1)
        else
            print("\nYou have nothing useful in your inventory.")
        end
    else
        print("\nInvalid choice. You lose 5 health for wasting time.")
        health = health - 5
    end
end

-- Game Over
print("\nYou have succumbed to the dangers of the forest.")
print("Game Over. Better luck next time!")
