# Inserting Data into the Database

To add data to an empty table, you use the `INSERT INTO` statement. This command requires you to specify the target table name and the specific columns you are filling, followed by the keyword `VALUES` and the corresponding data.

Once you execute an insert command, the system will typically respond with a message such as `Query OK, 1 row affected`, which confirms that the data was successfully saved to the table. 

```SQL
INSERT INTO cats (name, age)
VALUES ('Blue Steele', 5);
```

To verify that your data was inserted correctly into a table, you must use a `SELECT` statement. The simplest way to view your data is by writing `SELECT * FROM <tablename>;` This allows you to check for mistakes you might have made when inserting data.

## Multiple Inserts

MySQL does not inherently know which piece of data is which; it simply maps the first value you provide to the first column you listed. Consistency is mandatory because the data types act as strict rules rather than suggestions.

Efficiency is a key part of database management, and SQL allows for multiple inserts from a single command. Instead of writing separate statements for every new entry, you can provide a single `INSERT INTO` command and list multiple sets of values separated by commas. This approach is highly common when you need to populate a table quickly with several rows of data. 

```SQL
INSERT INTO foods (name, quantity)
VALUES
	('Meatballs', 5),
	('Turkey', 1),
	('Mashed Potatoes', 15);
```

# Not Null Values

In MySQL, the term `NULL` signifies the absence of a value or an unknown value. This is different from a zero in a numeric column or an empty space in a text column, which are both considered actual data. By default, when you create a table, most columns are set to allow `NULL` values. 

>[!NOTE]
>This means you can insert a row with a name but no age, or even a row that is entirely empty. While this flexibility can be useful for optional information, it often leads to low-quality data that lacks essential details.

To ensure that critical information is always provided, you can apply a `NOT NULL` constraint when creating a table. This constraint acts as a rule that prevents any row from being saved if a required column is left blank. 

```sql
CREATE TABLE cats (
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL);
```

## Quotes in MySQL

When working with textual data in MySQL, it is important to understand the proper use of quotation marks to ensure your code is both functional and compatible with other database systems. 

While MySQL may permit the use of double quotes for strings depending on its settings, most other flavors of SQL do not. Therefore, the best professional practice is to always use single quotes to wrap text values when inserting or manipulating data. 

## Default Values

Default values allow you to specify what data should be entered into a column if no information is provided during an insert operation. When you define a table, you use the `DEFAULT` keyword followed by the desired value to set this up. 

It is important to understand that a `DEFAULT` value is not the same as a `NOT NULL` constraint. While a default value automatically fills in gaps during a standard insert, it does not prevent a user from manually inserting a `NULL` value. If you want to ensure a column is never empty and always has a fallback value, you should use both constraints together. 

```SQL
CREATE TABLE cats (
	name VARCHAR(20) DEFAULT 'no name provided',
	age INT DEFAULT 01);
```

## Primary Keys

In a relational database, it is common to encounter rows that contain identical information. To distinguish these entries from one another, SQL uses a `Primary Key`. A primary key is a unique identifier assigned to each row, ensuring that every record can be specifically referenced even if all other data points are the same. 

When you define a column as a primary key, MySQL enforces two strict rules:
- The value must be unique within that table, and it cannot be `NULL`. 
- Once a primary key is established, the database will block any attempt to insert a duplicate value. 

```SQL
CREATE TABLE unique_cats (
	cat_id INT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL);
```

One important characteristic of a Primary Key is that it is inherently `NOT NULL`. Even if you do not explicitly label the column as `NOT NULL`, MySQL automatically enforces this constraint because a unique identifier must be present for every row. 

To simplify data entry, you can use the `AUTO_INCREMENT` attribute on your Primary Key column. This tells the database to automatically generate a unique, ascending number for every new row, typically starting at one. This feature removes the burden of manually tracking IDs and prevents human error.

```sql
CREATE TABLE unique_cats3 (
	cat_id INT AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	PRIMARY KEY (cat_id) );
```

---
