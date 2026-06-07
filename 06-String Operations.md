
# String operations

MySQL has a bunch of built-in functions to help you format, clean, and manipulate text. 

To join separate pieces of text together, use the `CONCAT` function

```SQL
SELECT CONCAT(author_fname, ' ', author_lname) AS author_name FROM books;
```

If you need to join multiple columns using the same character (like a hyphen, comma, or space), `CONCAT_WS` (Concatenate With Separator) is much cleaner. The first value you pass is your separator, and MySQL automatically drops it between every column that follows:

```SQL
SELECT CONCAT_WS('-', title, author_fname, author_lname) FROM books;
```

## Substrings

`SUBSTRING` (or just `SUBSTR`) lets you grab a specific slice of a string. It is handy for truncating long text, like showing a short preview of a book title. To use it, pass the column or string, the starting index, and an optional length. 

> [!NOTE]
> Most programming languages are zero-indexed, but SQL starts counting at 1.

```sql
SELECT SUBSTR('Hello World', 1, 4); -- Returns 'Hell'
SELECT SUBSTR('Hello World', 7);    -- Returns 'World' (captures everything to the end)
```

You can also pass a negative number as the starting index to count backward from the end of the string:

```SQL
SELECT SUBSTR('Hello World', -3); -- Returns 'rld'
```

## Nesting functions

You can combine functions by wrapping one inside another. You can nest `SUBSTR` inside of `CONCAT`. MySQL evaluates the innermost function first.

```SQL
SELECT CONCAT(
	SUBSTR(title, 1, 10),
	'...'
) AS 'short title' FROM books;
```

## Replacing strings

To swap out parts of a string, use `REPLACE`. It takes three arguments: the source text, the exact characters you want to find, and what you want to swap them with.

```SQL
SELECT REPLACE('Hello World', 'l', '7'); -- Returns 'He77o Wor7d'
```

>[!DANGER]
>`REPLACE` is case-sensitive, and it is global—it will swap *every* instance it finds in the string, not just the first one.

## Reversing strings

The `REVERSE` function simply flips a string backward. If you pass a `NULL` value to it, you just get `NULL` back.

```SQL
SELECT REVERSE('Hello World'); -- Returns 'dlroW olleH'
```

## Character length

To find out how many characters are in a string, use `CHAR_LENGTH`:

```SQL
SELECT CHAR_LENGTH('Hello World'); -- Returns 11
```

Be careful not to confuse this with the `LENGTH` function. They look identical when you run them on standard English text, but they measure different things:

* `CHAR_LENGTH()` counts the number of **characters**.
* `LENGTH()` counts the number of **bytes**.

For basic English letters, one character is one byte, so both functions return the same number. But for multi-byte characters like emojis or non-English scripts, `LENGTH` will return a much higher number than `CHAR_LENGTH`.

## Upper and lower case

To force text to uppercase or lowercase, use `UPPER` (or `UCASE`) and `LOWER` (or `LCASE`). This is incredibly useful for standardizing user inputs like email addresses or usernames before saving or comparing them.

```SQL
SELECT UPPER('hello'); -- 'HELLO'
SELECT LOWER('HELLO'); -- 'hello'
```

## Other string functions

Here are a few other handy text tools you'll run into:

* `LEFT()` and `RIGHT()` — Quick shortcuts to grab characters from either end of a string without writing a full `SUBSTR`.
* `TRIM()` — Strips leading and trailing spaces (perfect for cleaning up user inputs from form submissions).
* `REPEAT()` — Repeats a string a set number of times.
* `INSERT()` — Injects a string inside another string at a specific position.

```SQL
SELECT LEFT('omghahalol!', 3); -- 'omg'
SELECT TRIM('  pickle  ');      -- 'pickle'
SELECT REPEAT('ha', 4);        -- 'hahahaha'
```

---
