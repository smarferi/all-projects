-- Rock, Paper, Scissors Game
local choices = {"rock", "paper", "scissors"}
math.randomseed(os.time())

print("Welcome to Rock, Paper, Scissors!")
print("Type 'rock', 'paper', or 'scissors' to play.")

while true do
    io.write("\nYour choice (or 'quit' to exit): ")
    local playerChoice = io.read():lower()

    if playerChoice == "quit" then
        print("Thanks for playing!")
        break
    end

    local computerChoice = choices[math.random(1, 3)]
    print("Computer chose: " .. computerChoice)

    if playerChoice == computerChoice then
        print("It's a draw!")
    elseif (playerChoice == "rock" and computerChoice == "scissors") or
           (playerChoice == "paper" and computerChoice == "rock") or
           (playerChoice == "scissors" and computerChoice == "paper") then
        print("You win!")
    elseif playerChoice == "rock" or playerChoice == "paper" or playerChoice == "scissors" then
        print("You lose!")
    else
        print("Invalid choice. Please try again.")
    end
end
