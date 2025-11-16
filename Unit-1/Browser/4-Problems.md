# DOM Searching Practice Problems

## Problem 1: Find and Style Elements by ID
Create an HTML page with these elements:
- A `<div>` with `id="header"` containing text "Welcome"
- A `<div>` with `id="content"` containing text "Main content"
- A `<div>` with `id="footer"` containing text "Footer"

Write JavaScript code to:
1. Find the header element by ID
2. Change its text color to blue
3. Change its font size to 24px
4. Find the footer element by ID
5. Change its background color to lightgray
6. Log both elements to the console

**Expected console output:**
```
<div id="header">Welcome</div>
<div id="footer">Footer</div>
```

**Hint:** Use `getElementById()` and remember to check if elements exist!

---

## Problem 2: Find All Elements by Tag Name
Create an HTML page with:
- 3 `<p>` elements with different text
- 2 `<div>` elements with different text
- 1 `<span>` element

Write JavaScript code to:
1. Find all paragraph elements using `getElementsByTagName`
2. Loop through them and add a blue border to each
3. Find all div elements
4. Loop through them and change their background color to lightyellow
5. Count and log how many of each type you found

**Expected console output:**
```
Found 3 paragraphs
Found 2 divs
```

**Hint:** Remember that `getElementsByTagName` returns a collection, not an array!

---

## Problem 3: Search by Class Name
Create an HTML page with:
- 4 `<div>` elements with class "item"
- 2 of those divs should also have class "highlight"
- 1 `<p>` element with class "item"

Write JavaScript code to:
1. Find all elements with class "item" using `getElementsByClassName`
2. Add a border to all of them
3. Find elements with both "item" AND "highlight" classes
4. Change the background color of those to yellow
5. Log how many items you found in each case

**Expected console output:**
```
Total items: 5
Highlighted items: 2
```

**Hint:** To search for multiple classes, separate them with spaces: `'item highlight'`

---

## Problem 4: Using querySelector and querySelectorAll
Create an HTML page with this structure:
```html
<div id="container">
  <h1 class="title">Main Title</h1>
  <p class="intro">Introduction text</p>
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
```

Write JavaScript code to:
1. Find the first element with class "title" using `querySelector`
2. Change its color to blue
3. Find all paragraphs inside `.content` using `querySelectorAll`
4. Add a border to each of those paragraphs
5. Find the `<li>` with class "special" using `querySelector`
6. Make it bold and change its color to red
7. Find all `<li>` elements using `querySelectorAll` and log the count

**Expected console output:**
```
Paragraphs in content: 3
Total list items: 3
```

**Hint:** Use CSS selectors like `.content p` for descendant selectors!

---

## Problem 5: Using matches and closest
Create an HTML page with this structure:
```html
<div class="card">
  <div class="header">
    <h2 class="title">Card Title</h2>
  </div>
  <div class="body">
    <p class="text">Some text content</p>
    <button class="btn">Click me</button>
  </div>
</div>

<div class="card highlight">
  <div class="header">
    <h2 class="title">Another Card</h2>
  </div>
  <div class="body">
    <p class="text">More content</p>
    <button class="btn">Click me too</button>
  </div>
</div>
```

Write JavaScript code to:
1. Find all buttons using `querySelectorAll`
2. For each button, check if it matches the selector `.btn` using `matches()`
3. If it matches, find its closest ancestor with class "card" using `closest()`
4. Add a border to that card
5. Check if the card also has class "highlight"
6. If it does, change the card's background color to lightyellow
7. Log which card each button belongs to

**Expected console output:**
```
Button 1 belongs to card: card
Button 2 belongs to card: card highlight
```

**Hint:** Use `closest('.card')` to find the parent card, then check if it matches `.card.highlight`!

---

## Bonus Challenge 🌟
Create a dynamic search page with:
- An input field with `id="searchInput"`
- A button with `id="searchBtn"`
- A container `<div id="results">` with 10 `<div class="item">` elements, each containing different text

When the button is clicked:
1. Get the search text from the input field
2. Find all elements with class "item"
3. Loop through them and check if their text content includes the search text (case-insensitive)
4. If it matches, highlight it (change background to yellow)
5. If it doesn't match, hide it (set `display: none`)
6. If the search is empty, show all items again

**Extra challenge:** Also log how many items matched the search.

**Hint:** Use `textContent` to get the text, `includes()` to check if text contains the search term, and `toLowerCase()` for case-insensitive matching!

