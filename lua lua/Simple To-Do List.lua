-- Simple To-Do List
local tasks = {}

print("Welcome to the To-Do List App!")
while true do
    print("\nWhat would you like to do?")
    print("1. Add a task")
    print("2. View tasks")
    print("3. Remove a task")
    print("4. Exit")

    io.write("Your choice: ")
    local choice = tonumber(io.read())

    if choice == 1 then
        io.write("\nEnter a new task: ")
        local task = io.read()
        table.insert(tasks, task)
        print("Task added!")
    elseif choice == 2 then
        print("\nYour Tasks:")
        for i, task in ipairs(tasks) do
            print(i .. ". " .. task)
        end
    elseif choice == 3 then
        io.write("\nEnter the number of the task to remove: ")
        local index = tonumber(io.read())
        if tasks[index] then
            table.remove(tasks, index)
            print("Task removed!")
        else
            print("Invalid task number.")
        end
    elseif choice == 4 then
        print("\nGoodbye!")
        break
    else
        print("\nInvalid choice. Please try again.")
    end
end
