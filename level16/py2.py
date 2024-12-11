# Define the correct password
correct_password = "mysecret123"

# Ask the user to enter the password
user_password = input("Enter your password: ")

# Keep asking until the user enters the correct password
while user_password != correct_password:
    print("Incorrect password, try again.")
    user_password = input("Enter your password: ")

# When the correct password is entered
print("Access granted!")
