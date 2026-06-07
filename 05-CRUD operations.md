# CRUD operations in MySQL

If you work with databases, you’ll hear the term CRUD constantly. It stands for Create, Read, Update, and Delete. These are the four core things you can do with your data.

| CRUD Operation | SQL Command | What it does        |
| -------------- | ----------- | ------------------- |
| Create         | INSERT      | Adds new rows       |
| Read           | SELECT      | Retrieves rows      |
| Update         | UPDATE      | Edits existing rows |
| Delete         | DELETE      | Removes rows        |

## Selecting data

To read data out of a table, you use the `SELECT` statement. While you can use `SELECT *` as a wildcard to pull every column, you can also list specific columns to keep your results clean.

```SQL
SELECT * FROM cats; --Grabs every column for every row.
SELECT name FROM cats; --Returns only the names column.
SELECT name, age FROM cats; --Returns just the name and age columns, ignoring the rest.
```

## The WHERE clause

`SELECT` pulls back every single row in the table. If you have thousands of records, that's a mess. To target specific data, you use the `WHERE` clause. You can filter by any column, even if you aren't displaying that column in your final query results.

```SQL
SELECT name FROM cats WHERE age = 4;
```

Sometimes database column names are long, ugly, or confusing. You can use the `AS` keyword to temporarily rename a column in your query results. This is called an alias.


```SQL
SELECT cat_id AS id, name FROM cats;
```

This only changes how the column header looks in your terminal or app. The actual table schema remains untouched, and the change disappears as soon as the query finishes running.

## Updating records

To edit existing data, use the `UPDATE` statement. You need the `UPDATE` keyword, a `SET` clause to declare the new values, and a `WHERE` clause to target the right rows.

```SQL
UPDATE cats SET age = 14 WHERE name = 'Misty';
```

>[!DANGER ]
>If you run an UPDATE command and forget the WHERE clause, MySQL will update every single row in the table.

## Deleting rows

To remove rows from a table, use `DELETE FROM` with a `WHERE` clause:

```SQL
DELETE FROM cats WHERE name = 'Happy';
```

`DELETE` only removes the data inside the table, leaving the structure intact. If you want to destroy the table itself, use `DROP TABLE`. Just like with `UPDATE`, if you forget the `WHERE` clause on a `DELETE` command, you will wipe the entire table clean.

---
