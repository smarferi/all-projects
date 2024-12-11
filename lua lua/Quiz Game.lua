-- Quiz Game
local questions = {
    {q = "What is the capital of France?", a = "paris"},
    {q = "What is 5 + 3?", a = "8"},
    {q = "What is the color of the sky on a clear day?", a = "blue"},
}
local score = 0

print("Welcome to the Quiz Game!")
print("Answer the following questions:")

for i, question in ipairs(questions) do
    print("\nQuestion " .. i .. ": " .. question.q)
    io.write("Your answer: ")
    local answer = io.read():lower()

    if answer == question.a then
        print("Correct!")
        score = score + 1
    else
        print("Wrong. The correct answer was: " .. question.a)
    end
end

print("\nGame Over!")
print("Your score: " .. score .. "/" .. #questions)
