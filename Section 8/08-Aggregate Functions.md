# Aggregate Functions

Aggregate functions in MySQL are powerful tools that allow you to perform
calculations on a collection of data rather than just individual rows.

## The COUNT Function

The `COUNT` function is the most fundamental of these, used to determine the total number of items in a set. When you use `SELECT COUNT(*) FROM books`, you are asking the database to count every row in the table, providing a single numerical result.

It is important to understand that `COUNT` behaves differently depending on
whether you are counting all rows or a specific column. If you use
`COUNT(column_name)`, MySQL will count the number of times a non-null value
appears in that field. If a row has a `NULL` value for that specific column, it is
skipped in the total. 

You can combine `COUNT` with the `DISTINCT` keyword inside the parentheses to find the number of unique values in a column, such as determining how many unique authors are represented in a library of twenty books.

While aggregate functions produce a single summary value, they do not play nice with standard column selections. If you attempt to select both a specific title and a count of all rows in the same query, MySQL may return an error because 
the two requests are incompatible.

```SQL
SELECT COUNT(*) FROM books;

SELECT COUNT(author_lname) FROM books;

SELECT COUNT(DISTINCT author_lname) FROM books;

SELECT COUNT(*) FROM books WHERE title LIKE '%the%';
```

## Group By

The `GROUP BY` clause is one of the most essential tools in SQL for data analysis,
as it allows you to summarize identical data into single rows. It organizes your table into mini-groups based on a specific column. 

When you use `COUNT(*)` in conjunction with `GROUP BY`, MySQL counts the number of
rows within each specific group rather than the total rows in the entire table. 

This enables you to answer questions like "How many books has each author
written?" The database looks into each author's mini-group, counts the entries,
and displays the total next to the author's name. You can then use other SQL
features like `ORDER BY` on these calculated results to sort authors by their
productivity or find the busiest year for book releases.

A common point of confusion with `GROUP BY` is trying to select columns that
aren't part of the grouping criteria. If you group by `author_last_name` but try
to select the `title` column as well, MySQL will return an error. This is because a single author might have multiple titles, and the database doesn't know which one to display in a summarized row. 

To avoid this, your `SELECT` statement should generally only include the column you are grouping by and the aggregate function used to summarize the rest of the data.

```SQL

SELECT author_lname, COUNT(*)
FROM books
GROUP BY author_lname;

SELECT
author_lname, COUNT(*) AS books_written
FROM books
GROUP BY author_lname
ORDER BY books_written DESC;
```

## MIN and MAX values

The `MIN` and `MAX` functions are built-in SQL operations used to find the smallest and largest values within a specific column. They are straightforward to use with numerical data, such as finding the earliest release year in a library or the book with the highest page count. 

A significant limitation of using `MIN` or `MAX` on its own is that it only returns the calculated value, not the other data associated with that specific row. If you try to select `MIN` or `MAX` with the title of a book in the same query, MySQL will likely return an error. This occurs because the aggregate function collapses the entire table into a single result, and the database does not inherently know which title corresponds to that maximum value.

To retrieve the full row of data associated with a minimum or maximum value, you must use more advanced query techniques. Simply listing other columns alongside these functions will not work because of how SQL processes aggregated data.

```SQL
SELECT MAX(pages) FROM books;
SELECT MIN(author_lname) FROM books;
```

## Subqueries

To retrieve an entire row associated with a minimum or maximum value, you can use two different strategies: 

- Sorting with a limit 
- Using a subquery. 

While `ORDER BY` and `LIMIT` are simple and familiar, they only return a single record. If your database contains multiple rows that share the same maximum value such as two different books that both have exactly 634 pages, the limit method will hide the other matches. A subquery is often the more precise choice for finding all records that meet the criteria.

A subquery is essentially a query nested inside another query, and it must always be enclosed in parentheses. When the database executes the command, it runs the subquery first.  

Subqueries are versatile and can be used with various aggregate functions like `MIN` to find the earliest released book or `MAX` to find the most expensive item. While they might appear more complex than a simple sort and limit, they provide a higher level of accuracy when there is a possibility of ties in your data.

```SQL
SELECT title, pages FROM books
WHERE pages = (SELECT MAX(pages) FROM books);

SELECT MIN(released_year) FROM books;

SELECT title, released_year FROM books
WHERE released_year = (SELECT MIN(released_year) FROM books);
```

## Grouping Multiple Columns

When working with datasets that contain similar information, such as authors who share the same last name, grouping by a single column may not provide the full picture. If you only group by `author_last_name`, MySQL will combine records for different people who happen to have the same surname, such as Dan Harris and Frank Harris, into one entry. To differentiate between these individuals, you can group by multiple columns by listing them sequentially in your command, separated by a comma.

By using the syntax `GROUP BY author_lname, author_fname`, you instruct the database to create unique groups for every distinct combination of first and last names. This ensures that the count for Dan Harris is calculated separately from the count for Frank Harris. Most records in your database will likely still result in a single group (since most names are unique), but this multi-column approach is vital for maintaining data accuracy in larger or more complex datasets.

>[!NOTE]
>An alternative method is to group by a concatenated string. If you create a virtual `full_name` column using the `CONCAT` function and give it an alias, you can then group your results by that specific alias and will achieve the same result.

```SQL
SELECT author_fname, author_lname, COUNT(*)
FROM books
GROUP BY author_lname, author_fname;

SELECT CONCAT(author_fname, ' ', author_lname) AS author, COUNT(*)
FROM books
GROUP BY author;
```

## Combining MIN MAX with GROUP BY

The `MIN` and `MAX` functions are even more powerful when used in conjunction with the `GROUP BY` clause. While using these functions on an entire table tells you the single smallest or largest value in a column, combining them with grouping allows you to find these values for specific categories. 

When you execute a query that groups by an author's name and selects `MIN(released_year)`, MySQL creates internal mini-groups for every author. It then looks at the books within each individual group and identifies the lowest year value for that specific set of rows.

You are not limited to just one calculation; a single query can return the author's name, the total number of books they have written using `COUNT`, their earliest release using `MIN`, and their most recent publication using `MAX`. This multi-level analysis is essential for creating detailed reports. You can even extend this logic to other numerical data, such as finding the highest page count among all books written by a specific author.

```SQL
SELECT author_lname, MIN(released_year) FROM books GROUP BY author_lname;

SELECT author_lname, MAX(released_year), MIN(released_year) FROM books GROUP BY author_lname;

SELECT author_lname, 
	COUNT(*) as books_written, 
	MAX(released_year) AS latest_release,
	MIN(released_year)  AS earliest_release,
	MAX(pages) AS longest_page_count
	FROM books GROUP BY author_lname;

SELECT author_lname, author_fname,
	COUNT(*) as books_written, 
	MAX(released_year) AS latest_release,
	MIN(released_year)  AS earliest_release
	FROM books GROUP BY author_lname, author_fname;
```

## The SUM Function

The `SUM` function is an aggregate tool used to calculate the total of all numerical values within a specific column. Like other aggregate functions, you can apply it to an entire table or use it in combination with the `GROUP BY` clause to summarize data by category.

When using `SUM` with a group, MySQL calculates a separate total for every subset of data. If an author has three books in the database, the system will add the page counts for those three specific rows and display that result alongside the author's name. You can also combine this with other functions, such as `COUNT`, to see both how many books an author wrote and the total page count for those books in the same query.

The `SUM` function only works with numeric data. If you attempt to use it on a text column, such as summing author last names, MySQL will not concatenate the text or return an error; instead, it will simply return a value of zero.

```sql
SELECT SUM(pages) FROM books;

SELECT author_lname, COUNT(*), SUM(pages)
FROM books
GROUP BY author_lname;
```

## The AVG Function

The `AVG` function is the final aggregate tool in this set, used to calculate the arithmetic mean of a numeric column. You can use it to find a single average across an entire dataset, such as the average page count for all books in your library, or you can combine it with the `GROUP BY` clause to see how averages differ across categories. 

When using `AVG` with groups, the results are calculated independently for each subset of data. If the year 2001 has three books with varying stock levels, MySQL will add those three values and divide the total by three to provide the average for that specific group. To make these results more meaningful, you can also include a `COUNT(*)` in your query. This helps you understand if an average is based on a large sample size or just one or two records, providing better context for your analysis.

```SQL
SELECT AVG(pages) FROM books;

SELECT AVG(released_year) FROM books;

SELECT released_year, AVG(stock_quantity),
COUNT(*) FROM books
GROUP BY released_year;
```

---
