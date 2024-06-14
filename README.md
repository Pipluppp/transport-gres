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

**Import and cleanup of `route_data.csv`**

Took the data from the LTFRB NCR Jeepney routes. Separated the route name into start route and end route by splitting across the dash from the name (dropped route names without an indicated dash)

```
-- SELECT * FROM routes;

 route_id |        start_route        |               end_route               | route_length | base_fare
----------+---------------------------+---------------------------------------+--------------+-----------
 NCR-A01  | AFP/PNP HOUSING TERM(TAG) | GUADALUPE V MRT                       |            7 |        13
 NCR-A02  | AFP/PNP(TAGUIG)           | GUADALUPE (ABC) VIA M. ASUN           |            8 |        13
 NCR-A03  | ALABANG                   | B'BAYAN VIA BICUTAN FTI SSH LOOP      |           10 |        13
 NCR-A04  | ALABANG                   | BAGUMBAYAN VIA BICUTAN                |            8 |        13
 NCR-A05  | ALABANG                   | BACLARAN VIA COASTAL                  |           10 |        13
 NCR-A06  | ALABANG                   | BACLARAN COASTAL                      |            5 |        13
 NCR-A07  | ALABANG                   | BACLARAN VIA SAN DIONISIO ZAPOTE      |            6 |        13
 NCR-A08  | ALABANG                   | BACLARAN VIASN DIONISIO ZAPOTE        |           10 |        13
 NCR-A09  | BACLARAN                  | ALABANG VIA SAN DIONISIO              |            6 |        13
 NCR-A10  | ALABANG                   | BACLARAN VIA SAN DIONISIO             |            4 |        13
 ...
 (770 rows)
```