# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* To upload the CSV file

curl --location 'http://127.0.0.1:8000/csv_imports/import_csv' \
--form 'file=@"<path_to_file>/data.csv"'

* To get the journal entries by month

curl --location 'http://127.0.0.1:8000/journal_entries/entries_by_month?month=2023-02'
