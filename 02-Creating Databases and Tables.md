# Creating databases and tables

When you first install MySQL, it comes with a few built-in databases for its own internal settings. You can see what's already there by running this command:


```SQL
SHOW DATABASES;
```

To make your own database, use the `CREATE DATABASE` command:

```SQL
CREATE DATABASE <dbname>;
```

Keep your names simple. Use underscores or `camelCase` instead of spaces to avoid syntax errors down the road. Once your database exists, you have to tell MySQL you want to work inside it. If you skip this, MySQL won't know where to run your upcoming queries.

```SQL
USE <dbname>;
```

To delete a database, use the `DROP` command:

```SQL
DROP DATABASE <dbname>;
```

>[!DANGER]
>Be careful with this. SQL doesn't have an undo button, and it won't ask you for confirmation before it permanently deletes the database and all its data.

## Creating tables

Tables are where your actual data lives. You can think of a table like a spreadsheet structured into columns (the headers) and rows (the individual entries). Before you can add any data, you have to build the layout of the table by defining its columns and what kind of information goes into them.

```SQL
CREATE TABLE dogs (
	name VARCHAR(50),
	breed VARCHAR(50),
	age INT
);
```

After running that, you can check your work with `SHOW TABLES` to see a list of tables in your active database. If you want to see the exact column structure you just built, run `DESCRIBE dogs`.

To completely delete a table and all its rows, use the following command, like dropping a database, this is instant and permanent.

```SQL
DROP TABLE <tablename>;
```

## Data Types

Data types keep your data clean by forcing every entry to follow the same rules. If you have an age column, you want to restrict it to numbers. If a user enters ten instead of 10, you won't be able to run mathematical calculations or sort your users by age later on.

MySQL has a massive list of data types, but you'll use a small handful of them for almost everything you build. 
