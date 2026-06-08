# Dates and Times

For chronological data, MySQL uses three main types:

-  `DATE` for storing just the date in `YYYY-MM-DD` format.
- `TIME` stores times or intervals in `HH:MM:SS` format.
- `DATETIME` stores both date and time together in `YYYY-MM-DD HH:MM:SS`.

```SQL
CREATE TABLE people (
	name VARCHAR(100),
	birthdate DATE,
	birthtime TIME,
	birthdt DATETIME
);

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');
```

## Current Date and Time

Instead of typing out the current date and time manually when inserting records, you can use these built-in helpers:

- `CURDATE()` — Returns the current system date (`YYYY-MM-DD`).
- `CURTIME()` — Returns the current system time (`HH:MM:SS`).
- `NOW()` — Returns both combined (`YYYY-MM-DD HH:MM:SS`).

```SQL
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());
```

>[!NOTE]
>These are perfect for tracking when a transaction took place or when a user registered.

## Date Functions

MySQL has several functions to pull specific parts out of a `DATE` or `DATETIME` column:

-  `YEAR()`, `MONTH()`, and `DAY()` extract those specific numbers.
-  `MONTHNAME()` returns the month as a word.
-  `DAYOFWEEK()` returns the numeric day of the week, where Sunday is `1` and Saturday is `7`.
-  `DAYOFYEAR()` returns the day number out of 365 (or 366).

```SQL
SELECT birthdate, DAYOFWEEK(birthdate), MONTHNAME(birthdate) FROM people;
```

## Time Functions

Similarly, you can slice up a `TIME` or `DATETIME` column using:

- `HOUR()`, `MINUTE()`, and `SECOND()` extract those specific time units.
- `DATE()` pulls just the date portion (`YYYY-MM-DD`) from a full `DATETIME` value.
- `TIME()` pulls just the time portion (`HH:MM:SS`) from a full `DATETIME` value.

```SQL
SELECT birthdt, DATE(birthdt), HOUR(birthdt) FROM people;
```

## Formatting Dates

Instead of manually concatenating days, months, and years, you can format dates using the `DATE_FORMAT()` function. It takes your date column and a format string filled with placeholder specifiers (which always start with `%`).

```sql
-- Returns something like "Mon Apr 11th"
SELECT DATE_FORMAT(birthdate, '%a %b %D') FROM people;
```

Common specifiers include:
-  `%Y` — 4-digit year 
- `%M` — Full month name 
- `%b` — Short month name 
- `%D` — Day of the month with an English suffix 
* `%r` — 12-hour time with AM/PM
* `%H:%i` — 24-hour hour and minutes 

## Date Math

Calculating intervals in SQL is straightforward:

- `DATEDIFF(date1, date2)` — Subtracts `date2` from `date1` and returns the difference in **days**.
- `TIMEDIFF(time1, time2)` — Returns the exact time difference in `HH:MM:SS` format.

If you want to add or subtract time, you can use the `INTERVAL` keyword with standard mathematical operators or the `DATE_ADD()` / `DATE_SUB()` functions:

```sql
-- Find out when someone turns 18
SELECT birthdate + INTERVAL 18 YEAR FROM people;

-- Or using the explicit function:
SELECT DATE_ADD(birthdate, INTERVAL 18 YEAR) FROM people;
```

## Timestamps

`DATETIME` and `TIMESTAMP` look identical, but they behave differently behind the scenes:

- *Range:** `DATETIME` covers the years `1000` to `9999`. `TIMESTAMP` only covers `1970` to early `2038` (due to the 32-bit integer limit). Use `DATETIME` for historical dates like birthdays, and `TIMESTAMP` for current transaction metadata.
- *Storage:** Because `TIMESTAMP` has a smaller range, it uses less storage space (4 bytes vs. 8 bytes for `DATETIME`), which keeps high-volume logs lightweight.

You can make MySQL handle your "created at" and "updated at" metadata automatically:

```sql
CREATE TABLE captions (
    text VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

---

