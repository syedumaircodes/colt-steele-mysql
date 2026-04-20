# CRUD Basics in MySQL

The term `CRUD` is a standard programming acronym that stands for `Create, Read, Update, and Delete`. These represent the four fundamental operations performed on data within a database. 

| CRUD Operation | SQL Command | Action Description                         |
| -------------- | ----------- | ------------------------------------------ |
| Create         | INSERT      | Adds new rows of data to a table           |
| Read           | SELECT      | Retrieves or searches for data in a table  |
| Update         | UPDATE      | Modifies existing information within a row |
| Delete         | DELETE      | Removes specific rows from a table         |
## Selecting Data

The `Read` operation in CRUD is handled by the `SELECT` statement, which is used to retrieve data that has been stored in a table. While the most common version of this command uses an asterisk as a wildcard to request every column, you can also specify exactly which pieces of information you want to see.

When you write a `SELECT` statement, you list the specific column names you are interested in immediately after the keyword. If you need multiple specific columns but not the entire table, you can separate the column names with commas, such as `SELECT name, age FROM cats`.

| Command Variation             | Result                                            | Best Use Case                                            |
| ----------------------------- | ------------------------------------------------- | -------------------------------------------------------- |
| SELECT * FROM table;          | Retrieves all columns for every row               | Checking your work or viewing the full dataset           |
| SELECT column1 FROM table;    | Retrieves only one specific column                | When you only need one piece of information, like names  |
| SELECT col1, col2 FROM table; | Retrieves multiple specific columns               | When you need related data without the extra table noise |
| SELECT age FROM table;        | Retrieves only numerical data from the age column | Preparing to perform math or find age-based statistics   |

## The Where Clause

The `WHERE` clause is a powerful SQL keyword used to filter data and narrow down exactly which rows you want to retrieve. Without a `WHERE` clause, a `SELECT` statement returns every single row in a table. By using this clause, you can define specific criteria to isolate only the records that meet your requirements. 

You can use the `WHERE` clause to perform matches based on different types of data, such as numbers or text. It is important that the column you use in your `WHERE` clause does not have to be one of the columns you are selecting for display; you can filter by age even if you only choose to display the name column.

```sql
SELECT * FROM cats WHERE age = 4;
```

## Aliases

An alias in SQL is a temporary name given to a column or a table for the duration of a specific query. You create an alias by using the `AS` keyword immediately after a column name in your `SELECT` statement. This does not change the actual name of the column in the database, it only changes how the column header appears in the resulting output. 

It is important to remember that aliases are entirely temporary. Once the query finishes running, the column reverts to its original name in the database schema. 

```sql
SELECT cat_id AS id, name FROM cats;
```

## Updating Records

The Update operation in CRUD allows you to modify existing data within a table. This is a common task for handling dynamic information, such as when a user changes their password or when a business updates product prices. 

The syntax for this operation uses the `UPDATE` keyword followed by the table name, the `SET` keyword to declare the new data, and usually a `WHERE` clause to specify which rows should be modified.

When performing an update, you can change a single column or multiple columns at once. While multi-column updates are less frequent in some scenarios, they are a powerful tool for maintaining accurate records efficiently.

```sql
UPDATE cats SET age=14 WHERE name='Misty';
```

A best practice when working with databases is to exercise extreme caution before performing mass updates. Because an update command can modify every row in a table if the criteria are incorrect, it is easy to accidentally overwrite valuable information. 

To prevent these mistakes, you should always test your filter criteria by running a `SELECT` statement with the exact same `WHERE` clause you plan to use for your update. This allows you to verify exactly which records will be affected before any permanent changes are made.

## Deleting Rows

The final component of the CRUD acronym is delete, which allows you to remove specific rows from a table. The syntax for this operation is `DELETE FROM` followed by the table name and a `WHERE` clause to target specific records.

It is important to distinguish this from the `DROP TABLE` command; while dropping a table deletes the entire structure from the database, the delete command only removes the data entries inside the table. Precision is vital when deleting data because, like the update command, omitting the `WHERE` clause will result in the deletion of every single row in the table.

```SQL
DELETE FROM cats WHERE name='Happy';
```

---
