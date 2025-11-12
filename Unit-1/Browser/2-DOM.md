
# Understanding the DOM Tree

When you write HTML, you use tags like `<div>`, `<p>`, `<h1>`, etc. But when the browser reads your HTML, it doesn't just display it—it turns everything into objects that JavaScript can work with. This is called the **DOM** (Document Object Model).

Think of it this way: HTML is like a blueprint, and the DOM is the actual structure the browser builds from that blueprint.

## What is the DOM?

The DOM is a tree-like structure where:
- Every HTML tag becomes an **element node** (an object)
- The text inside tags becomes **text nodes** (also objects)
- Everything is connected in a parent-child relationship

For example, `document.body` is the JavaScript object that represents the `<body>` tag in your HTML.

Here's a simple example that changes the page background to red for 3 seconds:

```js run
document.body.style.background = 'red'; // make the background red

setTimeout(() => document.body.style.background = '', 3000); // change it back
```

This works because `document.body` is an object with properties you can change. There are many other properties like:
- `innerHTML` - the HTML content inside the element
- `offsetWidth` - the width of the element in pixels
- And many more!

But before we learn how to manipulate the DOM, let's understand how it's structured.

## A Simple Example

Let's look at a basic HTML document:

```html run no-beautify
<!DOCTYPE HTML>
<html>
<head>
  <title>About elk</title>
</head>
<body>
  The truth about elk.
</body>
</html>
```

The browser converts this into a tree structure. Here's how it looks:

<div class="domtree"></div>

<script>
let node1 = {"name":"HTML","nodeType":1,"children":[{"name":"HEAD","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"\n  "},{"name":"TITLE","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"About elk"}]},{"name":"#text","nodeType":3,"content":"\n"}]},{"name":"#text","nodeType":3,"content":"\n"},{"name":"BODY","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"\n  The truth about elk.\n"}]}]}

drawHtmlTree(node1, 'div.domtree', 690, 320);
</script>

```online
You can click on element nodes in the diagram above to expand or collapse them.
```

## Types of Nodes

### Element Nodes

HTML tags like `<html>`, `<head>`, `<body>`, `<title>` become **element nodes**. These form the structure of the tree:
- `<html>` is at the root (top)
- `<head>` and `<body>` are its children
- `<title>` is a child of `<head>`
- And so on...

### Text Nodes

The actual text content (like "About elk" or "The truth about elk.") becomes **text nodes**, labeled as `#text` in the DOM.

Text nodes:
- Contain only text (strings)
- Cannot have children
- Are always at the end of branches (leaves of the tree)

For example, the text "About elk" inside `<title>` becomes a text node that's a child of the `<title>` element node.

### Spaces and Newlines Matter

Spaces and line breaks in your HTML also become text nodes! This might seem strange, but it's important to understand.

In the example above, the spaces and newlines between tags create text nodes. For instance:
- A newline character: `↵` (in JavaScript, this is `\n`)
- A space character: `␣`

These are just as valid as letters and numbers—they're characters that become part of the DOM.

**Two exceptions:**
1. Spaces before `<head>` are ignored (for historical reasons)
2. Anything after `</body>` gets moved inside the body automatically

If you write HTML without spaces between tags, you won't have those space-only text nodes:

```html no-beautify
<!DOCTYPE HTML>
<html><head><title>About elk</title></head><body>The truth about elk.</body></html>
```

<div class="domtree"></div>

<script>
let node2 = {"name":"HTML","nodeType":1,"children":[{"name":"HEAD","nodeType":1,"children":[{"name":"TITLE","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"About elk"}]}]},{"name":"BODY","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"The truth about elk."}]}]}

drawHtmlTree(node2, 'div.domtree', 690, 210);
</script>

```smart header="Developer tools hide some details"
When you use browser developer tools (which we'll cover soon), they usually hide:
- Spaces at the start and end of text
- Empty text nodes (just line breaks between tags)

This saves screen space and makes things easier to read. Most of the time, these spaces don't affect how your page looks anyway.
```

## Browser Auto-Correction

Browsers are very forgiving! If your HTML has mistakes, the browser will automatically fix them when creating the DOM.

### Missing Required Tags

The browser always creates `<html>` and `<body>` tags, even if you don't write them.

For example, if your HTML file just contains the word "Hello", the browser will automatically wrap it:

<div class="domtree"></div>

<script>
let node3 = {"name":"HTML","nodeType":1,"children":[{"name":"HEAD","nodeType":1,"children":[]},{"name":"BODY","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"Hello"}]}]}

drawHtmlTree(node3, 'div.domtree', 690, 150);
</script>

### Unclosed Tags

If you forget to close tags, the browser will close them for you:

```html no-beautify
<p>Hello
<li>Mom
<li>and
<li>Dad
```

The browser fixes this and creates a proper DOM structure:

<div class="domtree"></div>

<script>
let node4 = {"name":"HTML","nodeType":1,"children":[{"name":"HEAD","nodeType":1,"children":[]},{"name":"BODY","nodeType":1,"children":[{"name":"P","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"Hello"}]},{"name":"LI","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"Mom"}]},{"name":"LI","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"and"}]},{"name":"LI","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"Dad"}]}]}]}

drawHtmlTree(node4, 'div.domtree', 690, 360);
</script>

```warn header="Tables always get a `<tbody>`"
Here's an interesting quirk: tables must have a `<tbody>` tag according to the DOM specification, but you don't have to write it in your HTML. The browser adds it automatically.

If you write:
```html no-beautify
<table id="table"><tr><td>1</td></tr></table>
```

The browser creates this DOM structure:
<div class="domtree"></div>

<script>
let node5 = {"name":"TABLE","nodeType":1,"children":[{"name":"TBODY","nodeType":1,"children":[{"name":"TR","nodeType":1,"children":[{"name":"TD","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"1"}]}]}]}]};

drawHtmlTree(node5,  'div.domtree', 600, 200);
</script>

Notice how `<tbody>` appeared automatically! Keep this in mind when working with tables.
```

## Other Node Types

Besides element nodes and text nodes, there are other types too.

### Comment Nodes

HTML comments also become nodes in the DOM:

```html
<!DOCTYPE HTML>
<html>
<body>
  The truth about elk.
  <ol>
    <li>An elk is a smart</li>
*!*
    <!-- comment -->
*/!*
    <li>...and cunning animal!</li>
  </ol>
</body>
</html>
```

<div class="domtree"></div>

<script>
let node6 = {"name":"HTML","nodeType":1,"children":[{"name":"HEAD","nodeType":1,"children":[]},{"name":"BODY","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"\n  The truth about elk.\n  "},{"name":"OL","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"\n    "},{"name":"LI","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"An elk is a smart"}]},{"name":"#text","nodeType":3,"content":"\n    "},{"name":"#comment","nodeType":8,"content":"comment"},{"name":"#text","nodeType":3,"content":"\n    "},{"name":"LI","nodeType":1,"children":[{"name":"#text","nodeType":3,"content":"...and cunning animal!"}]},{"name":"#text","nodeType":3,"content":"\n  "}]},{"name":"#text","nodeType":3,"content":"\n\n\n"}]}]};

drawHtmlTree(node6, 'div.domtree', 690, 500);
</script>

You can see the comment node labeled as `#comment` in the tree.

**Why are comments in the DOM?** Even though comments don't show up on the page, if it's in your HTML, it's in the DOM. This is the rule: **Everything in HTML becomes part of the DOM, including comments.**

### Other Node Types

There are actually [12 different node types](https://dom.spec.whatwg.org/#node) in the DOM specification, but in practice, you'll mostly work with these 4:

1. **`document`** - The entry point to the entire DOM
2. **Element nodes** - HTML tags (the building blocks of the tree)
3. **Text nodes** - Text content
4. **Comment nodes** - HTML comments (you can store information here that JavaScript can read)

Even `<!DOCTYPE>` at the start of your HTML becomes a DOM node (though we rarely need to work with it). The `document` object itself is also technically a DOM node.

## Exploring the DOM with Developer Tools

The best way to see and understand the DOM is to use your browser's developer tools.

### Using Live DOM Viewer

You can try the [Live DOM Viewer](https://software.hixie.ch/utilities/js/live-dom-viewer/) to see how HTML becomes a DOM tree in real-time. Just type in some HTML and watch it transform!

### Browser Developer Tools

For real development work, you'll use the browser's built-in developer tools. Here's how:

1. Open any webpage (or create a simple HTML file)
2. Right-click on the page and select "Inspect" (or press F12)
3. Click on the "Elements" tab (Chrome/Edge) or "Inspector" tab (Firefox)

You should see something like this:

![](elk.svg)

The developer tools show you the DOM structure. You can:
- Click on elements to see their details
- Expand and collapse parts of the tree
- See all the properties and styles

**Note:** Developer tools simplify the view. They show text nodes as just text (not separate nodes), and they hide empty text nodes. This makes it easier to work with, since you're usually interested in the element nodes anyway.

### Inspecting Elements

There are two main ways to inspect an element:

1. **Click the inspect button** (the icon in the top-left of developer tools), then click on any element on the page. The Elements tab will jump to that element.

2. **Right-click on the page** and select "Inspect" - this will highlight the element you clicked on.

![](inspect.svg)

### The Right Sidebar

When you select an element, the right side of developer tools shows useful information:

- **Styles** - See all CSS rules applied to the element. You can edit them right there!
- **Computed** - See the final computed styles (after all CSS rules are applied)
- **Event Listeners** - See what JavaScript events are attached to the element
- And more...

The best way to learn is to click around and experiment. Most values can be edited directly in the tools.

## Using the Console with the DOM

You can combine the Elements tab with the Console to experiment with JavaScript.

### From Elements to Console

1. Select an element in the Elements tab
2. Press `Esc` to open the console at the bottom
3. The selected element is now available as `$0`
4. Previous selections are `$1`, `$2`, etc.

Now you can run JavaScript on that element:

```js
$0.style.background = 'red'; // Makes the selected element red
```

![](domconsole0.svg)

### From Console to Elements

If you have a JavaScript variable pointing to a DOM element, you can use `inspect()` to see it in the Elements tab:

```js
let myElement = document.querySelector('h1');
inspect(myElement); // Jumps to that element in Elements tab
```

You can also just log the element to the console and explore it there:

```js
console.log(document.body); // Shows the body element in the console
```

![](domconsole1.svg)

Developer tools are incredibly helpful for learning and debugging. You can explore the DOM, try things out, and see what happens!

## Summary

Here's what you need to remember:

- **HTML is converted into a DOM tree** - Every tag and piece of text becomes a node
- **Element nodes** - HTML tags form the structure
- **Text nodes** - Text content (including spaces and newlines)
- **Comment nodes** - HTML comments are also in the DOM
- **Everything in HTML becomes part of the DOM** - Even things that don't display

- **Browsers fix HTML mistakes** - Missing tags, unclosed tags, etc. are automatically corrected
- **Developer tools let you explore** - Use them to see and experiment with the DOM
- **Console integration** - You can work with elements using `$0`, `$1`, etc.

The DOM is the foundation for everything you'll do with JavaScript on web pages. In the next chapters, we'll learn how to find elements, modify them, create new ones, and make your pages interactive!

For more information about Chrome Developer Tools, check out the [official documentation](https://developers.google.com/web/tools/chrome-devtools). But honestly, the best way to learn is to just click around and experiment!
