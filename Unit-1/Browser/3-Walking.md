# Navigating the DOM Tree

Now that you understand what the DOM is, you need to know how to move around it. Think of the DOM like a family tree—you can go up to parents, down to children, and sideways to siblings.

All navigation starts with the `document` object. It's your starting point—from there, you can reach any element on the page.

Here's a visual guide to how you can move between DOM nodes:

![](dom-links.svg)

Let's learn how to use these navigation tools!

## Starting Points: documentElement, body, and head

The most important elements are so commonly used that they have shortcuts on the `document` object:

**`document.documentElement`** = the `<html>` element
: This is the root element of your entire HTML document.

**`document.body`** = the `<body>` element
: This is the main content area of your page—where most of your HTML lives.

**`document.head`** = the `<head>` element
: This contains metadata, styles, and scripts that aren't displayed on the page.

```warn header="Watch out: `document.body` might not exist yet!"
If you try to access an element before the browser has read it, you'll get `null`.

For example, if you put a script inside the `<head>` section, `document.body` will be `null` because the browser hasn't read the `<body>` tag yet:

```html run
<!DOCTYPE html>
<html>
<head>
  <title>Example</title>
  <script>
    // This runs BEFORE the browser reads <body>
    console.log("From HEAD:");
    console.log(document.body); // null - body doesn't exist yet!
    
    if (document.body === null) {
      console.log("The body element hasn't been created yet!");
    }
  </script>
</head>

<body>
  <h1>Hello World</h1>
  
  <script>
    // This runs AFTER the browser reads <body>
    console.log("From BODY:");
    console.log(document.body); // <body> element - now it exists!
    console.log(document.body.tagName); // "BODY"
  </script>
</body>
</html>
```

**What you'll see in the console:**
```
From HEAD:
null
The body element hasn't been created yet!
From BODY:
<body>...</body>
BODY
```

Always make sure elements exist before you try to use them!
```

```smart header="`null` means \"doesn't exist\""
In the DOM, when you get `null`, it means that element doesn't exist (yet). This is different from getting an empty element or an error.
```

## Moving Down: Children

Before we dive in, let's clarify two important terms:

- **Children** (or child nodes) - Direct children only. Elements that are nested directly inside another element. For example, `<head>` and `<body>` are children of `<html>`.
- **Descendants** - All nested elements, no matter how deep. This includes children, their children, their children's children, and so on.

Here's an example:

```html run
<html>
<body>
  <div>Begin</div>

  <ul>
    <li>
      <b>Information</b>
    </li>
  </ul>
</body>
</html>
```

In this example:
- The **children** of `<body>` are: `<div>` and `<ul>` (plus some text nodes for spaces)
- The **descendants** of `<body>` include: `<div>`, `<ul>`, `<li>`, and `<b>` (the entire family tree)

### Getting All Children: `childNodes`

The `childNodes` property gives you a list of all direct children, including text nodes and comment nodes.

```html run
<!DOCTYPE html>
<html>
<body>
  <div>First div</div>

  <ul>
    <li>List item</li>
  </ul>

  <div>Second div</div>

  <script>
    console.log("Total children of body:", document.body.childNodes.length);
    console.log("\nAll children (including text nodes):");
    
    for (let i = 0; i < document.body.childNodes.length; i++) {
      let node = document.body.childNodes[i];
      let nodeType = node.nodeType;
      let nodeName = node.nodeName;
      
      // nodeType 1 = element, nodeType 3 = text
      if (nodeType === 1) {
        console.log(`  [${i}] Element: <${nodeName}>`);
      } else if (nodeType === 3) {
        // Show text content (trimmed for readability)
        let text = node.textContent.trim();
        console.log(`  [${i}] Text node: "${text || '(whitespace)'}"`);
      }
    }
  </script>
  
  <p>This paragraph won't be in childNodes when the script runs!</p>
</body>
</html>
```

**What you'll see in the console:**
```
Total children of body: 7

All children (including text nodes):
  [0] Text node: "(whitespace)"
  [1] Element: <DIV>
  [2] Text node: "(whitespace)"
  [3] Element: <UL>
  [4] Text node: "(whitespace)"
  [5] Element: <DIV>
  [6] Text node: "(whitespace)"
  [7] Element: <SCRIPT>
```

**Important note:** Notice that the `<p>` tag at the end isn't in the list! That's because when the script runs, the browser hasn't read that part of the HTML yet. The script only sees what came before it.

### Quick Access: `firstChild` and `lastChild`

Instead of using `childNodes[0]` and `childNodes[childNodes.length - 1]`, you can use shortcuts:

- `firstChild` - The first child node
- `lastChild` - The last child node

These are just convenient shortcuts. Here's a practical example:

```html run
<!DOCTYPE html>
<html>
<body>
  <div id="container">
    <p>First paragraph</p>
    <p>Second paragraph</p>
    <p>Last paragraph</p>
  </div>

  <script>
    let container = document.getElementById('container');
    
    // These two are the same:
    console.log("First child (using index):", container.childNodes[0]);
    console.log("First child (using property):", container.firstChild);
    console.log("Are they equal?", container.childNodes[0] === container.firstChild);
    
    // These two are also the same:
    let lastIndex = container.childNodes.length - 1;
    console.log("\nLast child (using index):", container.childNodes[lastIndex]);
    console.log("Last child (using property):", container.lastChild);
    console.log("Are they equal?", container.childNodes[lastIndex] === container.lastChild);
    
    // Check if element has children
    console.log("\nDoes container have children?", container.hasChildNodes());
    console.log("Number of children:", container.childNodes.length);
  </script>
</body>
</html>
```

**What you'll see:**
```
First child (using index): #text
First child (using property): #text
Are they equal? true

Last child (using index): #text
Last child (using property): #text
Are they equal? true

Does container have children? true
Number of children: 7
```

### Understanding DOM Collections

`childNodes` looks like an array, but it's actually a special **collection** object. This means:

**Good news:** You can loop through it with `for..of`:
```html run
<!DOCTYPE html>
<html>
<body>
  <div>First</div>
  <p>Second</p>
  <span>Third</span>

  <script>
    console.log("Looping through childNodes:");
    for (let node of document.body.childNodes) {
      if (node.nodeType === 1) { // Only show element nodes
        console.log("  Found element:", node.tagName);
      }
    }
  </script>
</body>
</html>
```

**Important limitation:** You can't use array methods like `filter()`, `map()`, etc. directly:
```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Try to use filter - it doesn't exist!
    console.log("Does filter exist?", typeof document.body.childNodes.filter);
    // Output: undefined
    
    // This would cause an error:
    // document.body.childNodes.filter(...) // TypeError!
  </script>
</body>
</html>
```

**Solution:** Convert it to a real array if you need array methods:
```html run
<!DOCTYPE html>
<html>
<body>
  <div>Apple</div>
  <p>Banana</p>
  <div>Cherry</div>

  <script>
    // Convert to array
    let childrenArray = Array.from(document.body.childNodes);
    
    // Now we can use array methods!
    console.log("Is filter available now?", typeof childrenArray.filter);
    // Output: function
    
    // Filter to get only DIV elements
    let divs = childrenArray.filter(node => 
      node.nodeType === 1 && node.tagName === 'DIV'
    );
    
    console.log("Found DIV elements:", divs.length);
    divs.forEach(div => console.log("  -", div.textContent));
  </script>
</body>
</html>
```

**What you'll see:**
```
Is filter available now? function
Found DIV elements: 2
  - Apple
  - Cherry
```

```warn header="DOM collections are read-only"
You can't modify the DOM by assigning to collection properties. For example, this won't work:
```html run
<!DOCTYPE html>
<html>
<body>
  <div id="old">Old content</div>
  <p>Another element</p>

  <script>
    let body = document.body;
    let newDiv = document.createElement('div');
    newDiv.textContent = "New content";
    
    // This WON'T work - collections are read-only!
    body.childNodes[1] = newDiv;
    
    console.log("Did it change?");
    console.log("First child is still:", body.childNodes[1].textContent);
    // Still shows "Old content" - the assignment was ignored!
    
    // To actually change the DOM, you need special methods
    // (which we'll cover in the next chapter)
  </script>
</body>
</html>
```

To actually change the DOM, you need special methods (which we'll cover in the next chapter).
```

```warn header="DOM collections are \"live\""
DOM collections automatically update when the DOM changes. If you keep a reference to `elem.childNodes` and then add or remove nodes, the collection will automatically reflect those changes.
```

```warn header="Don't use `for..in` with collections"
Use `for..of` to loop through collections, not `for..in`.

The `for..in` loop will give you extra properties you don't want:
```html run
<!DOCTYPE html>
<html>
<body>
  <div>Item 1</div>
  <div>Item 2</div>
  <div>Item 3</div>

  <script>
    console.log("Using for..in (WRONG - shows unwanted properties):");
    for (let prop in document.body.childNodes) {
      console.log("  Property:", prop);
    }
    
    console.log("\nUsing for..of (CORRECT - shows only nodes):");
    for (let node of document.body.childNodes) {
      if (node.nodeType === 1) {
        console.log("  Element:", node.tagName);
      }
    }
  </script>
</body>
</html>
```

**What you'll see:**
```
Using for..in (WRONG - shows unwanted properties):
  Property: 0
  Property: 1
  Property: 2
  Property: 3
  Property: length
  Property: item
  Property: values
  ...and more unwanted stuff

Using for..of (CORRECT - shows only nodes):
  Element: DIV
  Element: DIV
  Element: DIV
```

Stick with `for..of`!
```

## Moving Sideways: Siblings

**Siblings** are nodes that share the same parent. Think of them as brothers and sisters in the family tree.

For example, `<head>` and `<body>` are siblings because they're both children of `<html>`:

```html
<html>
  <head>...</head><body>...</body>
</html>
```

- `<body>` is the **next** (or "right") sibling of `<head>`
- `<head>` is the **previous** (or "left") sibling of `<body>`

### Sibling Properties

- `nextSibling` - The next sibling node
- `previousSibling` - The previous sibling node
- `parentNode` - The parent node

Here are some examples:

```html run
<!DOCTYPE html>
<html>
<head>
  <title>Example</title>
</head>
<body>
  <div id="first">First div</div>
  <p id="middle">Middle paragraph</p>
  <div id="last">Last div</div>

  <script>
    // Get parent of body (should be <html>)
    console.log("Parent of <body>:");
    console.log("  Tag name:", document.body.parentNode.tagName);
    console.log("  Is it <html>?", document.body.parentNode === document.documentElement);
    
    // Get siblings of <head>
    console.log("\nSiblings of <head>:");
    console.log("  Next sibling:", document.head.nextSibling);
    console.log("  Next sibling tag:", document.head.nextSibling?.tagName || "text node");
    
    // Get siblings of <body>
    console.log("\nSiblings of <body>:");
    console.log("  Previous sibling:", document.body.previousSibling);
    console.log("  Previous sibling tag:", document.body.previousSibling?.tagName || "text node");
    
    // Get siblings of a specific element
    let middle = document.getElementById('middle');
    console.log("\nSiblings of middle paragraph:");
    console.log("  Previous:", middle.previousSibling);
    console.log("  Next:", middle.nextSibling);
  </script>
</body>
</html>
```

**What you'll see:**
```
Parent of <body>:
  Tag name: HTML
  Is it <html>? true

Siblings of <head>:
  Next sibling: #text
  Next sibling tag: text node

Siblings of <body>:
  Previous sibling: #text
  Previous sibling tag: text node

Siblings of middle paragraph:
  Previous: #text
  Next: #text
```

(Note: The siblings are text nodes because of whitespace between elements!)

## Moving Up: Parents

To get the parent of any element, use `parentNode`:

```html run
<!DOCTYPE html>
<html>
<body>
  <div id="outer">
    <div id="middle">
      <p id="inner">This is a paragraph</p>
    </div>
  </div>

  <script>
    let paragraph = document.getElementById('inner');
    
    console.log("The paragraph element:", paragraph.textContent);
    console.log("\nMoving up the tree:");
    
    // Get immediate parent
    let parent1 = paragraph.parentNode;
    console.log("  Parent:", parent1.id, "(" + parent1.tagName + ")");
    
    // Get parent's parent
    let parent2 = parent1.parentNode;
    console.log("  Parent's parent:", parent2.id, "(" + parent2.tagName + ")");
    
    // Get parent's parent's parent
    let parent3 = parent2.parentNode;
    console.log("  Parent's parent's parent:", parent3.tagName);
  </script>
</body>
</html>
```

**What you'll see:**
```
The paragraph element: This is a paragraph

Moving up the tree:
  Parent: middle (DIV)
  Parent's parent: outer (DIV)
  Parent's parent's parent: BODY
```

## Element-Only Navigation

So far, all the properties we've seen (`childNodes`, `nextSibling`, etc.) include **all** types of nodes: elements, text nodes, and comment nodes.

But often, you only care about **element nodes** (the actual HTML tags). For those cases, there are special properties that skip text and comment nodes:

![](dom-links-elements.svg)

These properties work the same way, but they only look at element nodes:

- `children` - Only element children (skips text/comment nodes)
- `firstElementChild` - First element child
- `lastElementChild` - Last element child
- `previousElementSibling` - Previous element sibling
- `nextElementSibling` - Next element sibling
- `parentElement` - Parent element

Here's the difference: if you use `childNodes`, you'll see text nodes between elements. But if you use `children`, you'll only see the actual HTML elements:

```html run
<!DOCTYPE html>
<html>
<body>
  <div>First div</div>

  <ul>
    <li>List item</li>
  </ul>

  <div>Second div</div>

  <script>
    console.log("Using childNodes (includes text nodes):");
    let count = 0;
    for (let node of document.body.childNodes) {
      if (node.nodeType === 1) {
        console.log(`  [${count}] Element: ${node.tagName}`);
      } else {
        console.log(`  [${count}] Text node (whitespace)`);
      }
      count++;
    }
    
    console.log("\nUsing children (only elements):");
    count = 0;
    for (let elem of document.body.children) {
      console.log(`  [${count}] ${elem.tagName}`);
      count++;
    }
    
    console.log("\nComparison:");
    console.log("  childNodes.length:", document.body.childNodes.length);
    console.log("  children.length:", document.body.children.length);
  </script>
</body>
</html>
```

**What you'll see:**
```
Using childNodes (includes text nodes):
  [0] Text node (whitespace)
  [1] Element: DIV
  [2] Text node (whitespace)
  [3] Element: UL
  [4] Text node (whitespace)
  [5] Element: DIV
  [6] Text node (whitespace)
  [7] Element: SCRIPT

Using children (only elements):
  [0] DIV
  [1] UL
  [2] DIV
  [3] SCRIPT

Comparison:
  childNodes.length: 8
  children.length: 4
```

See the difference? `children` skips all the text nodes and only shows the actual HTML elements!

```smart header="Why both `parentNode` and `parentElement`?"
Both `parentNode` and `parentElement` usually return the same thing. The difference is:

- `parentNode` returns any type of parent node
- `parentElement` returns only element parents (returns `null` if the parent isn't an element)

There's one special case: the `<html>` element's parent is `document` (which isn't an element):

```html run
<!DOCTYPE html>
<html>
<body>
  <div id="example">Example div</div>

  <script>
    let html = document.documentElement;
    
    console.log("Parent of <html> element:");
    console.log("  parentNode:", html.parentNode);
    console.log("  parentNode type:", html.parentNode.constructor.name);
    console.log("  parentElement:", html.parentElement);
    
    console.log("\nWhy the difference?");
    console.log("  parentNode returns 'document' (any node type)");
    console.log("  parentElement returns null (because document isn't an element)");
    
    // This is useful when you want to travel up but stop at <html>
    console.log("\nTraveling up from a div:");
    let div = document.getElementById('example');
    let current = div;
    let path = [];
    
    while(current = current.parentElement) {
      path.push(current.tagName);
    }
    
    console.log("  Path:", path.join(" -> "));
    // Output: DIV -> BODY -> HTML
    // Notice it stops at HTML, doesn't go to document!
  </script>
</body>
</html>
```

**What you'll see:**
```
Parent of <html> element:
  parentNode: [object HTMLDocument]
  parentNode type: HTMLDocument
  parentElement: null

Why the difference?
  parentNode returns 'document' (any node type)
  parentElement returns null (because document isn't an element)

Traveling up from a div:
  Path: DIV -> BODY -> HTML
```
```

## Special Navigation: Tables

Some HTML elements have special navigation properties that make working with them easier. Tables are a great example.

### Table Properties

**For `<table>` elements:**
- `table.rows` - Collection of all `<tr>` (table row) elements
- `table.caption` - Reference to the `<caption>` element
- `table.tHead` - Reference to the `<thead>` element
- `table.tFoot` - Reference to the `<tfoot>` element
- `table.tBodies` - Collection of `<tbody>` elements (there's always at least one, even if you didn't write it in HTML)

**For `<thead>`, `<tfoot>`, `<tbody>` elements:**
- `tbody.rows` - Collection of `<tr>` elements inside

**For `<tr>` (table row) elements:**
- `tr.cells` - Collection of `<td>` and `<th>` cells in this row
- `tr.sectionRowIndex` - The row's position within its section (`<thead>`, `<tbody>`, or `<tfoot>`)
- `tr.rowIndex` - The row's position in the entire table

**For `<td>` and `<th>` (table cells):**
- `td.cellIndex` - The cell's position within its row

Here's a practical example showing how easy it is to work with tables:

```html run height=150
<!DOCTYPE html>
<html>
<body>
  <table id="table" border="1">
    <caption>My Table</caption>
    <thead>
      <tr>
        <th>Name</th>
        <th>Age</th>
        <th>City</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Alice</td>
        <td>25</td>
        <td>New York</td>
      </tr>
      <tr>
        <td>Bob</td>
        <td>30</td>
        <td>London</td>
      </tr>
      <tr>
        <td>Charlie</td>
        <td>35</td>
        <td>Tokyo</td>
      </tr>
    </tbody>
  </table>

  <script>
    let table = document.getElementById('table');
    
    console.log("Table properties:");
    console.log("  Total rows:", table.rows.length);
    console.log("  Caption:", table.caption?.textContent);
    console.log("  Header:", table.tHead ? "exists" : "none");
    console.log("  Bodies:", table.tBodies.length);
    
    // Get the cell with "Bob" (second row, first column)
    // rows[0] is the header row, so rows[1] is the first data row
    let cell = table.rows[1].cells[0];
    console.log("\nCell at row 1, column 0:", cell.textContent);
    
    // Highlight it
    cell.style.backgroundColor = "yellow";
    cell.style.fontWeight = "bold";
    
    // Get all cells in the second data row
    console.log("\nAll cells in row 2:");
    table.rows[2].cells.forEach((cell, index) => {
      console.log(`  Column ${index}: ${cell.textContent}`);
    });
    
    // Find a cell by content
    console.log("\nFinding cell with 'Tokyo':");
    for (let row of table.rows) {
      for (let cell of row.cells) {
        if (cell.textContent === "Tokyo") {
          console.log("  Found at row index:", row.rowIndex);
          console.log("  Cell index:", cell.cellIndex);
          cell.style.backgroundColor = "lightblue";
        }
      }
    }
  </script>
</body>
</html>
```

**What you'll see:**
```
Table properties:
  Total rows: 4
  Caption: My Table
  Header: exists
  Bodies: 1

Cell at row 1, column 0: Alice

All cells in row 2:
  Column 0: Bob
  Column 1: 30
  Column 2: London

Finding cell with 'Tokyo':
  Found at row index: 3
  Cell index: 2
```

This makes working with tables much easier than navigating through all the children manually! Instead of going through `childNodes` and checking each one, you can directly access rows and cells.

For more details, see the [HTML table specification](https://html.spec.whatwg.org/multipage/tables.html).

**Note:** Forms also have special navigation properties. We'll cover those when we learn about forms.

## Summary

Here's what you can use to navigate the DOM:

### For All Node Types (elements, text, comments):
- `parentNode` - Get the parent
- `childNodes` - Get all children (including text/comment nodes)
- `firstChild` - First child
- `lastChild` - Last child
- `previousSibling` - Previous sibling
- `nextSibling` - Next sibling

### For Element Nodes Only:
- `parentElement` - Get the parent element
- `children` - Get only element children
- `firstElementChild` - First element child
- `lastElementChild` - Last element child
- `previousElementSibling` - Previous element sibling
- `nextElementSibling` - Next element sibling

### Special Elements:
Some elements like tables have additional properties (`rows`, `cells`, etc.) that make navigation easier.

**Remember:**
- All navigation starts from `document`
- Collections are "live" - they update automatically when the DOM changes
- Collections are read-only - you can't modify the DOM by assigning to them
- Use `for..of` to loop through collections, not `for..in`
- Use element-only properties (`children`, `nextElementSibling`, etc.) when you only care about HTML elements

Now you know how to move around the DOM tree! In the next chapter, we'll learn how to actually modify elements once you find them.
