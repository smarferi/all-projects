-- Number Guessing Game
math.randomseed(os.time())
local secret = math.random(1, 100)
local attempts = 0
local guess

print("Welcome to the Number Guessing Game!")
print("I have selected a number between 1 and 100.")
print("Can you guess what it is?")

while guess ~= secret do
    io.write("\nEnter your guess: ")
    guess = tonumber(io.read())
    attempts = attempts + 1

    if guess < secret then
        print("Too low!")
    elseif guess > secret then
        print("Too high!")
    else
        print("\nCongratulations! You guessed the number in " .. attempts .. " attempts.")
    end
end

