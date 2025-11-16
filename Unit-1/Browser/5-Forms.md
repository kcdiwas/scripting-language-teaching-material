# Interacting with Form Elements

Forms are one of the most important ways users interact with web pages. JavaScript gives you powerful tools to read form values, validate input, and control form submission.

## Accessing Forms

There are several ways to access form elements in JavaScript.

### Accessing the Form Element

You can access a form by its ID, name, or position:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="loginForm" name="login">
    <input type="text" name="username">
    <input type="password" name="password">
  </form>

  <script>
    // By ID
    let form1 = document.getElementById('loginForm');
    console.log("Form by ID:", form1.id);
    
    // By name (returns a collection)
    let form2 = document.forms['login'];
    console.log("Form by name:", form2.name);
    
    // By index (first form on page)
    let form3 = document.forms[0];
    console.log("First form:", form3.id);
    
    // Using querySelector
    let form4 = document.querySelector('#loginForm');
    console.log("Form by querySelector:", form4.id);
  </script>
</body>
</html>
```

**What you'll see:**
```
Form by ID: loginForm
Form by name: login
First form: loginForm
Form by querySelector: loginForm
```

```smart header="document.forms collection"
The `document.forms` property gives you access to all forms on the page. It's a special collection that's indexed both by number and by name:

```html run
<!DOCTYPE html>
<html>
<body>
  <form name="form1" id="first">Form 1</form>
  <form name="form2" id="second">Form 2</form>
  <form name="form3" id="third">Form 3</form>

  <script>
    console.log("Total forms:", document.forms.length);
    
    // Access by index
    console.log("First form:", document.forms[0].name);
    console.log("Second form:", document.forms[1].name);
    
    // Access by name
    console.log("Form by name:", document.forms['form2'].id);
    
    // Loop through all forms
    for (let form of document.forms) {
      console.log("Form:", form.name, "ID:", form.id);
    }
  </script>
</body>
</html>
```

**What you'll see:**
```
Total forms: 3
First form: form1
Second form: form2
Form by name: second
Form: form1 ID: first
Form: form2 ID: second
Form: form3 ID: third
```
```

### Accessing Form Elements

Once you have a form, you can access its elements in several ways:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="myForm">
    <input type="text" name="username" id="userInput">
    <input type="email" name="email">
    <input type="password" name="password">
    <button type="submit">Submit</button>
  </form>

  <script>
    let form = document.getElementById('myForm');
    
    // Method 1: Using form.elements collection (by name)
    let username1 = form.elements['username'];
    console.log("Username field:", username1.name);
    
    // Method 2: Using form.elements collection (by index)
    let email1 = form.elements[1];
    console.log("Email field:", email1.name);
    
    // Method 3: Direct property access (if name is valid JavaScript identifier)
    let username2 = form.elements.username;
    console.log("Username (direct):", username2.name);
    
    // Method 4: Using getElementById
    let username3 = document.getElementById('userInput');
    console.log("Username (by ID):", username3.name);
    
    // Method 5: Using querySelector
    let email2 = form.querySelector('[name="email"]');
    console.log("Email (querySelector):", email2.name);
  </script>
</body>
</html>
```

**What you'll see:**
```
Username field: username
Email field: email
Username (direct): username
Username (by ID): userInput
Email (querySelector): email
```

```smart header="form.elements collection"
The `form.elements` property contains all form controls (inputs, selects, textareas, buttons) within the form. It's indexed by both number and name:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="example">
    <input type="text" name="field1">
    <input type="text" name="field2">
    <select name="choice">
      <option>Option 1</option>
      <option>Option 2</option>
    </select>
    <textarea name="message"></textarea>
  </form>

  <script>
    let form = document.getElementById('example');
    
    console.log("Total elements:", form.elements.length);
    
    // Access by name
    console.log("Field1:", form.elements['field1'].name);
    console.log("Choice:", form.elements['choice'].name);
    
    // Access by index
    for (let i = 0; i < form.elements.length; i++) {
      console.log(`Element ${i}:`, form.elements[i].name, form.elements[i].tagName);
    }
  </script>
</body>
</html>
```

**What you'll see:**
```
Total elements: 4
Field1: field1
Choice: choice
Element 0: field1 INPUT
Element 1: field2 INPUT
Element 2: choice SELECT
Element 3: message TEXTAREA
```
```

## Reading and Setting Values

Different form elements have different ways to get and set their values.

### Text Inputs

For `<input type="text">`, `<input type="email">`, `<input type="password">`, and `<textarea>`, use the `value` property:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="textForm">
    <input type="text" name="username" placeholder="Username">
    <input type="email" name="email" placeholder="Email">
    <textarea name="message" placeholder="Message"></textarea>
  </form>

  <script>
    let form = document.getElementById('textForm');
    
    // Set values
    form.elements.username.value = 'john_doe';
    form.elements.email.value = 'john@example.com';
    form.elements.message.value = 'Hello, world!';
    
    // Read values
    console.log("Username:", form.elements.username.value);
    console.log("Email:", form.elements.email.value);
    console.log("Message:", form.elements.message.value);
    
    // Check if empty
    if (form.elements.username.value === '') {
      console.log("Username is empty!");
    } else {
      console.log("Username has value");
    }
  </script>
</body>
</html>
```

**What you'll see:**
```
Username: john_doe
Email: john@example.com
Message: Hello, world!
Username has value
```

### Checkboxes

For checkboxes, use the `checked` property (boolean):

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="checkboxForm">
    <label>
      <input type="checkbox" name="agree" value="yes">
      I agree to the terms
    </label>
    <label>
      <input type="checkbox" name="newsletter" value="yes" checked>
      Subscribe to newsletter
    </label>
    <label>
      <input type="checkbox" name="notifications" value="yes">
      Enable notifications
    </label>
  </form>

  <script>
    let form = document.getElementById('checkboxForm');
    
    // Check if checked
    console.log("Agree checked?", form.elements.agree.checked);
    console.log("Newsletter checked?", form.elements.newsletter.checked);
    
    // Set checked state
    form.elements.agree.checked = true;
    form.elements.notifications.checked = true;
    
    console.log("\nAfter setting:");
    console.log("Agree checked?", form.elements.agree.checked);
    console.log("Notifications checked?", form.elements.notifications.checked);
    
    // Get value only if checked
    if (form.elements.agree.checked) {
      console.log("Agree value:", form.elements.agree.value);
    }
  </script>
</body>
</html>
```

**What you'll see:**
```
Agree checked? false
Newsletter checked? true

After setting:
Agree checked? true
Notifications checked? true
Agree value: yes
```

### Radio Buttons

Radio buttons work like checkboxes, but they're grouped by `name`. Only one in a group can be checked:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="radioForm">
    <label>
      <input type="radio" name="color" value="red">
      Red
    </label>
    <label>
      <input type="radio" name="color" value="green" checked>
      Green
    </label>
    <label>
      <input type="radio" name="color" value="blue">
      Blue
    </label>
  </form>

  <script>
    let form = document.getElementById('radioForm');
    
    // Get all radio buttons with name "color"
    let colors = form.elements['color'];
    console.log("Number of color options:", colors.length);
    
    // Find which one is checked
    for (let i = 0; i < colors.length; i++) {
      if (colors[i].checked) {
        console.log("Selected color:", colors[i].value);
      }
    }
    
    // Set a different one
    colors[0].checked = true; // Select "red"
    console.log("\nAfter selecting red:");
    console.log("Red checked?", colors[0].checked);
    console.log("Green checked?", colors[1].checked);
    
    // Get selected value
    let selected = Array.from(colors).find(radio => radio.checked);
    console.log("Currently selected:", selected.value);
  </script>
</body>
</html>
```

**What you'll see:**
```
Number of color options: 3
Selected color: green

After selecting red:
Red checked? true
Green checked? false
Currently selected: red
```

```warn header="Radio buttons return a collection"
When you access radio buttons by name, you get a collection (NodeList), not a single element:

```html run
<!DOCTYPE html>
<html>
<body>
  <form>
    <input type="radio" name="option" value="1">
    <input type="radio" name="option" value="2">
    <input type="radio" name="option" value="3">
  </form>

  <script>
    let form = document.forms[0];
    let options = form.elements['option'];
    
    console.log("Type:", typeof options);
    console.log("Is array?", Array.isArray(options));
    console.log("Length:", options.length);
    
    // Access individual radios
    console.log("First option value:", options[0].value);
    console.log("Second option value:", options[1].value);
    
    // Find checked one
    let checked = Array.from(options).find(opt => opt.checked);
    console.log("Checked value:", checked ? checked.value : "none");
  </script>
</body>
</html>
```

**What you'll see:**
```
Type: object
Is array? false
Length: 3
First option value: 1
Second option value: 2
Checked value: none
```
```

### Select Dropdowns

For `<select>` elements, use the `value` property to get/set the selected option:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="selectForm">
    <select name="country">
      <option value="">Choose a country</option>
      <option value="us">United States</option>
      <option value="uk">United Kingdom</option>
      <option value="ca">Canada</option>
      <option value="au">Australia</option>
    </select>
    
    <select name="colors" multiple>
      <option value="red">Red</option>
      <option value="green" selected>Green</option>
      <option value="blue" selected>Blue</option>
      <option value="yellow">Yellow</option>
    </select>
  </form>

  <script>
    let form = document.getElementById('selectForm');
    
    // Single select - get value
    console.log("Selected country:", form.elements.country.value);
    
    // Set value
    form.elements.country.value = 'uk';
    console.log("After setting to UK:", form.elements.country.value);
    
    // Get selected option text
    let selectedOption = form.elements.country.options[form.elements.country.selectedIndex];
    console.log("Selected text:", selectedOption.text);
    
    // Multiple select - get all selected values
    let colors = form.elements.colors;
    let selectedColors = Array.from(colors.options)
      .filter(option => option.selected)
      .map(option => option.value);
    console.log("\nSelected colors:", selectedColors);
    
    // Set multiple selections
    Array.from(colors.options).forEach(option => {
      if (option.value === 'red' || option.value === 'yellow') {
        option.selected = true;
      }
    });
    
    // Get updated selections
    selectedColors = Array.from(colors.options)
      .filter(option => option.selected)
      .map(option => option.value);
    console.log("After selecting red and yellow:", selectedColors);
  </script>
</body>
</html>
```

**What you'll see:**
```
Selected country: 
After setting to UK: uk
Selected text: United Kingdom

Selected colors: ["green", "blue"]
After selecting red and yellow: ["green", "blue", "red", "yellow"]
```

```smart header="Select element properties"
`<select>` elements have useful properties:
- `value` - The value of the selected option
- `selectedIndex` - The index of the selected option (-1 if none)
- `options` - Collection of all `<option>` elements
- `multiple` - Boolean indicating if multiple selection is allowed

```html run
<!DOCTYPE html>
<html>
<body>
  <select id="mySelect">
    <option value="a">Option A</option>
    <option value="b" selected>Option B</option>
    <option value="c">Option C</option>
  </select>

  <script>
    let select = document.getElementById('mySelect');
    
    console.log("Value:", select.value);
    console.log("Selected index:", select.selectedIndex);
    console.log("Number of options:", select.options.length);
    console.log("Selected option text:", select.options[select.selectedIndex].text);
    
    // Change selection by index
    select.selectedIndex = 0;
    console.log("\nAfter setting index to 0:");
    console.log("Value:", select.value);
    console.log("Text:", select.options[select.selectedIndex].text);
  </script>
</body>
</html>
```

**What you'll see:**
```
Value: b
Selected index: 1
Number of options: 3
Selected option text: Option B

After setting index to 0:
Value: a
Text: Option A
```
```

## Form Submission

Forms can be submitted in several ways, and you can intercept and control this process.

### Preventing Default Submission

By default, when a form is submitted, the page reloads. You can prevent this and handle submission with JavaScript:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="myForm">
    <input type="text" name="username" placeholder="Username">
    <input type="password" name="password" placeholder="Password">
    <button type="submit">Submit</button>
  </form>

  <div id="result"></div>

  <script>
    let form = document.getElementById('myForm');
    
    form.addEventListener('submit', function(e) {
      // Prevent default form submission (page reload)
      e.preventDefault();
      
      // Get form values
      let username = form.elements.username.value;
      let password = form.elements.password.value;
      
      console.log("Form submitted!");
      console.log("Username:", username);
      console.log("Password:", password);
      
      // Do something with the data (e.g., send to server)
      document.getElementById('result').textContent = 
        `Hello, ${username}! Form submitted successfully.`;
    });
  </script>
</body>
</html>
```

**What happens:**
- When you click Submit, the form doesn't reload the page
- Instead, the values are logged to console
- A message appears on the page

```warn header="Always prevent default for JavaScript form handling"
If you want to handle form submission with JavaScript, you MUST call `e.preventDefault()` or `return false` in the submit handler. Otherwise, the browser will try to submit the form normally (causing a page reload).

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="form1">
    <input type="text" name="data" value="Test">
    <button type="submit">Submit (no preventDefault)</button>
  </form>

  <form id="form2">
    <input type="text" name="data" value="Test">
    <button type="submit">Submit (with preventDefault)</button>
  </form>

  <script>
    // Form 1 - will reload page
    document.getElementById('form1').addEventListener('submit', function(e) {
      console.log("Form 1 submitted - page will reload!");
      // No preventDefault - page will reload
    });
    
    // Form 2 - won't reload page
    document.getElementById('form2').addEventListener('submit', function(e) {
      e.preventDefault();
      console.log("Form 2 submitted - page won't reload!");
      alert("Form submitted without page reload!");
    });
  </script>
</body>
</html>
```
```

### Programmatic Submission

You can submit a form programmatically using `form.submit()`:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="myForm" action="/submit" method="post">
    <input type="text" name="username" value="john">
    <input type="email" name="email" value="john@example.com">
  </form>

  <button id="submitBtn">Submit Form</button>

  <script>
    let form = document.getElementById('myForm');
    let button = document.getElementById('submitBtn');
    
    button.addEventListener('click', function() {
      // Submit the form programmatically
      form.submit();
    });
    
    // You can also intercept this
    form.addEventListener('submit', function(e) {
      console.log("Form is being submitted!");
      console.log("Username:", form.elements.username.value);
      // Note: preventDefault here will stop programmatic submission too
    });
  </script>
</body>
</html>
```

```warn header="submit() doesn't trigger submit event in some cases"
When you call `form.submit()` directly, it may not trigger the `submit` event in all browsers. To ensure your handler runs, either:
1. Call your handler function directly before submitting
2. Use a submit button and click it programmatically

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="form1">
    <input type="text" name="data" value="test">
    <button type="submit" id="submitBtn">Submit</button>
  </form>

  <script>
    let form = document.getElementById('form1');
    let button = document.getElementById('submitBtn');
    
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      console.log("Submit event fired!");
    });
    
    // Method 1: Click the button (triggers submit event)
    setTimeout(() => {
      console.log("Clicking button...");
      button.click(); // This will trigger submit event
    }, 1000);
    
    // Method 2: Call form.submit() directly (may not trigger event)
    // form.submit(); // Use with caution
  </script>
</body>
</html>
```
```

### Resetting Forms

You can reset a form to its initial state using `form.reset()`:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="myForm">
    <input type="text" name="username" value="Initial value">
    <input type="email" name="email" value="initial@example.com">
    <label>
      <input type="checkbox" name="agree" checked>
      I agree
    </label>
    <select name="country">
      <option value="us" selected>United States</option>
      <option value="uk">United Kingdom</option>
    </select>
  </form>

  <button id="resetBtn">Reset Form</button>

  <script>
    let form = document.getElementById('myForm');
    let resetBtn = document.getElementById('resetBtn');
    
    // Change some values
    form.elements.username.value = 'Changed value';
    form.elements.email.value = 'changed@example.com';
    form.elements.agree.checked = false;
    form.elements.country.value = 'uk';
    
    console.log("After changes:");
    console.log("Username:", form.elements.username.value);
    console.log("Email:", form.elements.email.value);
    console.log("Agree:", form.elements.agree.checked);
    console.log("Country:", form.elements.country.value);
    
    // Reset button handler
    resetBtn.addEventListener('click', function() {
      form.reset();
      console.log("\nAfter reset:");
      console.log("Username:", form.elements.username.value);
      console.log("Email:", form.elements.email.value);
      console.log("Agree:", form.elements.agree.checked);
      console.log("Country:", form.elements.country.value);
    });
  </script>
</body>
</html>
```

**What you'll see:**
```
After changes:
Username: Changed value
Email: changed@example.com
Agree: false
Country: uk

After reset:
Username: Initial value
Email: initial@example.com
Agree: true
Country: us
```

## Form Validation

You can validate form input before submission. HTML5 provides built-in validation, but you can also add custom JavaScript validation.

### HTML5 Validation

HTML5 provides built-in validation attributes:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="validatedForm">
    <input type="text" name="username" required minlength="3" placeholder="Username (min 3 chars)">
    <input type="email" name="email" required placeholder="Email (required)">
    <input type="number" name="age" min="18" max="100" placeholder="Age (18-100)">
    <input type="url" name="website" placeholder="Website URL">
    <button type="submit">Submit</button>
  </form>

  <script>
    let form = document.getElementById('validatedForm');
    
    form.addEventListener('submit', function(e) {
      // Check if form is valid
      if (form.checkValidity()) {
        e.preventDefault();
        console.log("Form is valid!");
        alert("Form is valid - would submit here");
      } else {
        e.preventDefault();
        console.log("Form is invalid!");
        
        // Show validation messages
        let inputs = form.elements;
        for (let i = 0; i < inputs.length; i++) {
          if (!inputs[i].validity.valid && inputs[i].type !== 'submit') {
            console.log(`${inputs[i].name} is invalid:`, inputs[i].validationMessage);
          }
        }
      }
    });
  </script>
</body>
</html>
```

### Custom Validation

You can add your own validation logic:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="customForm">
    <input type="text" name="username" id="username" placeholder="Username">
    <div id="usernameError" style="color: red;"></div>
    
    <input type="password" name="password" id="password" placeholder="Password">
    <div id="passwordError" style="color: red;"></div>
    
    <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password">
    <div id="confirmError" style="color: red;"></div>
    
    <button type="submit">Submit</button>
  </form>

  <script>
    let form = document.getElementById('customForm');
    let username = document.getElementById('username');
    let password = document.getElementById('password');
    let confirmPassword = document.getElementById('confirmPassword');
    
    // Validate username
    function validateUsername() {
      let errorDiv = document.getElementById('usernameError');
      if (username.value.length < 3) {
        errorDiv.textContent = "Username must be at least 3 characters";
        username.style.borderColor = 'red';
        return false;
      } else {
        errorDiv.textContent = "";
        username.style.borderColor = '';
        return true;
      }
    }
    
    // Validate password
    function validatePassword() {
      let errorDiv = document.getElementById('passwordError');
      if (password.value.length < 6) {
        errorDiv.textContent = "Password must be at least 6 characters";
        password.style.borderColor = 'red';
        return false;
      } else {
        errorDiv.textContent = "";
        password.style.borderColor = '';
        return true;
      }
    }
    
    // Validate password match
    function validateConfirm() {
      let errorDiv = document.getElementById('confirmError');
      if (password.value !== confirmPassword.value) {
        errorDiv.textContent = "Passwords do not match";
        confirmPassword.style.borderColor = 'red';
        return false;
      } else {
        errorDiv.textContent = "";
        confirmPassword.style.borderColor = '';
        return true;
      }
    }
    
    // Real-time validation
    username.addEventListener('blur', validateUsername);
    password.addEventListener('blur', validatePassword);
    confirmPassword.addEventListener('blur', validateConfirm);
    
    // Form submission
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      
      let isUsernameValid = validateUsername();
      let isPasswordValid = validatePassword();
      let isConfirmValid = validateConfirm();
      
      if (isUsernameValid && isPasswordValid && isConfirmValid) {
        console.log("All validations passed!");
        alert("Form is valid - would submit here");
      } else {
        console.log("Validation failed!");
      }
    });
  </script>
</body>
</html>
```

### Validity API

The HTML5 Validity API provides detailed information about why an input is invalid:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="validityForm">
    <input type="email" name="email" required id="emailInput" placeholder="Email">
    <div id="errorMsg"></div>
    <button type="submit">Submit</button>
  </form>

  <script>
    let emailInput = document.getElementById('emailInput');
    let errorMsg = document.getElementById('errorMsg');
    
    emailInput.addEventListener('input', function() {
      if (emailInput.validity.valid) {
        errorMsg.textContent = "";
        emailInput.style.borderColor = 'green';
      } else {
        if (emailInput.validity.valueMissing) {
          errorMsg.textContent = "Email is required";
        } else if (emailInput.validity.typeMismatch) {
          errorMsg.textContent = "Please enter a valid email address";
        }
        emailInput.style.borderColor = 'red';
      }
    });
    
    document.getElementById('validityForm').addEventListener('submit', function(e) {
      e.preventDefault();
      if (emailInput.validity.valid) {
        console.log("Email is valid:", emailInput.value);
      } else {
        console.log("Email is invalid:", emailInput.validationMessage);
      }
    });
  </script>
</body>
</html>
```

```smart header="ValidityState properties"
The `validity` property is a `ValidityState` object with these useful properties:
- `valid` - `true` if the element is valid
- `valueMissing` - `true` if required but empty
- `typeMismatch` - `true` if value doesn't match the type (e.g., email format)
- `tooShort` / `tooLong` - `true` if length constraints violated
- `rangeUnderflow` / `rangeOverflow` - `true` if number is out of range
- `patternMismatch` - `true` if value doesn't match pattern
- `customError` - `true` if custom validation error set
- `validationMessage` - The error message to display
```

## Special Form Properties

Forms and form elements have several useful properties:

### Form Properties

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="myForm" action="/submit" method="post" enctype="multipart/form-data">
    <input type="text" name="data" value="test">
    <button type="submit">Submit</button>
  </form>

  <script>
    let form = document.getElementById('myForm');
    
    console.log("Form action:", form.action);
    console.log("Form method:", form.method);
    console.log("Form encoding:", form.enctype);
    console.log("Form name:", form.name);
    console.log("Form ID:", form.id);
    console.log("Number of elements:", form.elements.length);
    
    // You can change these
    form.method = 'get';
    console.log("\nAfter changing method:", form.method);
  </script>
</body>
</html>
```

### Input Properties

```html run
<!DOCTYPE html>
<html>
<body>
  <form>
    <input type="text" name="username" id="userInput" 
           value="john" placeholder="Enter username" 
           required maxlength="20" disabled>
  </form>

  <script>
    let input = document.getElementById('userInput');
    
    console.log("Input type:", input.type);
    console.log("Input name:", input.name);
    console.log("Input value:", input.value);
    console.log("Input placeholder:", input.placeholder);
    console.log("Is required?", input.required);
    console.log("Max length:", input.maxLength);
    console.log("Is disabled?", input.disabled);
    console.log("Is read-only?", input.readOnly);
    
    // Enable the input
    input.disabled = false;
    console.log("\nAfter enabling:");
    console.log("Is disabled?", input.disabled);
    
    // Make it read-only
    input.readOnly = true;
    console.log("Is read-only?", input.readOnly);
  </script>
</body>
</html>
```

## Working with FormData

The `FormData` API makes it easy to collect all form values:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="myForm">
    <input type="text" name="username" value="john">
    <input type="email" name="email" value="john@example.com">
    <input type="checkbox" name="newsletter" value="yes" checked>
    <select name="country">
      <option value="us" selected>United States</option>
      <option value="uk">United Kingdom</option>
    </select>
  </form>

  <script>
    let form = document.getElementById('myForm');
    
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      
      // Create FormData from form
      let formData = new FormData(form);
      
      // Get individual values
      console.log("Username:", formData.get('username'));
      console.log("Email:", formData.get('email'));
      console.log("Newsletter:", formData.get('newsletter'));
      console.log("Country:", formData.get('country'));
      
      // Get all entries
      console.log("\nAll entries:");
      for (let [key, value] of formData.entries()) {
        console.log(`${key}: ${value}`);
      }
      
      // Check if has a field
      console.log("\nHas username?", formData.has('username'));
      console.log("Has phone?", formData.has('phone'));
    });
  </script>
</body>
</html>
```

**What you'll see:**
```
Username: john
Email: john@example.com
Newsletter: yes
Country: us

All entries:
username: john
email: john@example.com
newsletter: yes
country: us

Has username? true
Has phone? false
```

```smart header="FormData is useful for AJAX"
`FormData` is especially useful when sending form data via AJAX/fetch:

```html run
<!DOCTYPE html>
<html>
<body>
  <form id="ajaxForm">
    <input type="text" name="username" value="john">
    <input type="email" name="email" value="john@example.com">
    <button type="submit">Submit</button>
  </form>

  <script>
    document.getElementById('ajaxForm').addEventListener('submit', async function(e) {
      e.preventDefault();
      
      let formData = new FormData(this);
      
      // Send via fetch (this is just an example - won't actually work)
      try {
        // let response = await fetch('/api/submit', {
        //   method: 'POST',
        //   body: formData
        // });
        console.log("Would send:", Object.fromEntries(formData));
      } catch (error) {
        console.error("Error:", error);
      }
    });
  </script>
</body>
</html>
```
```

## Summary

Here's what you need to remember about working with forms:

### Accessing Forms
- `document.forms` - Collection of all forms
- `document.getElementById('formId')` - Get form by ID
- `form.elements` - Collection of all form controls
- `form.elements['name']` - Get element by name

### Reading Values
- **Text inputs, textareas, selects:** Use `value` property
- **Checkboxes, radio buttons:** Use `checked` property (boolean)
- **Radio buttons:** Access as collection, find checked one

### Setting Values
- **Text inputs:** `element.value = 'new value'`
- **Checkboxes/radios:** `element.checked = true/false`
- **Selects:** `select.value = 'optionValue'` or `select.selectedIndex = 0`

### Form Submission
- `form.addEventListener('submit', handler)` - Handle submission
- `e.preventDefault()` - Prevent default submission (page reload)
- `form.submit()` - Submit programmatically
- `form.reset()` - Reset to initial values

### Validation
- HTML5 attributes: `required`, `minlength`, `maxlength`, `type`, etc.
- `form.checkValidity()` - Check if form is valid
- `element.validity` - Detailed validity information
- `element.validationMessage` - Error message

### FormData
- `new FormData(form)` - Create FormData from form
- `formData.get('name')` - Get value by name
- `formData.entries()` - Get all entries
- Useful for AJAX submissions

Forms are powerful tools for user interaction. Master these techniques and you'll be able to create rich, interactive web applications!

