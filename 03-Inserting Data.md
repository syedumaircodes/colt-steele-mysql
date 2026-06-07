# Inserting data into the database

To add data to a table, use the `INSERT INTO` statement. You need to specify the table you're targeting, the columns you want to fill, and the actual values you're putting inside them.

```SQL
INSERT INTO cats (name, age)
VALUES ('Blue Steele', 5);
```

If the command works, MySQL will return a Query OK, 1 row affected message. You can quickly view your new row using a basic select query:


```SQL
SELECT * FROM cats;
```

MySQL maps your values to the columns in the exact order you list them. If your columns are defined as (name, age), your values must be written as ('string', number). If you mix up the order, the database will throw an error because data types are strict rules, not suggestions.

If you have several rows of data to add, you don't need to write a separate `INSERT` statement for every single one. You can bundle them into a single query by separating the value sets with commas:

```SQL
INSERT INTO foods (name, quantity)
VALUES
	('Meatballs', 5),
	('Turkey', 1),
	('Mashed Potatoes', 15);
```

---
