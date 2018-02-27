
This data set assumes you have PSQL installed. To install,
create a database to hold the data. Let's call this database

olympics

Then, in Unix prompt, run the load data script:

psql olympics -f load_data.sql

You can then use the database:

psql olympics
