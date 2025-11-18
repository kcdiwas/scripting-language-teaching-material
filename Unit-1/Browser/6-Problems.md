# Cookie Practice Problems

## Problem 1: Basic Cookie Operations
Create an HTML page with JavaScript that:

1. Set three cookies:
   - `username` with value "john_doe"
   - `theme` with value "dark"
   - `language` with value "en"

2. Read all cookies using `document.cookie` and log them to console

3. Create a helper function `getCookie(name)` that:
   - Takes a cookie name as parameter
   - Returns the cookie value if found
   - Returns `null` if not found

4. Use your `getCookie()` function to read each cookie individually and log them

**Expected console output:**
```
All cookies: username=john_doe; theme=dark; language=en
Username: john_doe
Theme: dark
Language: en
```

**Hint:** Remember that `document.cookie` returns all cookies as a string separated by "; ". You need to split and parse it!

---

## Problem 2: Cookie with Expiration Date
Create an HTML page with JavaScript that:

1. Create a helper function `setCookie(name, value, days)` that:
   - Takes cookie name, value, and number of days until expiration
   - Sets the cookie with the appropriate expiration date
   - If `days` is not provided, create a session cookie (no expiration)

2. Set a cookie named `lastVisit` with value "2024-01-15" that expires in 30 days

3. Set a cookie named `sessionId` with value "abc123xyz" that expires when the browser closes (session cookie)

4. Read both cookies and log their values

5. Verify the expiration by checking if the cookies exist

**Expected console output:**
```
Last visit cookie: 2024-01-15
Session ID cookie: abc123xyz
```

**Hint:** To set expiration, create a Date object, add the number of days in milliseconds, and use `toUTCString()` method!

---

## Problem 3: Cookie-Based User Preferences
Create an HTML page with:

- A text input with `id="usernameInput"` and a button with `id="saveBtn"`
- A dropdown/select with `id="themeSelect"` containing options: "light", "dark", "auto"
- A button with `id="loadBtn"` to load saved preferences
- A button with `id="clearBtn"` to clear all cookies

Write JavaScript code to:

1. Create helper functions:
   - `setCookie(name, value, days)` - Set cookie with expiration
   - `getCookie(name)` - Get cookie value
   - `deleteCookie(name)` - Delete a cookie

2. When "Save" button is clicked:
   - Save the username from the input field as a cookie (expires in 7 days)
   - Save the selected theme as a cookie (expires in 30 days)
   - Show an alert: "Preferences saved!"

3. When "Load" button is clicked:
   - Load the saved username and set it in the input field
   - Load the saved theme and set it in the dropdown
   - If no preferences exist, show alert: "No saved preferences found"

4. When "Clear" button is clicked:
   - Delete both cookies
   - Clear the input field and reset the dropdown
   - Show alert: "All preferences cleared!"

5. On page load, automatically load saved preferences if they exist

**Expected behavior:**
- Enter username and select theme, click Save → preferences saved
- Refresh page → preferences automatically loaded
- Click Load → preferences loaded into form
- Click Clear → all cookies deleted and form reset

**Hint:** Use `document.getElementById()` to access form elements, and remember to check if cookies exist before trying to use them!

