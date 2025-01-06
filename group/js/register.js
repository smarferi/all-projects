function checkPassword() {
    const usernameInput = document.querySelector('.username');
    const passwordInput = document.querySelector('.password');

    if (usernameInput && passwordInput) {
        const enteredUsername = usernameInput.value;
        const enteredPassword = passwordInput.value;

        console.log("Entered Username:", enteredUsername); 
        console.log("Entered Password:", enteredPassword);

        if (enteredUsername === 'severrir' && enteredPassword === 'severrir111') {
            console.log("Login successful! Redirecting...");
            window.location.href = '../html/home.html'; 
        } else {
            alert("Incorrect username or password. Please try again."); 
        }
    } else {
        console.error("Input fields are missing in the HTML.");
    }
}
