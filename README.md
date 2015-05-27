# Requirements

* PostgreSQL

# Setup

1. `cp config/database.yml.example config/database.yml`
* `bundle`
* `bundle exec rake db:setup`

# Assignments

Not everything is a must, please send your work back whenever you feel you've done enough.

1. Add many-to-many connection between `Operation` and `Category`.
* Add functionality to import operations from CSV file.
  * List of available companies are already in the database.
  * `company` column contains name of the company, that operations should be assigned to.
  * There should be no changes to `companies` table.
  * `categories` column contains list of categories separated by `;`.
  * Import should create missing categories on the fly.
  * Possible date formats are `MM/DD/YYYY`, `YYYY-MM-DD` and `DD-MM-YYYY`.
  * Example file can be downloaded [here](http://monterail-share.s3.amazonaws.com/ImporterAppExample.csv).
* Add view that will display all the data about operations in the context of the company.
  * It should be one view that display list of all the operations in the database visually grouped by company.
  ```
  Company A       |   [Company A stats]
  - Operation #1
  - Operation #2
  - Operation #3
  - Operation #4

  Company B       |   [Company B stats]
  - Operation #5
  - Operation #6
  - Operation #7
  - Operation #8
  ```
  * Information about company should include: number of the operations, average amount of operations, highest operation from the current month, number of operations with status `accepted`.
  * All the data have to be loaded asynchronously and rendered using javascript.
* Add file processing user feedback.
  * After uploading a file, user have to see the progress of parsing it.
  * Information for user should include: number of processed rows, number of successfuly imported rows, number of rows that failed import.
* Add possibility to filter displayed operations.
  * There should be single text input, that filter rows in all companies by status, kind, invoice_num and reporter.
* Add possibility to export operations from single company.
  * There should be button beside data about company that will let user download CSV file.
  * Rows in the file should contain the same data they had in the import file.
  * Operations in the file should be only the filtered ones.
