## Blue Onion Labs Code Challenge

This project is splitted in two parts, `blue_onion` which is the backend of the application and `blue_onion_client` which is the frontend of the application. 

## Backend

The backend was developed using Ruby on Rails and postgres as the database. I created two APIs described below.

* **CSV Import API:**
    * **Endpoint:** `[POST] /csv_imports/import_csv` 
    * **Description:** This API allows you to import data from a CSV file into the database.

* **Journal Entries API:**
  * **Endpoint:** `[GET] /journal_entries/entries_by_month?month=2023-02`
  * **Description:** This API retrieves journal entries for a specified month.

I created a few models to store the information from the CSV file. Initially, I modeled the `orders`, `payments`, and `items`. However, to avoid repeatedly computing orders, I introduced a `transaction_entry` model to store the processed data during ingestion. From my understanding, Blue Onion consolidates data from multiple sources into a single location. To align with this approach, I decided to create an API for CSV ingestion and handle the processing within it.

### Execution

To execute the project, you need to have `ruby` and `rails` installed, as well as `bundler` and a `postgres` db running locally. Then, execute the following.

```
cd blue_onion
bundle install
rails db:create
rails db:migrate
rails server
```

This is going to be executed in port `8000` 

### cURL examples

```
curl --location 'http://127.0.0.1:8000/csv_imports/import_csv' \
--form 'file=@"<path_to_file>/data.csv"'

curl --location 'http://127.0.0.1:8000/journal_entries/entries_by_month?month=2023-02'
```

## Frontend

The frontend was developed using react. I just created a SPA that shows the output of an API call to the backend to get the journal entries filtering by month, then I render the tables per each month, with the entries and then another table to render the totals for each account category

### Execution

To execute the project, you need to have `node` and `npm` installed, and then execute the following:

```
cd blue_onion_client
npm install
npm start
```

This is going to be executed in port `9000` 