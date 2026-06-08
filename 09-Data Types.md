# Data types in MySQL

## CHAR vs. VARCHAR

The difference between `CHAR` and `VARCHAR` comes down to how they store text in memory.  `VARCHAR` is variable-length. If you define a column as `VARCHAR(100)` but only save the word "cat," it only uses 3 bytes of storage (plus 1 byte of overhead). This makes it the default choice for almost all text, like names, emails, and descriptions.

`CHAR` is fixed-length. If you define a column as `CHAR(2)`, every single entry takes up exactly 2 bytes, even if you store a single character. MySQL will pad shorter strings with spaces to hit the limit. Use `CHAR` when your data is guaranteed to be a constant size, like two-letter state abbreviations (`'NY'`, `'CA'`), status flags (`'Y'`, `'N'`), or postal codes .

## Integers

MySQL has a few different integer types to save space depending on how large your numbers are. Beyond standard `INT` (which uses 4 bytes and goes up to ~2.1 billion), you can use:

* `TINYINT` (1 byte, up to 127)  
* `SMALLINT` (2 bytes, up to 32,767)
* `MEDIUMINT` (3 bytes, up to 8.3 million)
* `BIGINT` (8 bytes, up to 9 quintillion)

By default, these are signed, meaning they allow negative numbers. If you know a number will never drop below zero, add `UNSIGNED` to the definition. This doubles the maximum positive value you can store in that column.

## Decimals

For exact mathematical values like prices, tax rates, or financial calculations, use `DECIMAL`. Unlike other numeric types, it doesn't suffer from rounding issues.

You define it with two numbers: `DECIMAL(precision, scale)`. 

- Precision is the total number of digits.
- Scale is the number of digits allowed *after* the decimal point.

`DECIMAL(5,2)` allows a maximum of 5 digits total, with 2 of them after the decimal. That means the largest number you can store is `999.99`. If you try to save `1000.00` or higher, MySQL will reject it with an out of range error. 

While `DECIMAL` is slightly more resource-heavy, it's the safest way to handle currency in a database.

## Floats and Doubles

If you are working with scientific data, coordinates, or massive statistics where tiny rounding errors don't matter, use `FLOAT` or `DOUBLE` instead of `DECIMAL`. They are faster and use less memory, but they use floating-point math, which can introduce microscopic rounding discrepancies.

- `FLOAT` uses 4 bytes and is accurate to about 7 decimal places.
- `DOUBLE` uses 8 bytes and is accurate to about 15 decimal places.

