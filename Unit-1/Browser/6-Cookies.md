# Working with Cookies in JavaScript

Cookies are small pieces of data stored in the user's browser. They allow websites to remember information about the user between page visits. Think of cookies like sticky notes that the browser keeps for a website.

## What are Cookies?

Cookies are:
- **Small text strings** stored by the browser
- **Sent automatically** to the server with every HTTP request
- **Domain-specific** - only accessible by the website that created them
- **Limited in size** - typically 4KB maximum per cookie
- **Limited in number** - browsers usually allow 20-50 cookies per domain

### Why Use Cookies?

Cookies are commonly used for:
- **Remembering user preferences** (theme, language)
- **Shopping cart contents** (items user added)
- **User authentication** (login status)
- **Tracking user behavior** (analytics)

```smart header="Cookies vs LocalStorage"
Cookies and LocalStorage both store data, but they're different:

**Cookies:**
- Sent to server with every request
- Limited size (4KB)
- Can have expiration dates
- Accessible by both client and server

**LocalStorage:**
- Only stored in browser
- Larger size (5-10MB)
- No expiration (until cleared)
- Only accessible by JavaScript

For exam purposes: Cookies are sent to the server automatically, LocalStorage is not!
```

## Understanding document.cookie

The `document.cookie` property is how you work with cookies in JavaScript. It's a special string that contains all cookies for the current domain.

### Reading Cookies

Reading cookies is done through `document.cookie`:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // document.cookie returns all cookies as a string
    console.log("All cookies:", document.cookie);
    
    // If no cookies exist, it returns an empty string
    if (document.cookie === '') {
      console.log("No cookies found");
    }
  </script>
</body>
</html>
```

**What you'll see:**
```
All cookies: 
No cookies found
```

```warn header="document.cookie returns all cookies as one string"
When you read `document.cookie`, you get ALL cookies as a single string, separated by semicolons and spaces. You need to parse this string to get individual cookie values:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Set some cookies first (we'll learn how in a moment)
    document.cookie = "username=john";
    document.cookie = "theme=dark";
    document.cookie = "language=en";
    
    // Read all cookies
    console.log("All cookies:", document.cookie);
    // Output: "username=john; theme=dark; language=en"
    
    // To get a specific cookie, you need to parse the string
    function getCookie(name) {
      let cookies = document.cookie.split('; ');
      for (let cookie of cookies) {
        let [key, value] = cookie.split('=');
        if (key === name) {
          return value;
        }
      }
      return null;
    }
    
    console.log("Username:", getCookie('username'));
    console.log("Theme:", getCookie('theme'));
    console.log("Language:", getCookie('language'));
  </script>
</body>
</html>
```

**What you'll see:**
```
All cookies: username=john; theme=dark; language=en
Username: john
Theme: dark
Language: en
```
```

### Setting Cookies

To set a cookie, you assign a string to `document.cookie`:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Basic cookie: name=value
    document.cookie = "username=john";
    
    console.log("Cookie set:", document.cookie);
    
    // Set another cookie
    document.cookie = "theme=light";
    
    console.log("All cookies now:", document.cookie);
    
    // Note: Setting doesn't replace existing cookies, it adds to them!
  </script>
</body>
</html>
```

**What you'll see:**
```
Cookie set: username=john
All cookies now: username=john; theme=light
```

```warn header="Setting cookies doesn't replace, it adds!"
When you set a cookie with `document.cookie = "name=value"`, it doesn't replace existing cookies—it adds a new one or updates an existing one with the same name. All cookies are stored together.

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Set first cookie
    document.cookie = "item1=apple";
    console.log("After first:", document.cookie);
    
    // Set second cookie
    document.cookie = "item2=banana";
    console.log("After second:", document.cookie);
    
    // Update first cookie (same name)
    document.cookie = "item1=orange";
    console.log("After update:", document.cookie);
    // Notice item1 changed, but item2 is still there!
  </script>
</body>
</html>
```

**What you'll see:**
```
After first: item1=apple
After second: item1=orange; item2=banana
After update: item1=orange; item2=banana
```
```

## Cookie Syntax

Cookies have a specific format. The basic syntax is:

```
name=value; expires=date; path=path; domain=domain; secure; samesite=policy
```

### Basic Cookie (name=value)

The simplest cookie is just `name=value`:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Simple cookie
    document.cookie = "username=john_doe";
    console.log("Cookie:", document.cookie);
    
    // Cookie with spaces (needs encoding)
    document.cookie = "message=Hello World";
    console.log("Cookie with space:", document.cookie);
    
    // Special characters should be encoded
    document.cookie = "email=user@example.com";
    console.log("Cookie with @:", document.cookie);
  </script>
</body>
</html>
```

### Cookie Attributes

Cookies can have several attributes that control their behavior:

#### 1. expires - When the Cookie Expires

By default, cookies are **session cookies** - they're deleted when the browser closes. To make a cookie persist, set an expiration date:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Cookie that expires in 7 days
    let date = new Date();
    date.setTime(date.getTime() + (7 * 24 * 60 * 60 * 1000)); // 7 days in milliseconds
    let expires = "expires=" + date.toUTCString();
    
    document.cookie = "username=john; " + expires;
    console.log("Cookie with expiration:", document.cookie);
    
    // Cookie that expires in 1 hour
    let date2 = new Date();
    date2.setTime(date2.getTime() + (60 * 60 * 1000)); // 1 hour
    document.cookie = "session=abc123; expires=" + date2.toUTCString();
    
    console.log("All cookies:", document.cookie);
  </script>
</body>
</html>
```

```smart header="Expiration date format"
Cookies use UTC time format. Always use `toUTCString()` when setting expiration dates:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Create date 30 days from now
    let date = new Date();
    date.setDate(date.getDate() + 30);
    
    // CORRECT: Use toUTCString()
    document.cookie = "longCookie=value; expires=" + date.toUTCString();
    
    // WRONG: Don't use toString() or toLocaleString()
    // document.cookie = "cookie=value; expires=" + date.toString(); // Won't work!
    
    console.log("Cookie set with expiration");
  </script>
</body>
</html>
```
```

#### 2. path - Where the Cookie is Available

The `path` attribute controls which pages can access the cookie:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Cookie available on entire site (default)
    document.cookie = "siteCookie=value1";
    
    // Cookie only available in /admin/ directory
    document.cookie = "adminCookie=value2; path=/admin/";
    
    // Cookie only available in current directory
    document.cookie = "localCookie=value3; path=/";
    
    console.log("Cookies set with different paths");
  </script>
</body>
</html>
```

```smart header="Default path"
If you don't specify a path, the cookie is available to the current directory and all subdirectories. To make it available site-wide, use `path=/`.
```

#### 3. domain - Which Domain Can Access

The `domain` attribute controls which domains can access the cookie:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Cookie for current domain only
    document.cookie = "localCookie=value1";
    
    // Cookie for example.com and all subdomains
    document.cookie = "domainCookie=value2; domain=example.com";
    
    // Note: You can only set domain for the current domain or parent domains
    // You cannot set domain=otherdomain.com from example.com
    
    console.log("Cookies set with domain restrictions");
  </script>
</body>
</html>
```

#### 4. secure - HTTPS Only

The `secure` flag makes the cookie only sent over HTTPS connections:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Secure cookie (only sent over HTTPS)
    document.cookie = "secureCookie=value; secure";
    
    // Regular cookie (sent over HTTP and HTTPS)
    document.cookie = "regularCookie=value";
    
    console.log("Secure cookie set (only works on HTTPS)");
  </script>
</body>
</html>
```

```warn header="Secure cookies only work on HTTPS"
The `secure` flag only works when your website is served over HTTPS. On HTTP, secure cookies won't be set or sent.
```

#### 5. samesite - Cross-Site Request Protection

The `samesite` attribute controls when cookies are sent with cross-site requests:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Cookie not sent with cross-site requests
    document.cookie = "strictCookie=value; samesite=strict";
    
    // Cookie sent with same-site and some cross-site requests
    document.cookie = "laxCookie=value; samesite=lax";
    
    // Cookie always sent (default, less secure)
    document.cookie = "noneCookie=value; samesite=none; secure";
    // Note: samesite=none requires secure flag
    
    console.log("Cookies set with samesite policies");
  </script>
</body>
</html>
```

## Helper Functions

Working with cookies directly can be tedious. Here are useful helper functions:

### Setting a Cookie

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    function setCookie(name, value, days) {
      let expires = "";
      if (days) {
        let date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
      }
      document.cookie = name + "=" + value + expires + "; path=/";
    }
    
    // Use the function
    setCookie("username", "john", 7); // Expires in 7 days
    setCookie("theme", "dark", 30);   // Expires in 30 days
    setCookie("session", "abc123");   // Session cookie (expires when browser closes)
    
    console.log("Cookies set:", document.cookie);
  </script>
</body>
</html>
```

### Getting a Cookie

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Set some cookies first
    document.cookie = "username=john";
    document.cookie = "theme=dark";
    document.cookie = "language=en";
    
    function getCookie(name) {
      let nameEQ = name + "=";
      let cookies = document.cookie.split('; ');
      
      for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i];
        if (cookie.indexOf(nameEQ) === 0) {
          return cookie.substring(nameEQ.length);
        }
      }
      return null; // Cookie not found
    }
    
    // Use the function
    console.log("Username:", getCookie('username'));
    console.log("Theme:", getCookie('theme'));
    console.log("Language:", getCookie('language'));
    console.log("Missing:", getCookie('nonexistent')); // null
  </script>
</body>
</html>
```

**What you'll see:**
```
Username: john
Theme: dark
Language: en
Missing: null
```

### Deleting a Cookie

To delete a cookie, set it with an expiration date in the past:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Set a cookie
    document.cookie = "temp=value";
    console.log("Before delete:", document.cookie);
    
    function deleteCookie(name) {
      document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
    }
    
    // Delete the cookie
    deleteCookie('temp');
    console.log("After delete:", document.cookie);
  </script>
</body>
</html>
```

**What you'll see:**
```
Before delete: temp=value
After delete: 
```

```smart header="Complete Cookie Helper Functions"
Here's a complete set of cookie helper functions you can use:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Set cookie
    function setCookie(name, value, days) {
      let expires = "";
      if (days) {
        let date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
      }
      document.cookie = name + "=" + (value || "") + expires + "; path=/";
    }
    
    // Get cookie
    function getCookie(name) {
      let nameEQ = name + "=";
      let cookies = document.cookie.split('; ');
      for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i];
        if (cookie.indexOf(nameEQ) === 0) {
          return cookie.substring(nameEQ.length);
        }
      }
      return null;
    }
    
    // Delete cookie
    function deleteCookie(name) {
      document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
    }
    
    // Test the functions
    setCookie("test", "value", 7);
    console.log("Get cookie:", getCookie('test'));
    deleteCookie('test');
    console.log("After delete:", getCookie('test'));
  </script>
</body>
</html>
```

**Memorize these functions for exams!** They're commonly asked.
```

## Practical Examples

### Example 1: Remembering User Preferences

```html run
<!DOCTYPE html>
<html>
<body>
  <h1>Theme Selector</h1>
  <button id="lightBtn">Light Theme</button>
  <button id="darkBtn">Dark Theme</button>
  
  <script>
    // Helper functions
    function setCookie(name, value, days) {
      let expires = "";
      if (days) {
        let date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
      }
      document.cookie = name + "=" + value + expires + "; path=/";
    }
    
    function getCookie(name) {
      let nameEQ = name + "=";
      let cookies = document.cookie.split('; ');
      for (let cookie of cookies) {
        if (cookie.indexOf(nameEQ) === 0) {
          return cookie.substring(nameEQ.length);
        }
      }
      return null;
    }
    
    // Load saved theme on page load
    let savedTheme = getCookie('theme');
    if (savedTheme) {
      document.body.style.backgroundColor = savedTheme === 'dark' ? '#333' : '#fff';
      document.body.style.color = savedTheme === 'dark' ? '#fff' : '#000';
      console.log("Loaded theme:", savedTheme);
    }
    
    // Theme buttons
    document.getElementById('lightBtn').addEventListener('click', function() {
      document.body.style.backgroundColor = '#fff';
      document.body.style.color = '#000';
      setCookie('theme', 'light', 30);
      console.log("Theme saved: light");
    });
    
    document.getElementById('darkBtn').addEventListener('click', function() {
      document.body.style.backgroundColor = '#333';
      document.body.style.color = '#fff';
      setCookie('theme', 'dark', 30);
      console.log("Theme saved: dark");
    });
  </script>
</body>
</html>
```

### Example 2: Simple Shopping Cart

```html run
<!DOCTYPE html>
<html>
<body>
  <h1>Shopping Cart</h1>
  <button id="addBtn">Add Item</button>
  <button id="viewBtn">View Cart</button>
  <button id="clearBtn">Clear Cart</button>
  <div id="cart"></div>
  
  <script>
    function setCookie(name, value, days) {
      let expires = "";
      if (days) {
        let date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
      }
      document.cookie = name + "=" + value + expires + "; path=/";
    }
    
    function getCookie(name) {
      let nameEQ = name + "=";
      let cookies = document.cookie.split('; ');
      for (let cookie of cookies) {
        if (cookie.indexOf(nameEQ) === 0) {
          return cookie.substring(nameEQ.length);
        }
      }
      return null;
    }
    
    // Add item to cart
    document.getElementById('addBtn').addEventListener('click', function() {
      let itemCount = parseInt(getCookie('cartItems') || '0');
      itemCount++;
      setCookie('cartItems', itemCount.toString(), 7);
      console.log("Item added. Total items:", itemCount);
    });
    
    // View cart
    document.getElementById('viewBtn').addEventListener('click', function() {
      let items = getCookie('cartItems') || '0';
      document.getElementById('cart').textContent = "Items in cart: " + items;
    });
    
    // Clear cart
    document.getElementById('clearBtn').addEventListener('click', function() {
      document.cookie = "cartItems=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
      document.getElementById('cart').textContent = "Cart cleared!";
      console.log("Cart cleared");
    });
  </script>
</body>
</html>
```

## Common Cookie Limitations

### Size Limit

Cookies have a **4KB size limit** (including name, value, and all attributes):

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Try to set a very large cookie
    let largeValue = "x".repeat(5000); // 5000 characters
    
    try {
      document.cookie = "large=" + largeValue;
      console.log("Cookie set successfully");
    } catch (e) {
      console.log("Error:", e.message);
    }
    
    // Check if it was actually set
    console.log("Cookie length:", document.cookie.length);
    // If it exceeds 4KB, the browser will reject it
  </script>
</body>
</html>
```

### Number Limit

Browsers typically allow **20-50 cookies per domain**:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Try to set many cookies
    for (let i = 0; i < 30; i++) {
      document.cookie = "cookie" + i + "=value" + i;
    }
    
    // Count cookies
    let cookieCount = document.cookie ? document.cookie.split('; ').length : 0;
    console.log("Total cookies:", cookieCount);
  </script>
</body>
</html>
```

### Character Encoding

Special characters in cookie values should be encoded using `encodeURIComponent()`:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Value with special characters
    let value = "Hello World! @#$%";
    
    // WRONG: Special characters can cause issues
    // document.cookie = "message=" + value;
    
    // CORRECT: Encode the value
    document.cookie = "message=" + encodeURIComponent(value);
    
    // When reading, decode it
    function getCookie(name) {
      let nameEQ = name + "=";
      let cookies = document.cookie.split('; ');
      for (let cookie of cookies) {
        if (cookie.indexOf(nameEQ) === 0) {
          return decodeURIComponent(cookie.substring(nameEQ.length));
        }
      }
      return null;
    }
    
    console.log("Cookie value:", getCookie('message'));
  </script>
</body>
</html>
```

**What you'll see:**
```
Cookie value: Hello World! @#$%
```

## Important Points for Exams

```smart header="Exam Essentials - Memorize These!"
**1. Basic Syntax:**
- `document.cookie` - Read all cookies (returns string)
- `document.cookie = "name=value"` - Set a cookie

**2. Cookie Attributes:**
- `expires=date` - When cookie expires (use `toUTCString()`)
- `path=/` - Where cookie is available
- `domain=example.com` - Which domain can access
- `secure` - Only sent over HTTPS
- `samesite=strict|lax|none` - Cross-site request policy

**3. Cookie Helper Functions:**
- `setCookie(name, value, days)` - Set cookie with expiration
- `getCookie(name)` - Get cookie value (returns string or null)
- `deleteCookie(name)` - Delete cookie (set expires to past date)

**4. Important Facts:**
- Cookies are sent to server automatically with HTTP requests
- Maximum size: 4KB per cookie
- Maximum number: 20-50 cookies per domain
- Session cookies expire when browser closes
- Use `encodeURIComponent()` for special characters
- `document.cookie` returns ALL cookies as one string separated by "; "

**5. Common Exam Questions:**
- How to set a cookie that expires in 7 days?
- How to read a specific cookie value?
- How to delete a cookie?
- What's the difference between session and persistent cookies?
- What's the maximum cookie size?
```

## Summary

Here's what you need to remember:

### Reading Cookies
- `document.cookie` - Returns all cookies as a string
- Parse the string to get individual cookie values
- Use helper function `getCookie(name)` for convenience

### Setting Cookies
- `document.cookie = "name=value"` - Basic cookie
- Add attributes: `expires`, `path`, `domain`, `secure`, `samesite`
- Use `encodeURIComponent()` for special characters

### Cookie Types
- **Session cookies** - Expire when browser closes (no expires attribute)
- **Persistent cookies** - Have expiration date (expires attribute)

### Limitations
- **Size:** 4KB maximum per cookie
- **Number:** 20-50 cookies per domain
- **Security:** Use `secure` flag for sensitive data

### Helper Functions
Always use helper functions in real code:
- `setCookie(name, value, days)` - Set cookie
- `getCookie(name)` - Get cookie value
- `deleteCookie(name)` - Delete cookie

### Common Uses
- User preferences (theme, language)
- Shopping carts
- Authentication tokens
- Tracking user behavior

Cookies are a fundamental part of web development. Master these concepts and you'll be able to create interactive, personalized web applications!

