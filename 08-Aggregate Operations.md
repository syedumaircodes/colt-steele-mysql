
# Aggregate Operations

Instead of working on one row at a time, aggregate functions run calculations on a whole set of data. 

## The COUNT function

`COUNT` is the simplest of these. It just tells you how many items are in a dataset. 

```SQL
SELECT COUNT(*) FROM books;
```

If you pass a specific column name instead of an asterisk, like `COUNT(author_lname)`, MySQL will only count rows that actually have a value in that column. Any `NULL` entries are skipped.

You can also combine `COUNT` with `DISTINCT` to find the number of unique entries:

```SQL
SELECT COUNT(DISTINCT author_lname) FROM books;
```

## Group By

On their own, aggregate functions collapse your entire table into a single row. If you try to select a specific `title` alongside `COUNT(*)`, MySQL will either throw an error (depending on your SQL mode settings) or return a useless, arbitrary title.

To run calculations on specific categories, use `GROUP BY`. This tells MySQL to split your data into mini-groups before running the aggregate function.

```SQL
SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname;
```

```SQL
SELECT author_lname, COUNT(*) AS books_written
FROM books
GROUP BY author_lname
ORDER BY books_written DESC;
```

Keep in mind that when using `GROUP BY`, every column you `SELECT` must either be in your `GROUP BY` clause or wrapped in an aggregate function. If you try to select `title` without grouping by it or aggregating it, MySQL won't know which of the author's many titles to display, and the query will fail.

## MIN and MAX values

Use `MIN` and `MAX` to find the smallest and largest values in a column.

```SQL
SELECT MAX(pages) FROM books;
```

Just like with `COUNT`, if you try to select the book's title alongside `MAX(pages)`, MySQL will collapse the table and won't associate the correct title with that maximum number. 

## Subqueries

To retrieve an entire row associated with a minimum or maximum value, you can use a subquery—which is just a query nested inside another one.

```SQL
SELECT title, pages FROM books
WHERE pages = (SELECT MAX(pages) FROM books);
```

MySQL runs the subquery inside the parentheses first to find the highest page count (e.g., 634), and then runs the outer query to pull any books matching that number. 

### Why not just use `ORDER BY pages DESC LIMIT 1`?
Sorting and limiting is simpler, but if you have a tie (two different books that both have exactly 634 pages), `LIMIT 1` will hide the second book. A subquery ensures you get all matches.

## Grouping multiple columns

Sometimes grouping by a single column isn't specific enough. If you have authors who share a last name (like Dan Harris and Frank Harris), grouping solely by `author_lname` will merge them into a single group.

To prevent this, group by multiple columns by separating them with commas:

```SQL
SELECT author_fname, author_lname, COUNT(*)
FROM books
GROUP BY author_lname, author_fname;
```

This tells MySQL to only group rows where *both* the first and last names are identical. Alternatively, you can group by a concatenated string alias:

```SQL
SELECT CONCAT(author_fname, ' ', author_lname) AS author, COUNT(*)
FROM books
GROUP BY author;
```

## Combining MIN/MAX with GROUP BY

Combining `MIN` and `MAX` with `GROUP BY` lets you find the extremes for specific categories rather than the entire table.

For example, to find each author's earliest release:

```SQL
SELECT author_lname, MIN(released_year) FROM books GROUP BY author_lname;
```

You can run multiple aggregate functions in the same query to build a quick summary of each author's work:

```SQL
SELECT author_lname, 
	COUNT(*) as books_written, 
	MAX(released_year) AS latest_release,
	MIN(released_year)  AS earliest_release,
	MAX(pages) AS longest_page_count
FROM books GROUP BY author_lname;
```

## The SUM function

The `SUM` function adds up all the numbers in a column. You can use it across the whole table, or with `GROUP BY` to get totals per category:

```sql
SELECT author_lname, COUNT(*), SUM(pages)
FROM books
GROUP BY author_lname;
```

`SUM` only works on numbers. If you try to sum up text columns like names, MySQL will return `0` instead of throwing an error.

## The AVG function

`AVG` calculates the average of a numeric column. 

```SQL
SELECT released_year, AVG(stock_quantity), COUNT(*) 
FROM books
GROUP BY released_year;
```

It is usually a good idea to select `COUNT(*)` alongside `AVG()`. This helps you see whether an average is based on a solid sample size or if it's just skewed by one or two outlier records.

---

