# String Functions

String functions allow you to perform various operations on your text data, including:

- Converting text to uppercase or lowercase for consistency.
- Calculating the character length of a specific piece of text.
- Reversing the order of characters within a string.
- Replacing specific parts of a text string with new information.

## Concatenating Strings

The `CONCAT` function is a built-in string operation used to combine, or concatenate, multiple pieces of text into a single string. If you have separate columns for an author's first and last name, you can use `CONCAT` to produce a full name for each row in your results.

When using `CONCAT`, you must include parentheses and separate each value or column name with a comma. There is also a specialized version of this function called `CONCAT_WS`, which stands for Concatenate With Separator. This version is highly efficient when you need to put the same character between every piece of text you are combining. 

The first value you provide to the function is the separator (such as a dash, comma, or space), and MySQL will automatically insert that character between all subsequent values. 

```SQL
SELECT CONCAT('pi', 'ckle');
SELECT CONCAT(author_fname,' ', author_lname) AS author_name FROM books;
SELECT CONCAT_WS('-',title, author_fname, author_lname) FROM books;
```

## Substring

The `SUBSTRING` function shortened to `SUBSTR`, allows you to extract a specific portion of a larger string. This is useful when you need to sample or truncate text, such as showing only the first few words of a book title or getting a user's initials. 

To use it, you provide the source text or column name as the first argument, followed by a starting position and an optional length. Unlike many programming languages that start counting at zero, MySQL starts counting characters at one.

When using `SUBSTRING`, the second argument tells the database exactly where to begin the extraction. If you only provide this starting number, MySQL will capture everything from that point until the end of the string. If you add a third argument, it acts as the length, defining exactly how many characters should be pulled. 

```sql
SELECT SUBSTR('Hello World', 1, 4);
```

You can also use negative numbers for the starting position to count backward from the end of the string. This is a quick way to grab the suffix of a string, such as a file extension or the last character of a name, without knowing the total length of the text. 


```SQL
SELECT SUBSTRING('Hello World', 1, 4);
SELECT SUBSTRING('Hello World', 7);
SELECT SUBSTRING('Hello World', -3);
SELECT SUBSTRING(title, 1, 10) AS 'short title' FROM books;
SELECT SUBSTR(title, 1, 10) AS 'short title' FROM books;
```

You can create powerful and dynamic results in SQL by nesting functions, such as passing the result of a `SUBSTRING` into a `CONCAT` function. This technique is commonly used to format data for display. 

When nesting functions, MySQL evaluates the innermost function first for every row, then uses that output as an argument for the outer function.To make these nested queries easier to read and debug, it is often helpful to use indentation and line breaks. 

```SQL
SELECT CONCAT (
	SUBSTRING(title, 1, 10),
	'...') 
	AS 'short title'
	FROM books;
```

## Replacing Strings

The `REPLACE` function allows you to substitute specific portions of a string with a different set of characters. It requires three specific arguments in a strict order: the source string or column you are targeting, the substring you want to remove, and the new text you want to put in its place. 

Remember that `REPLACE` is case-sensitive. The function is global within each string, meaning it will replace every instance of the targeted substring it finds. For instance, replacing every space in a sentence with the word and would result in a modified string where every single blank space is filled with that new word.

```SQL
SELECT REPLACE('Hello World', 'l', '7');
SELECT REPLACE(title, ' ', '-') FROM books;
```

## Reversing Strings

The `REVERSE` function is a straightforward string operation that flips the order of characters in a given string. When you apply this function to a piece of text, such as "hello" the result is "olleh" It preserves the original capitalization of the letters while only changing their sequence. 

If you attempt to reverse the special value `NULL` values you will get `NULL` in return as well.

```SQL
SELECT REVERSE('Hello World');
```

## Character Length

The `CHAR_LENGTH` function is used to calculate the exact number of characters in a specific piece of text or a column. This is a common operation when you need to enforce data rules, such as checking if a password is long enough or finding the longest title in a library database.

It is important to distinguish `CHAR_LENGTH` from the similar function called `LENGTH`. While they often produce the same result for standard English text, they measure different things. 

`LENGTH` calculates the size of a string in bytes, whereas `CHAR_LENGTH` calculates the size in characters. For certain characters, such as those found in Chinese or specialized symbols, a single character might require multiple bytes of storage. 

```SQL
SELECT CHAR_LENGTH('Hello World');
SELECT author_lname, CHAR_LENGTH(author_lname) AS 'length' FROM books;
```

## Upper and Lower Case

The UPPER and LOWER functions (aliases `UCASE` and `LCASE`) are simple tools for standardizing the capitalization of your text data. `UPPER*` transforms every character in a string to its uppercase form, while `LOWER` converts every character to its lowercase form. These functions are particularly useful when you need to standardize user input such as email addresses or usernames.

Standardizing casing is a foundational skill in data management because it helps avoid errors during searches and comparisons. While these operations might seem simple, they are essential building blocks for more advanced database tasks.

```SQL
SELECT CONCAT('MY FAVORITE BOOK IS ', UPPER(title)) FROM books;
SELECT CONCAT('MY FAVORITE BOOK IS ', LOWER(title)) FROM books;
```

## Other String Functions

Several additional string functions are useful for more specific text manipulation tasks. 

- The `INSERT` function allows you to place a new string inside an existing one at a defined position. 
- The `LEFT` and `RIGHT` functions are simple tools for extracting a specific number of characters from either side of a string. They are used as alternatives to `SUBSTRING`.
- `REPEAT` takes a string and a number, returning that string repeated as many times as specified. 
- `TRIM` is primarily used to clean up data by removing unwanted leading or trailing spaces, which is a common task when dealing with user-submitted forms. 

```SQL
SELECT INSERT('Hello Bobby', 6, 0, 'There');
SELECT LEFT('omghahalol!', 3);
SELECT RIGHT('omghahalol!', 4);
SELECT REPEAT('ha', 4);
SELECT TRIM(' pickle ');
```

---
