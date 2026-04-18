# Creating Databases and Tables

When you first install MySQL, the system automatically includes several default databases that manage internal configurations. The following command will show you all of the current databases.

```SQL
SHOW DATABASES;
```

## Creating Databases

Creating new databases is the next essential step in setting up your data environment. A new database begins as an empty shell that acts as a container for future information. To create one, you use the following command.

```SQL
CREATE DATABASE <DBNAME>;
```

When naming a database, you should select something unique and meaningful that clearly describes the contents. Avoid using spaces in database names, as they can cause technical errors. Instead, use underscores or camel case to separate words. 

After creating the database, you need to use the following command to select the database, this makes sure that you run queries in the correct database

```SQL
USE <DBNAME>
```
## Dropping Databases

Managing your databases involves two critical actions, deleting the ones you no longer need and selecting the one you want to work inside. To remove a database and all its contents entirely, you use the following command 

```SQL
DROP DATABASE <DBNAME> --This action is permanent and should be performed with caution.
```

## Creating Tables

The heart of any relational SQL database is the table. While creating and selecting databases are necessary first steps, the majority of your work in SQL involves interacting with tables and the information they contain.

A database is essentially a collection of these tables, which provide a structured format for your data. Each table defines a specific shape for the information it holds, ensuring that every entry follows the same rules.

A table is organized into two primary components known as columns and rows. Columns are the headers that define the categories of information and rows are the individual entries that fill those categories with specific data. Before you can add any information to a database, you must first create an empty table by defining its structure. This ensures that every piece of data added later fits into the predefined columns.

To create a new table in a SQL database, you must define the table name along with the specific names and data types for every column it will contain. 

```SQL
CREATE TABLE dogs (
	name VARCHAR(50),
	breed VARCHAR(50),
	age INT );
```

After creating a table, you can use several utility commands to inspect its structure and verify that the columns were defined correctly. If you are working in a command-line environment, the `SHOW TABLES` command will list all tables currently existing within your active database. 

## Dropping Tables

The `DROP TABLE` command is the primary way to remove a specific table from your database. When you execute this command, the database management system does not provide a warning or ask for confirmation; it simply deletes the table and all the information stored within it. For this reason, it is critical to verify the contents of a table before deciding to remove it.

## Data Types

Data types are a fundamental part of defining a table's structure because they ensure data consistency and accuracy. By assigning a specific type to a column, you create rules that the database must enforce. 

If a column meant for a cat's age is not restricted to numbers, a user might enter text like "ten" instead of the number 10, which would make it impossible for the database to perform mathematical operations.

MySQL offers an extensive variety of data types across three main categories: numeric types, string or text types, and date types. While the sheer number of options can be overwhelming, most developers rely on a small handful of common types for the majority of their work. 

The two most important data types to master are `INT` and `VARCHAR`. `INT` is used for whole numbers and does not allow for decimals or fractions. `VARCHAR` is used for text of varying lengths, such as names or usernames.
