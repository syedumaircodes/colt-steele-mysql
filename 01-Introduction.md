# Introduction to databases

A database is just a structured collection of data. A physical filing cabinet or a printed phone book is a database, but they quickly become useless if you need to do anything complex.

If you have a phone book, looking up Smith is easy because it’s alphabetical. But what if you need a list of everyone who lives on Main Street? Or everyone with a 555 area code? To find that, you’d have to read the entire book page by page.

To get around these limitations, digital databases use a database management system (DBMS). This is the software that sits between you and the raw files on disk. Instead of editing files directly, you ask the DBMS to add, update, or delete records for you. In everyday conversation, developers usually just say database to refer to both the software and the data itself, but they are technically separate.

## SQL and MySQL

SQL (Structured Query Language) is the language you use to talk to a database. It’s how you write instructions to pull specific information, like finding users over a certain age or to save new data.

MySQL is a specific database program that understands SQL. While SQL is the language itself, MySQL is the software that actually stores and organizes the files. Other databases, like Postgres or SQLite, also use SQL.

Because SQL is a standardized language, a basic command written for MySQL will usually run perfectly in Postgres without any changes. The real differences between these systems aren't the language they use, but how they handle performance, security, and user permissions behind the scenes.