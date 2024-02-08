import dlt
import duckdb

"""
1. Use a generator
Remember the concept of generator? Let's practice using them to futher our understanding of how they work.

Let's define a generator and then run it as practice.

Answer the following questions:

Question 1: What is the sum of the outputs of the generator for limit = 5?
Question 2: What is the 13th number yielded
"""


def square_root_generator(limit):
    # This generator yields the square root of numbers from 1 to `limit`.
    n = 1
    while n <= limit:
        yield n ** 0.5
        n += 1


# Question 1: What is the sum of the outputs of the generator for limit = 5?
generator = square_root_generator(limit=5)
print('Sum of 5 items = ', sum(generator))

# Question 2. What is the 13th number yielded by the generator?
generator = square_root_generator(limit=13)

for index, number in enumerate(generator, start=1):
    if index == 13:
        print('Index: ', index, ' number: ', number)
        break


"""
2. Append a generator to a table with existing data
Below you have 2 generators. You will be tasked to load them to duckdb and answer some questions from the data

Load the first generator and calculate the sum of ages of all people. Make sure to only load it once.
Append the second generator to the same table as the first.
After correctly appending the data, calculate the sum of all ages of people.
"""


def people_1():
    # This generator yields dictionaries representing people from City_A.
    for i in range(1, 6):
        yield {"ID": i, "Name": f"Person_{i}", "Age": 25 + i, "City": "City_A"}


def people_2():
    # This generator yields dictionaries representing people from City_B with an additional "Occupation" field.
    for i in range(3, 9):
        yield {"ID": i, "Name": f"Person_{i}", "Age": 30 + i, "City": "City_B", "Occupation": f"Job_{i}"}


# Initialize a DLT pipeline to load data into DuckDB, starting with people_1 generator.
dlt_pipeline = dlt.pipeline(destination='duckdb', dataset_name='people_dataset', full_refresh=True)
dlt_pipeline.run(people_1(), table_name='people', write_disposition="replace")

# Append data from the people_2 generator to the same table.
dlt_pipeline.run(people_2(), table_name='people', write_disposition="append")

# Connect to DuckDB and calculate the sum of ages of all people in the "people" table.
table_name = f"{dlt_pipeline.dataset_name}.people"
conn = duckdb.connect(f"{dlt_pipeline.pipeline_name}.duckdb")
print('Sum of all ages of people: ', conn.sql(f"SELECT * FROM {table_name}").df()['age'].sum())


"""
3. Merge a generator
Re-use the generators from Exercise 2.

A table's primary key needs to be created from the start, so load your data to a new table with primary key ID.

Load your first generator first, and then load the second one with merge. Since they have overlapping IDs, 
some of the records from the first load should be replaced by the ones from the second load.

After loading, you should have a total of 8 records, and ID 3 should have age 33.

Question: Calculate the sum of ages of all the people loaded as described above.
"""

# Re-initialize the DLT pipeline for a fresh start and specify a primary key for merge operation.
dlt_pipeline = dlt.pipeline(destination='duckdb', dataset_name='people_dataset', full_refresh=True)
dlt_pipeline.run(people_1(), table_name='people', write_disposition="replace", primary_key='ID')
dlt_pipeline.run(people_2(), table_name='people', write_disposition="merge", primary_key='ID')

# After merging, verify the total records, check the age of ID 3, and calculate the sum of ages again.
table_name = f"{dlt_pipeline.dataset_name}.people"
print('Total rows: ', len(conn.sql(f"SELECT * FROM {table_name}").df()))
print('ID 3 have age :', conn.sql(f"SELECT age FROM {table_name} WHERE ID = 3").df()['age'][0])
print('Sum of all ages of people: ', conn.sql(f"SELECT * FROM {table_name}").df()['age'].sum())
# Alternative way to calculate the sum of ages using SQL aggregation.
print('Sum of all ages of people: ', conn.sql(f"SELECT sum(age) FROM {table_name}").fetchall())
