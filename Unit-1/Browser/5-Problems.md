# Form Interaction Practice Problems

## Problem 1: Basic Form Access and Value Reading
Create an HTML form with:
- A text input with `name="username"` and `id="userInput"`
- An email input with `name="email"`
- A textarea with `name="message"`

Write JavaScript code to:
1. Access the form using `document.forms[0]`
2. Set the username field to "john_doe"
3. Set the email field to "john@example.com"
4. Set the message field to "Hello, world!"
5. Read and log all three values to the console

**Expected console output:**
```
Username: john_doe
Email: john@example.com
Message: Hello, world!
```

**Hint:** Use `form.elements['name']` to access form elements, and the `value` property to get/set text values!

---

## Problem 2: Working with Checkboxes and Radio Buttons
Create an HTML form with:
- 3 checkboxes with `name="interests"` and values: "reading", "coding", "gaming"
- 3 radio buttons with `name="experience"` and values: "beginner", "intermediate", "advanced"

Write JavaScript code to:
1. Check the "reading" and "coding" checkboxes programmatically
2. Select the "intermediate" radio button
3. Find which checkboxes are checked and log their values
4. Find which radio button is selected and log its value
5. Log the total number of checked checkboxes

**Expected console output:**
```
Checked interests: reading, coding
Selected experience: intermediate
Total checked checkboxes: 2
```

**Hint:** Remember that radio buttons with the same name return a collection, and you need to find the checked one!

---

## Problem 3: Select Dropdown Manipulation
Create an HTML form with:
- A `<select>` with `name="country"` containing options: "United States", "United Kingdom", "Canada", "Australia" (with corresponding values: "us", "uk", "ca", "au")
- A multiple `<select>` with `name="colors"` containing: "Red", "Green", "Blue", "Yellow"

Write JavaScript code to:
1. Set the country select to "United Kingdom" by value
2. Get and log the selected country's text (not just value)
3. Select "Red" and "Blue" in the colors multiple select
4. Get all selected colors and log them as an array
5. Log the total number of options in each select

**Expected console output:**
```
Selected country: United Kingdom
Selected colors: ["Red", "Blue"]
Country options: 4
Color options: 4
```

**Hint:** For multiple selects, use `Array.from(select.options).filter(option => option.selected)` to get selected options!

---

## Problem 4: Form Submission and Validation
Create an HTML form with:
- A text input with `name="username"` (required, minlength 3)
- An email input with `name="email"` (required)
- A password input with `name="password"` (required, minlength 6)
- A submit button

Write JavaScript code to:
1. Prevent the default form submission
2. When the form is submitted, validate that:
   - Username is at least 3 characters
   - Email is not empty
   - Password is at least 6 characters
3. If all validations pass, log "Form is valid!" and show an alert with the username
4. If any validation fails, log "Form is invalid!" and show which fields are invalid
5. Add visual feedback: set border color to red for invalid fields, green for valid fields

**Expected behavior:**
- If you enter valid data and submit, you should see: "Form is valid!" in console and an alert
- If you enter invalid data, you should see error messages and red borders on invalid fields

**Hint:** Use `e.preventDefault()` in the submit handler, and check each field's value length!

---

## Problem 5: Real-time Form Validation
Create an HTML form with:
- A text input with `name="username"` and `id="username"`
- An email input with `name="email"` and `id="email"`
- Error message divs with `id="usernameError"` and `id="emailError"` below each input
- A submit button

Write JavaScript code to:
1. Add real-time validation when the user leaves each field (use `blur` event):
   - Username: must be at least 3 characters, show error in `usernameError` div if invalid
   - Email: must contain "@" symbol, show error in `emailError` div if invalid
2. Clear error messages when the field becomes valid
3. On form submission, check if all fields are valid
4. Only allow submission if all validations pass
5. Log the form data if submission is successful

**Expected behavior:**
- As you type and leave fields, error messages appear/disappear in real-time
- Form only submits if all fields are valid
- On successful submission, form data is logged to console

**Hint:** Use `addEventListener('blur', ...)` for real-time validation, and check `input.value` to validate!

---

## Bonus Challenge 🌟
Create a complete registration form with:
- Username field (min 3 chars, max 20 chars)
- Email field (must be valid email format)
- Password field (min 8 chars, must contain at least one number)
- Confirm Password field (must match password)
- Age field (number, must be 18 or older)
- Country dropdown (required)
- Terms checkbox (must be checked)
- Submit button

Requirements:
1. Add real-time validation for all fields
2. Show specific error messages for each validation rule
3. Password strength indicator: show "Weak", "Medium", or "Strong" based on length and complexity
4. Confirm password only validates when password field is valid
5. On submit, prevent default, validate all fields, and if valid:
   - Create a FormData object from the form
   - Log all form data to console
   - Show a success message
   - Reset the form

**Extra challenge:** Add a "Show/Hide Password" toggle button for the password fields!

**Hint:** Use `FormData` to collect all values, check password length and use regex to check for numbers, and use `form.reset()` to clear the form after successful submission!

