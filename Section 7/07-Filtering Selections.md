# Filtering Selections

## Distinct Results

The `DISTINCT` clause is a specialized instruction used to eliminate duplicate
rows from your query results, ensuring that you only see unique values. To use
it, you must place the keyword immediately after `SELECT` and before any column
names. This clause is not limited to a single column; it can also be used to find
unique combinations across multiple columns.

While you could achieve similar results by using string functions like `CONCAT` to
merge names into a single string before applying `DISTINCT`, simply listing the
columns separated by commas is the cleaner and more efficient professional
standard. 

```sql
SELECT author_lname FROM books;
SELECT DISTINCT author_lname FROM books;
SELECT author_fname, author_lname FROM books;
SELECT DISTINCT CONCAT(author_fname,' ', author_lname) FROM books;
SELECT DISTINCT author_fname, author_lname FROM books;
```

## Ordering Selections

The `ORDER BY` clause is used to sort the results of a query based on the values
in one or more columns. By default, MySQL sorts data in ascending order (ASC),
which means numbers go from lowest to highest and text is alphabetized from A to Z. 

If you want to reverse this behavior, you use the `DESC` keyword after the
column name to sort in descending order. This is useful for identifying the most
recent releases, the highest prices, or the longest books in a dataset.

While sorting by text or numbers is straightforward, it is important to
understand how MySQL handles missing data. If a row has a `NULL` value in the
column you are sorting by, that row will typically appear at the beginning of an
ascending sort and at the end of a descending sort. This is because MySQL
considers `NULL` to be the lowest possible value. 

```sql
SELECT * FROM books
ORDER BY author_lname;

SELECT * FROM books
ORDER BY author_lname DESC;

SELECT * FROM books
ORDER BY released_year;
```

The `ORDER BY` clause offers advanced sorting capabilities, including shorthand
syntax and multi-column prioritization. It is generally discouraged in professional environments because it makes the code harder to read and prone to errors if the column order is changed later.

A more practical feature is the ability to sort by multiple columns. When you
list multiple columns after `ORDER BY`, MySQL sorts by the first column first, and
then uses the subsequent columns as tie-breakers. This is highly effective
when you have multiple entries with the same value, such as several books by the same author. 

Additionally, you can sort by aliased columns that you create during your query.
If you use the `CONCAT` function to merge a first and last name into a single
column called full_name, you can then use `ORDER BY` full_name at the end of
your query.

```sql
SELECT book_id, author_fname, author_lname, pages
FROM books ORDER BY 2 desc;

SELECT book_id, author_fname, author_lname, pages
FROM books ORDER BY author_lname, author_fname;
```

## Limiting Selections

The `LIMIT` clause is used to restrict the number of rows returned by a query,
which is essential when working with large datasets. On its own, `LIMIT 5` will
simply return the first five rows based on the order in which they are stored in
the database. 

Beyond simply taking the top results, the `LIMIT` clause can also handle ranges
using a two-number syntax. The first number represents the offset , and the second number represents the count. It is important to note that MySQL uses a zero-based index for offsets meaning that row zero is the first record in the set. 

```sql

SELECT title FROM books LIMIT 3;
SELECT * FROM books LIMIT 1;

SELECT title, released_year FROM books
ORDER BY released_year DESC LIMIT 5;

SELECT title, released_year FROM books
ORDER BY released_year DESC LIMIT 0,5;

SELECT title FROM books LIMIT 5, 50;
```

## The LIKE Keyword

The `LIKE` operator is used for pattern matching, allowing you to perform fuzzy
searches rather than relying on exact matches. To define a search pattern, you use two primary wildcard characters, the percent sign `(%)` and the underscore `(_)`. These symbols act as placeholders formissing information within a string.

The percent sign `(%)` represents zero, one, or multiple characters. If you want
to find every author whose name contains the letters "da", you would use the
pattern `%da%`. This tells MySQL to look for any string that has the letters
"da" anywhere.

The underscore `(_)` works differently because it represents exactly one character. This is useful when you need to match a specific string length or a specific pattern of characters. 

```sql
SELECT title, author_fname, author_lname, pages
FROM books
WHERE author_fname LIKE '%da%';

SELECT * FROM books
WHERE author_fname LIKE '_a_';
```

When you need to search for a literal percent sign `(%)` or an underscore `(_)`
within a database, you encounter a problem because these characters are reserved as wildcards in SQL. 

To solve this, you must use a backslash as an escape character. Placing a backslash before a wildcard tells MySQL to treat it as a standard text character rather than a search command. This same logic applies to underscores as well.

```sql
SELECT * FROM books
WHERE title LIKE '%\%%';

SELECT * FROM books
WHERE title LIKE '%\_%';
```

---
