# Filtering Selections

## Distinct results

If your table has duplicate rows and you only want to see the unique values, use `DISTINCT` right after your `SELECT` statement.  You can use it on a single column, or list multiple columns to find unique combinations. You don't need to merge columns with string functions, simply separating them with commas is the cleanest way to do it.

```sql
SELECT DISTINCT author_lname FROM books;
SELECT DISTINCT author_fname, author_lname FROM books;
```

## Ordering selections

To sort your query results, use `ORDER BY`. By default, MySQL sorts in ascending order, meaning numbers go low-to-high and text is alphabetized. To reverse this, add `DESC` after the column name.

```sql
SELECT * FROM books ORDER BY released_year DESC;
```

If a column contains `NULL` values, MySQL treats `NULL` as the lowest possible value. This means null rows will show up first in ascending sorts and last in descending sorts.

You can also sort by multiple columns. MySQL will sort by the first column first, and then use the subsequent columns as tie-breakers:

```sql
SELECT book_id, author_fname, author_lname FROM books 
ORDER BY author_lname, author_fname;
```

>[!NOTE]
>You might see people use numbers to sort, like `ORDER BY 2 DESC`. This tells MySQL to sort by the second column listed in your `SELECT` statement. While it saves typing in the terminal, it's generally avoided in real-world code because if you add or rearrange columns in your query later, your sorting will break.

## Limiting selections

If you only want a specific number of rows returned, use `LIMIT`:

```sql
SELECT title FROM books LIMIT 3;
```

You can also use `LIMIT` to grab a specific slice of your data using an offset. The syntax is `LIMIT <offset>, <count>`. Just keep in mind that MySQL is zero-indexed here, so an offset of `0` is the very first row.

```sql
-- Skip the first 5 rows and grab the next 50
SELECT title FROM books LIMIT 5, 50;
```

## The LIKE keyword

When you don't have an exact match to search for, use the `LIKE` operator. It lets you run wildcard searches using the percent sign (`%`) and the underscore (`_`).

* `%` matches any number of characters (including zero).
* `_` matches exactly one character.

```sql
-- Finds any first name with "da" anywhere in it
SELECT author_fname FROM books WHERE author_fname LIKE '%da%';

-- Finds any three-letter first name where the middle letter is "a" (like "Dan" or "Sam")
SELECT author_fname FROM books WHERE author_fname LIKE '_a_';
```

If you actually need to search for a literal `%` or `_` in your database, you have to escape them with a backslash (`\%` or `\_`). Otherwise, MySQL will treat them as wildcards.

```sql
-- Finds titles containing a literal percent sign
SELECT * FROM books WHERE title LIKE '%\%%';
```

---

