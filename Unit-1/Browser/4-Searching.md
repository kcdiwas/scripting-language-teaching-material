# Searching for Elements in the DOM

Now that you know how to navigate the DOM tree, you'll often want to find specific elements. Instead of manually walking through `childNodes` and checking each one, JavaScript provides powerful search methods to find elements quickly.

All search methods are available on the `document` object (to search the entire page) or on any element (to search within that element's subtree).

## The Old Way: getElementById, getElementsByTagName, etc.

These methods have been around since the early days of JavaScript. They're still useful and widely supported.

### Finding by ID: `getElementById`

The most common way to find an element is by its `id` attribute. IDs should be unique on a page (though browsers won't stop you if you have duplicates).

**Syntax:** `document.getElementById(id)` or `element.getElementById(id)`

```html run
<!DOCTYPE html>
<html>
<body>
  <div id="header">Welcome</div>
  <div id="content">Main content here</div>
  <div id="footer">Footer text</div>

  <script>
    // Find element by ID
    let header = document.getElementById('header');
    console.log("Found header:", header.textContent);
    
    // Change its style
    header.style.color = 'blue';
    header.style.fontSize = '24px';
    
    // What if the ID doesn't exist?
    let missing = document.getElementById('nonexistent');
    console.log("Missing element:", missing); // null
    
    // Always check for null!
    if (missing) {
      missing.style.color = 'red';
    } else {
      console.log("Element not found - can't change style");
    }
  </script>
</body>
</html>
```

**What you'll see:**
```
Found header: Welcome
Missing element: null
Element not found - can't change style
```

```warn header="getElementById returns null if not found"
If an element with the given ID doesn't exist, `getElementById` returns `null`. Always check for `null` before using the element, or you'll get errors:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    let elem = document.getElementById('missing');
    // This will cause an error!
    // elem.style.color = 'red'; // TypeError: Cannot read property 'style' of null
    
    // Always check first:
    if (elem) {
      elem.style.color = 'red';
    }
    
    // Or use optional chaining (modern JavaScript):
    elem?.style.color = 'red'; // Safe - does nothing if elem is null
  </script>
</body>
</html>
```
```

```smart header="ID naming rules"
IDs in HTML must:
- Start with a letter (a-z, A-Z)
- Can contain letters, digits, hyphens, underscores, colons, and periods
- Are case-sensitive
- Should be unique (one per page)

Good IDs: `header`, `main-content`, `user_123`, `item-1`
Bad IDs: `123item` (starts with number), `my id` (has space)
```

### Finding by Tag Name: `getElementsByTagName`

This method finds all elements with a specific tag name (like `<div>`, `<p>`, `<span>`).

**Syntax:** `document.getElementsByTagName(tagName)` or `element.getElementsByTagName(tagName)`

**Important:** This returns a **collection** (not an array), even if there's only one element.

```html run
<!DOCTYPE html>
<html>
<body>
  <div>First div</div>
  <p>First paragraph</p>
  <div>Second div</div>
  <p>Second paragraph</p>
  <div>Third div</div>

  <script>
    // Get all div elements
    let divs = document.getElementsByTagName('div');
    console.log("Number of divs:", divs.length);
    
    // Loop through them
    for (let i = 0; i < divs.length; i++) {
      console.log(`Div ${i}:`, divs[i].textContent);
      divs[i].style.border = '2px solid blue';
    }
    
    // Get all paragraphs
    let paragraphs = document.getElementsByTagName('p');
    console.log("\nNumber of paragraphs:", paragraphs.length);
    
    // You can also search within a specific element
    let container = document.body;
    let bodyDivs = container.getElementsByTagName('div');
    console.log("Divs in body:", bodyDivs.length);
  </script>
</body>
</html>
```

**What you'll see:**
```
Number of divs: 3
Div 0: First div
Div 1: Second div
Div 2: Third div
Number of paragraphs: 2
Divs in body: 3
```

```warn header="Collections are live"
The collection returned by `getElementsByTagName` is **live**—it automatically updates when the DOM changes:

```html run
<!DOCTYPE html>
<html>
<body>
  <div>Existing div</div>

  <script>
    let divs = document.getElementsByTagName('div');
    console.log("Initial count:", divs.length); // 1
    
    // Add a new div
    let newDiv = document.createElement('div');
    newDiv.textContent = "New div";
    document.body.appendChild(newDiv);
    
    // The collection automatically updated!
    console.log("After adding:", divs.length); // 2
    console.log("No need to call getElementsByTagName again!");
  </script>
</body>
</html>
```

This can be convenient, but it can also cause bugs if you're not careful. If you remove elements while looping, the collection changes and you might skip elements.
```

```warn header="Tag names are case-insensitive in HTML"
In HTML, tag names are case-insensitive. `getElementsByTagName('DIV')` and `getElementsByTagName('div')` return the same results:

```html run
<!DOCTYPE html>
<html>
<body>
  <div>Test</div>

  <script>
    let divs1 = document.getElementsByTagName('div');
    let divs2 = document.getElementsByTagName('DIV');
    let divs3 = document.getElementsByTagName('Div');
    
    console.log("All return same count:", 
      divs1.length === divs2.length && divs2.length === divs3.length);
    // true
  </script>
</body>
</html>
```

However, in XML/XHTML documents, tag names are case-sensitive. For HTML, you can use any case you want.
```

### Finding by Class Name: `getElementsByClassName`

This method finds all elements that have a specific class (or multiple classes).

**Syntax:** `document.getElementsByClassName(className)` or `element.getElementsByClassName(className)`

**Important:** Like `getElementsByTagName`, this returns a **live collection**.

```html run
<!DOCTYPE html>
<html>
<body>
  <div class="item">Item 1</div>
  <div class="item highlight">Item 2</div>
  <div class="item">Item 3</div>
  <p class="item">Item 4 (paragraph)</p>
  <div class="other">Not an item</div>

  <script>
    // Get all elements with class "item"
    let items = document.getElementsByClassName('item');
    console.log("Elements with class 'item':", items.length);
    
    for (let item of items) {
      console.log("  -", item.tagName, ":", item.textContent);
      item.style.backgroundColor = 'lightblue';
    }
    
    // You can search for multiple classes
    // This finds elements that have BOTH "item" AND "highlight"
    let highlighted = document.getElementsByClassName('item highlight');
    console.log("\nElements with both classes:", highlighted.length);
    highlighted[0].style.fontWeight = 'bold';
  </script>
</body>
</html>
```

**What you'll see:**
```
Elements with class 'item': 4
  - DIV : Item 1
  - DIV : Item 2
  - DIV : Item 3
  - P : Item 4 (paragraph)
Elements with both classes: 1
```

```smart header="Multiple classes in getElementsByClassName"
When you pass multiple class names to `getElementsByClassName`, they must be separated by spaces, and the element must have **all** of them:

```html run
<!DOCTYPE html>
<html>
<body>
  <div class="red">Red only</div>
  <div class="big">Big only</div>
  <div class="red big">Red and big</div>
  <div class="big red">Also red and big (order doesn't matter)</div>

  <script>
    // Find elements with BOTH "red" AND "big"
    let redAndBig = document.getElementsByClassName('red big');
    console.log("Elements with both classes:", redAndBig.length); // 2
    
    for (let elem of redAndBig) {
      elem.style.border = '3px solid red';
    }
  </script>
</body>
</html>
```
```

### Finding by Name: `getElementsByName`

This method finds elements by their `name` attribute. It's most commonly used with form elements like `<input>`, `<select>`, and `<textarea>`.

**Syntax:** `document.getElementsByName(name)`

**Important:** This also returns a **live collection**.

```html run
<!DOCTYPE html>
<html>
<body>
  <form>
    <input type="text" name="username" placeholder="Username">
    <input type="email" name="email" placeholder="Email">
    <input type="text" name="username" placeholder="Username (duplicate)">
    <input type="password" name="password" placeholder="Password">
  </form>

  <script>
    // Get all inputs with name="username"
    let usernameInputs = document.getElementsByName('username');
    console.log("Inputs named 'username':", usernameInputs.length);
    
    for (let input of usernameInputs) {
      console.log("  -", input.placeholder, ":", input.value || "(empty)");
      input.style.border = '2px solid green';
    }
    
    // Get email input
    let emailInput = document.getElementsByName('email')[0];
    if (emailInput) {
      emailInput.value = 'user@example.com';
      console.log("\nSet email to:", emailInput.value);
    }
  </script>
</body>
</html>
```

**What you'll see:**
```
Inputs named 'username': 2
  - Username : (empty)
  - Username (duplicate) : (empty)
Set email to: user@example.com
```

```warn header="getElementsByName works on the entire document"
Unlike other methods, `getElementsByName` always searches the entire document, even if you call it on a specific element:

```html run
<!DOCTYPE html>
<html>
<body>
  <div id="container">
    <input name="test" value="Inside container">
  </div>
  <input name="test" value="Outside container">

  <script>
    let container = document.getElementById('container');
    
    // Even though we call it on container, it searches the whole document
    let inputs = container.getElementsByName('test');
    console.log("Found inputs:", inputs.length); // 2, not 1!
    
    // Compare with getElementsByTagName
    let divs = container.getElementsByTagName('div');
    console.log("Divs in container:", divs.length); // 0 (searches only inside)
  </script>
</body>
</html>
```

This is a quirk of `getElementsByName`—it always searches the entire document.
```

## The Modern Way: querySelector and querySelectorAll

These methods use CSS selectors, which are much more powerful and flexible. They're the preferred way to search for elements in modern JavaScript.

### Finding One Element: `querySelector`

This method finds the **first** element that matches a CSS selector.

**Syntax:** `document.querySelector(selector)` or `element.querySelector(selector)`

**Returns:** The first matching element, or `null` if none found.

```html run
<!DOCTYPE html>
<html>
<body>
  <div class="item">First item</div>
  <div class="item">Second item</div>
  <div id="special" class="item">Special item</div>
  <p class="item">Paragraph item</p>

  <script>
    // Find first element with class "item"
    let first = document.querySelector('.item');
    console.log("First .item:", first.textContent);
    first.style.color = 'red';
    
    // Find element with ID "special"
    let special = document.querySelector('#special');
    console.log("Special element:", special.textContent);
    special.style.fontWeight = 'bold';
    
    // Find first div with class "item"
    let firstDiv = document.querySelector('div.item');
    console.log("First div.item:", firstDiv.textContent);
    
    // Complex selector: find first paragraph with class "item"
    let para = document.querySelector('p.item');
    console.log("First p.item:", para.textContent);
    
    // What if nothing matches?
    let missing = document.querySelector('.nonexistent');
    console.log("Missing element:", missing); // null
  </script>
</body>
</html>
```

**What you'll see:**
```
First .item: First item
Special element: Special item
First div.item: First item
First p.item: Paragraph item
Missing element: null
```

### Finding Multiple Elements: `querySelectorAll`

This method finds **all** elements that match a CSS selector.

**Syntax:** `document.querySelectorAll(selector)` or `element.querySelectorAll(selector)`

**Returns:** A **NodeList** (not a live collection, but a static snapshot).

```html run
<!DOCTYPE html>
<html>
<body>
  <div class="item">Item 1</div>
  <div class="item highlight">Item 2</div>
  <div class="item">Item 3</div>
  <p class="item">Item 4</p>
  <div class="other">Other</div>

  <script>
    // Find all elements with class "item"
    let items = document.querySelectorAll('.item');
    console.log("All .item elements:", items.length);
    
    items.forEach((item, index) => {
      console.log(`  [${index}]`, item.tagName, ":", item.textContent);
      item.style.border = '1px solid blue';
    });
    
    // Find all divs with class "item"
    let divItems = document.querySelectorAll('div.item');
    console.log("\nDiv items:", divItems.length);
    
    // Complex selector: find divs with both classes
    let highlighted = document.querySelectorAll('div.item.highlight');
    console.log("Highlighted divs:", highlighted.length);
    highlighted[0].style.backgroundColor = 'yellow';
  </script>
</body>
</html>
```

**What you'll see:**
```
All .item elements: 4
  [0] DIV : Item 1
  [1] DIV : Item 2
  [2] DIV : Item 3
  [3] P : Item 4
Div items: 3
Highlighted divs: 1
```

```smart header="querySelectorAll returns a NodeList, not an HTMLCollection"
The difference:
- `getElementsByTagName` / `getElementsByClassName` return an **HTMLCollection** (live)
- `querySelectorAll` returns a **NodeList** (static snapshot)

```html run
<!DOCTYPE html>
<html>
<body>
  <div class="item">Item 1</div>

  <script>
    // HTMLCollection (live)
    let items1 = document.getElementsByClassName('item');
    console.log("Initial HTMLCollection length:", items1.length); // 1
    
    // NodeList (static)
    let items2 = document.querySelectorAll('.item');
    console.log("Initial NodeList length:", items2.length); // 1
    
    // Add a new element
    let newDiv = document.createElement('div');
    newDiv.className = 'item';
    newDiv.textContent = 'Item 2';
    document.body.appendChild(newDiv);
    
    // HTMLCollection updated automatically
    console.log("HTMLCollection after add:", items1.length); // 2
    
    // NodeList did NOT update
    console.log("NodeList after add:", items2.length); // 1 (still!)
    
    // Need to call querySelectorAll again to get updated list
    items2 = document.querySelectorAll('.item');
    console.log("New NodeList length:", items2.length); // 2
  </script>
</body>
</html>
```

**What you'll see:**
```
Initial HTMLCollection length: 1
Initial NodeList length: 1
HTMLCollection after add: 2
NodeList after add: 1
New NodeList length: 2
```

In practice, this usually doesn't matter much, but it's good to know the difference.
```

### CSS Selectors You Can Use

`querySelector` and `querySelectorAll` support all CSS selectors. Here are the most common ones:

```html run
<!DOCTYPE html>
<html>
<body>
  <div id="container">
    <h1 class="title">Main Title</h1>
    <p class="intro">Introduction paragraph</p>
    <div class="content">
      <p>First paragraph</p>
      <p class="highlight">Highlighted paragraph</p>
      <p>Last paragraph</p>
    </div>
    <ul>
      <li>Item 1</li>
      <li class="special">Item 2</li>
      <li>Item 3</li>
    </ul>
  </div>

  <script>
    // Class selector
    let title = document.querySelector('.title');
    title.style.color = 'blue';
    
    // ID selector
    let container = document.querySelector('#container');
    container.style.border = '2px solid black';
    
    // Tag selector
    let paragraphs = document.querySelectorAll('p');
    console.log("Total paragraphs:", paragraphs.length);
    
    // Descendant selector (space)
    let contentParas = document.querySelectorAll('.content p');
    console.log("Paragraphs in .content:", contentParas.length);
    
    // Child selector (>)
    let directChildren = document.querySelectorAll('#container > p');
    console.log("Direct p children of #container:", directChildren.length);
    
    // Multiple selectors (comma)
    let headingsAndParas = document.querySelectorAll('h1, p');
    console.log("All h1 and p elements:", headingsAndParas.length);
    
    // Attribute selector
    let specialLi = document.querySelector('li.special');
    specialLi.style.fontWeight = 'bold';
    
    // :first-child pseudo-class
    let firstPara = document.querySelector('.content p:first-child');
    firstPara.style.backgroundColor = 'lightgreen';
    
    // :last-child pseudo-class
    let lastPara = document.querySelector('.content p:last-child');
    lastPara.style.backgroundColor = 'lightcoral';
    
    // :nth-child pseudo-class
    let secondLi = document.querySelector('li:nth-child(2)');
    secondLi.style.color = 'red';
  </script>
</body>
</html>
```

**What you'll see:**
```
Total paragraphs: 4
Paragraphs in .content: 3
Direct p children of #container: 1
All h1 and p elements: 5
```

```smart header="Common CSS selectors"
Here's a quick reference of useful selectors:

- `.class` - Elements with class "class"
- `#id` - Element with ID "id"
- `tag` - All elements with tag name "tag"
- `.class1.class2` - Elements with both classes
- `parent child` - Descendant selector (any level)
- `parent > child` - Direct child selector
- `selector1, selector2` - Multiple selectors (OR)
- `[attribute]` - Elements with attribute
- `[attribute="value"]` - Elements with attribute equals value
- `:first-child` - First child element
- `:last-child` - Last child element
- `:nth-child(n)` - Nth child element
- `:not(selector)` - Elements that don't match selector

For a complete list, see [MDN CSS Selectors](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors).
```

## Checking if an Element Matches: `matches`

Sometimes you want to check if an element matches a selector, rather than searching for it.

**Syntax:** `element.matches(selector)`

**Returns:** `true` if the element matches, `false` otherwise.

```html run
<!DOCTYPE html>
<html>
<body>
  <div class="item highlight">Item 1</div>
  <div class="item">Item 2</div>
  <p class="item">Item 3</p>
  <div class="other">Other</div>

  <script>
    let elements = document.querySelectorAll('div, p');
    
    elements.forEach(elem => {
      // Check if element matches a selector
      if (elem.matches('.item')) {
        console.log("Matches .item:", elem.textContent);
        elem.style.border = '2px solid blue';
      }
      
      if (elem.matches('.item.highlight')) {
        console.log("Matches .item.highlight:", elem.textContent);
        elem.style.backgroundColor = 'yellow';
      }
      
      if (elem.matches('div.item')) {
        console.log("Matches div.item:", elem.textContent);
      }
    });
  </script>
</body>
</html>
```

**What you'll see:**
```
Matches .item: Item 1
Matches .item.highlight: Item 1
Matches div.item: Item 1
Matches .item: Item 2
Matches div.item: Item 2
Matches .item: Item 3
```

This is useful when you're looping through elements and want to filter them based on a selector.

## Finding the Closest Ancestor: `closest`

This method finds the nearest ancestor (including the element itself) that matches a selector.

**Syntax:** `element.closest(selector)`

**Returns:** The closest matching ancestor, or `null` if none found.

```html run
<!DOCTYPE html>
<html>
<body>
  <div class="container">
    <div class="section">
      <div class="item">
        <span class="text">Click me!</span>
      </div>
    </div>
  </div>

  <script>
    let text = document.querySelector('.text');
    
    // Find closest ancestor with class "item"
    let item = text.closest('.item');
    console.log("Closest .item:", item.className);
    item.style.border = '2px solid red';
    
    // Find closest ancestor with class "section"
    let section = text.closest('.section');
    console.log("Closest .section:", section.className);
    section.style.backgroundColor = 'lightblue';
    
    // Find closest ancestor with class "container"
    let container = text.closest('.container');
    console.log("Closest .container:", container.className);
    
    // The element itself can match
    let textMatch = text.closest('.text');
    console.log("Closest .text:", textMatch === text); // true
    
    // If nothing matches, returns null
    let missing = text.closest('.nonexistent');
    console.log("Closest .nonexistent:", missing); // null
  </script>
</body>
</html>
```

**What you'll see:**
```
Closest .item: item
Closest .section: section
Closest .container: container
Closest .text: true
Closest .nonexistent: null
```

This is especially useful for event handling—when you click on an element, you can find which parent container it belongs to:

```html run
<!DOCTYPE html>
<html>
<body>
  <ul class="menu">
    <li class="item">
      <a href="#" class="link">Home</a>
    </li>
    <li class="item">
      <a href="#" class="link">About</a>
    </li>
    <li class="item">
      <a href="#" class="link">Contact</a>
    </li>
  </ul>

  <script>
    // Add click handlers to all links
    document.querySelectorAll('.link').forEach(link => {
      link.addEventListener('click', function(e) {
        e.preventDefault();
        
        // Find which menu item was clicked
        let menuItem = this.closest('.item');
        console.log("Clicked menu item:", menuItem.textContent.trim());
        
        // Highlight the menu item
        document.querySelectorAll('.item').forEach(item => {
          item.style.backgroundColor = '';
        });
        menuItem.style.backgroundColor = 'yellow';
      });
    });
  </script>
</body>
</html>
```

## Searching Within an Element

All search methods (except `getElementsByName`) can be called on any element to search only within that element's subtree:

```html run
<!DOCTYPE html>
<html>
<body>
  <div id="container">
    <div class="item">Item 1</div>
    <div class="item">Item 2</div>
    <p class="item">Item 3</p>
  </div>
  
  <div class="item">Item 4 (outside)</div>

  <script>
    let container = document.getElementById('container');
    
    // Search only within container
    let itemsInContainer = container.querySelectorAll('.item');
    console.log("Items in container:", itemsInContainer.length); // 3
    
    // Search entire document
    let allItems = document.querySelectorAll('.item');
    console.log("All items:", allItems.length); // 4
    
    // Get all divs within container
    let divsInContainer = container.getElementsByTagName('div');
    console.log("Divs in container:", divsInContainer.length); // 2 (not counting container itself)
  </script>
</body>
</html>
```

**What you'll see:**
```
Items in container: 3
All items: 4
Divs in container: 2
```

This is very useful when you want to limit your search to a specific part of the page.

## Performance Considerations

Different search methods have different performance characteristics:

1. **`getElementById`** - Fastest (browsers optimize this heavily)
2. **`getElementsByTagName`** / **`getElementsByClassName`** - Fast (browsers optimize these)
3. **`querySelector`** / **`querySelectorAll`** - Can be slower for complex selectors, but usually fine

```smart header="When to use which method?"
- **Use `getElementById`** when searching by ID (fastest)
- **Use `querySelector`/`querySelectorAll`** for most other cases (most flexible)
- **Use `getElementsByTagName`/`getElementsByClassName`** when you need a live collection that updates automatically

In practice, the performance difference is usually negligible unless you're searching thousands of times. Use whatever is clearest for your code.
```

## Common Pitfalls

### 1. Forgetting to Check for null

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // BAD - will crash if element doesn't exist
    // document.getElementById('missing').style.color = 'red';
    
    // GOOD - check first
    let elem = document.getElementById('missing');
    if (elem) {
      elem.style.color = 'red';
    }
    
    // ALSO GOOD - use optional chaining
    document.getElementById('missing')?.style.color = 'red';
  </script>
</body>
</html>
```

### 2. Confusing Single Element vs Collection

```html run
<!DOCTYPE html>
<html>
<body>
  <div class="item">Item</div>

  <script>
    // getElementById returns a single element (or null)
    let byId = document.getElementById('item'); // null if doesn't exist
    // byId.style.color = 'red'; // Works if element exists
    
    // getElementsByClassName returns a collection (even if one element)
    let byClass = document.getElementsByClassName('item');
    // byClass.style.color = 'red'; // ERROR! Collections don't have style
    byClass[0].style.color = 'red'; // Correct - access first element
    
    // querySelector returns a single element (or null)
    let byQuery = document.querySelector('.item');
    byQuery.style.color = 'blue'; // Works
    
    // querySelectorAll returns a NodeList (collection)
    let byQueryAll = document.querySelectorAll('.item');
    // byQueryAll.style.color = 'green'; // ERROR!
    byQueryAll[0].style.color = 'green'; // Correct
  </script>
</body>
</html>
```

### 3. Using Array Methods on Collections

```html run
<!DOCTYPE html>
<html>
<body>
  <div class="item">Item 1</div>
  <div class="item">Item 2</div>
  <div class="item">Item 3</div>

  <script>
    // HTMLCollection doesn't have forEach (in older browsers)
    let items1 = document.getElementsByClassName('item');
    // items1.forEach(...) // Might not work in older browsers
    
    // Convert to array first
    let itemsArray = Array.from(items1);
    itemsArray.forEach(item => {
      item.style.border = '1px solid blue';
    });
    
    // NodeList from querySelectorAll has forEach (in modern browsers)
    let items2 = document.querySelectorAll('.item');
    items2.forEach(item => {
      item.style.backgroundColor = 'lightyellow';
    });
    
    // Or use for...of (works on both)
    for (let item of items1) {
      item.style.padding = '10px';
    }
  </script>
</body>
</html>
```

## Summary

Here's a quick reference of all the search methods:

### Old Methods (Still Useful)
- **`getElementById(id)`** - Find by ID, returns element or `null`
- **`getElementsByTagName(tag)`** - Find by tag name, returns live HTMLCollection
- **`getElementsByClassName(className)`** - Find by class, returns live HTMLCollection
- **`getElementsByName(name)`** - Find by name attribute, returns live HTMLCollection

### Modern Methods (Recommended)
- **`querySelector(selector)`** - Find first match using CSS selector, returns element or `null`
- **`querySelectorAll(selector)`** - Find all matches using CSS selector, returns static NodeList

### Utility Methods
- **`matches(selector)`** - Check if element matches selector, returns boolean
- **`closest(selector)`** - Find closest ancestor matching selector, returns element or `null`

### Key Differences
- **Single vs Multiple:** `getElementById`, `querySelector` return one element; others return collections
- **Live vs Static:** `getElementsBy*` return live collections; `querySelectorAll` returns static NodeList
- **Flexibility:** `querySelector`/`querySelectorAll` support all CSS selectors; others are limited

### Best Practices
1. Always check for `null` when using methods that return a single element
2. Use `querySelector`/`querySelectorAll` for most cases (most flexible)
3. Use `getElementById` for ID searches (fastest)
4. Convert collections to arrays if you need array methods
5. Use `for...of` to loop through collections (works everywhere)

Now you know how to find any element on the page! In the next chapter, we'll learn how to modify elements once you've found them.

