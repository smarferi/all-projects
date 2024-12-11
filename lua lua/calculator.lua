-- Simple Calculator
print("Welcome to the Simple Calculator!")
print("Enter two numbers:")

-- Input numbers
io.write("First number: ")
local num1 = tonumber(io.read())
io.write("Second number: ")
local num2 = tonumber(io.read())

-- Input operation
print("\nChoose an operation: +, -, *, /")
io.write("Operation: ")
local operation = io.read()

-- Perform calculation
local result
if operation == "+" then
    result = num1 + num2
elseif operation == "-" then
    result = num1 - num2
elseif operation == "*" then
    result = num1 * num2
elseif operation == "/" then
    if num2 ~= 0 then
        result = num1 / num2
    else
        print("\nError: Division by zero!")
        result = "undefined"
    end
else
    print("\nInvalid operation!")
    result = "undefined"
end

-- Display result
print("\nResult: " .. tostring(result))
