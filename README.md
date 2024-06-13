# transport-gres

Setup the Information Management (Public transportation routes) database in Postgres

Will try to do the requirements such as the creation of database, tables, and queries all through `.sql` files using `psql` (command line front-end for Postgres) to avoid any manual GUI interaction

Following the resources from the official Postgres site and guide:

- [PostgreSQL 16.3 Documentation](https://www.postgresql.org/docs/16/index.html)
- [psql command line tutorial and cheat sheet](https://tomcam.github.io/postgres/)

I think the only requirement is a [Postgres installation](https://www.postgresql.org/download/), and an authentication to get into the Postgres database locally (some username and password)


## Notes

**Missing values automatically defaults to null**

From the documentation, *If no default value is declared explicitly, the null value is the default value. This usually makes sense because a null value can be thought to represent unknown data.* and so I think we just omit adding the `DEFAULT` command in the creation of the tables

**Year data is stored as `SMALLINT`**

The `DATE` type in Postgres has higher resolution up to the second, which is useless for our data as we would not make any complex calculations. `SMALLINT` with a check constraint between 0 and 2024 seems to suffice

**Minor changes in the column data types**

Used `CHECK` constraints for the allowable values (instead of `ENUM`). Also had to utilize `CHECK` constraints for number-related data types to assure a non-negative value since there are no unsigned types in Postgres