# Regular Expressions in JavaScript

Regular expressions (regex) are patterns used to match and manipulate strings. They're powerful tools for searching, validating, and extracting text.

## Creating Regular Expressions

There are two ways to create a regex in JavaScript:

### 1. Literal Syntax (Most Common)

```js
let pattern = /abc/;
```

### 2. Constructor Syntax

```js
let pattern = new RegExp('abc');
```

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // Literal syntax
    let regex1 = /hello/;
    
    // Constructor syntax
    let regex2 = new RegExp('hello');
    
    // Both work the same way
    console.log("Match:", regex1.test('hello world')); // true
    console.log("Match:", regex2.test('hello world')); // true
  </script>
</body>
</html>
```

## Basic Matching

### test() - Check if Pattern Matches

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    let pattern = /hello/;
    
    console.log(pattern.test('hello world')); // true
    console.log(pattern.test('hi there'));     // false
  </script>
</body>
</html>
```

### match() - Get Matches from String

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    let text = "Hello world, hello everyone";
    let pattern = /hello/i; // 'i' flag = case insensitive
    
    let result = text.match(pattern);
    console.log("Match:", result);
    // Returns array with match details or null
  </script>
</body>
</html>
```

## Common Patterns

### Character Classes

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // \d - digit (0-9)
    console.log(/\d/.test('abc123')); // true
    
    // \w - word character (letter, digit, underscore)
    console.log(/\w/.test('hello')); // true
    
    // \s - whitespace (space, tab, newline)
    console.log(/\s/.test('hello world')); // true
    
    // . - any character except newline
    console.log(/h.llo/.test('hello')); // true
    
    // [abc] - any of these characters
    console.log(/[abc]/.test('dog')); // true (has 'a'? no, but has 'd'? no... wait, let me check)
    console.log(/[abc]/.test('cat')); // true (has 'a')
  </script>
</body>
</html>
```

### Quantifiers

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // * - zero or more
    console.log(/ab*c/.test('ac'));    // true (0 b's)
    console.log(/ab*c/.test('abc'));   // true (1 b)
    console.log(/ab*c/.test('abbbc')); // true (many b's)
    
    // + - one or more
    console.log(/ab+c/.test('ac'));    // false (needs at least 1 b)
    console.log(/ab+c/.test('abc'));   // true
    
    // ? - zero or one
    console.log(/ab?c/.test('ac'));    // true (0 b's)
    console.log(/ab?c/.test('abc'));   // true (1 b)
    console.log(/ab?c/.test('abbbc')); // false (too many b's)
    
    // {n} - exactly n times
    console.log(/\d{3}/.test('123'));  // true (3 digits)
    console.log(/\d{3}/.test('12'));   // false
    
    // {n,m} - between n and m times
    console.log(/\d{2,4}/.test('123')); // true (2-4 digits)
  </script>
</body>
</html>
```

### Anchors

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    // ^ - start of string
    console.log(/^hello/.test('hello world')); // true
    console.log(/^hello/.test('say hello'));   // false
    
    // $ - end of string
    console.log(/world$/.test('hello world')); // true
    console.log(/world$/.test('world hello')); // false
    
    // Both together - exact match
    console.log(/^hello$/.test('hello')); // true
    console.log(/^hello$/.test('hello world')); // false
  </script>
</body>
</html>
```

## Flags

Flags modify how the regex works:

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    let text = "Hello HELLO hello";
    
    // i - case insensitive
    console.log(/hello/i.test(text)); // true
    
    // g - global (find all matches)
    let matches = text.match(/hello/gi);
    console.log("All matches:", matches); // ["Hello", "HELLO", "hello"]
    
    // m - multiline (^ and $ match line breaks)
    let multiLine = "line1\nline2\nline3";
    console.log(/^line/m.test(multiLine)); // true
  </script>
</body>
</html>
```

## Common Methods

### String Methods with Regex

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    let text = "Hello 123 World 456";
    
    // match() - find matches
    let numbers = text.match(/\d+/g);
    console.log("Numbers:", numbers); // ["123", "456"]
    
    // replace() - replace matches
    let replaced = text.replace(/\d+/g, 'X');
    console.log("Replaced:", replaced); // "Hello X World X"
    
    // search() - find position of first match
    let pos = text.search(/\d/);
    console.log("First digit at:", pos); // 6
    
    // split() - split by pattern
    let parts = text.split(/\s+/);
    console.log("Parts:", parts); // ["Hello", "123", "World", "456"]
  </script>
</body>
</html>
```

### RegExp Methods

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    let pattern = /\d{3}/;
    let text = "Call 123 or 456";
    
    // test() - returns true/false
    console.log(pattern.test(text)); // true
    
    // exec() - returns match details or null
    let result = pattern.exec(text);
    console.log("Match:", result[0]); // "123"
    console.log("Index:", result.index); // 5
  </script>
</body>
</html>
```

## Practical Examples

### Email Validation

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    function isValidEmail(email) {
      let pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      return pattern.test(email);
    }
    
    console.log(isValidEmail('user@example.com')); // true
    console.log(isValidEmail('invalid.email'));    // false
    console.log(isValidEmail('test@domain'));      // false
  </script>
</body>
</html>
```

### Extract Numbers

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    let text = "Price: $99.99, Tax: $5.50";
    let numbers = text.match(/\d+\.?\d*/g);
    console.log("Numbers:", numbers); // ["99.99", "5.50"]
  </script>
</body>
</html>
```

### Remove Extra Spaces

```html run
<!DOCTYPE html>
<html>
<body>
  <script>
    let text = "Hello    world    with    spaces";
    let cleaned = text.replace(/\s+/g, ' ');
    console.log("Cleaned:", cleaned); // "Hello world with spaces"
  </script>
</body>
</html>
```

## Quick Reference

### Character Classes
- `\d` - digit
- `\w` - word character
- `\s` - whitespace
- `.` - any character
- `[abc]` - any of a, b, or c
- `[^abc]` - not a, b, or c
- `[a-z]` - lowercase letters
- `[0-9]` - digits

### Quantifiers
- `*` - 0 or more
- `+` - 1 or more
- `?` - 0 or 1
- `{n}` - exactly n
- `{n,m}` - between n and m

### Anchors
- `^` - start of string
- `$` - end of string
- `\b` - word boundary

### Flags
- `i` - case insensitive
- `g` - global (all matches)
- `m` - multiline

### Common Patterns
- Email: `/^[^\s@]+@[^\s@]+\.[^\s@]+$/`
- Phone: `/\d{3}-\d{3}-\d{4}/`
- URL: `/https?:\/\/\S+/`
- Zip code: `/\d{5}(-\d{4})?/`

## Important for Exams

```smart header="Exam Essentials"
1. **Syntax:** `/pattern/flags` or `new RegExp('pattern', 'flags')`

2. **Methods:**
   - `regex.test(string)` - returns true/false
   - `string.match(regex)` - returns array or null
   - `string.replace(regex, replacement)` - returns new string
   - `string.search(regex)` - returns index or -1

3. **Common Patterns:**
   - `/\d+/` - one or more digits
   - `/^[a-z]+$/` - only lowercase letters
   - `/\s+/` - one or more spaces
   - `/^\d{3}-\d{3}-\d{4}$/` - phone number format

4. **Remember:**
   - `^` = start, `$` = end
   - `\d` = digit, `\w` = word, `\s` = space
   - `*` = 0+, `+` = 1+, `?` = 0 or 1
   - `i` flag = case insensitive
   - `g` flag = find all matches
```



