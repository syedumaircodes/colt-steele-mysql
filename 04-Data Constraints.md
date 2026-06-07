# Inserting Data Constraints

When inserting data into a SQL table, you must always keep track of these constraints

## NULL and NOT NULL

In SQL, `NULL` represents a completely empty or missing value. It is not the same as a 0 or an empty string. By default, MySQL allows columns to be `NULL`. This means you could easily insert a row with a name but no age, or even a completely empty row. To prevent incomplete records, you can add the `NOT NULL` constraint when creating your table. This forces the database to reject any inserts that leave required columns blank.


```SQL
CREATE TABLE cats (
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL
);
```

## Quotations

When writing text values in SQL, always wrap them in single quotes, not double quotes. While MySQL sometimes accepts double quotes, other SQL databases will throw syntax errors if you use them for strings. Sticking to single quotes makes your SQL code much easier to reuse across different systems.

## Default values

If you want a column to use a fallback value when no data is provided, use the `DEFAULT` keyword:

```SQL
CREATE TABLE cats (
	name VARCHAR(20) DEFAULT 'unnamed',
	age INT DEFAULT 0
);
```

> [!IMPORTANT]
> A `DEFAULT` value is not the same as a `NOT NULL` constraint. If you omit the name during an insert, the default value kicks in. 

## Primary keys

If you have three different cats named Spot who are all 2 years old, your database has no clean way to tell them apart. To fix this, relational databases use a Primary Keys which are unique IDs assigned to each row. A primary key column is always unique and cannot contain `NULL` values. If you try to insert a row with an ID that already exists, the database will block it.


```SQL
CREATE TABLE unique_cats (
	cat_id INT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL
);
```

Instead of manually keeping track of IDs yourself, you can use `AUTO_INCREMENT` on your primary key. This tells MySQL to automatically generate a unique, ascending number starting at 1 for every new row you add.

```SQL
CREATE TABLE unique_cats3 (
	cat_id INT AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	PRIMARY KEY (cat_id) 
);
```

---
