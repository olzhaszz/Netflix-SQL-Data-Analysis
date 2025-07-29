# Netflix-SQL-Data-Analysis

This project explores and analyzes the Netflix Titles Dataset using SQL Server. It contains a series of practical SQL queries designed to extract insights from Netflix's content catalog, such as trends in genre, country, actor appearances, content types, and more.

🔍 Features & Questions Answered
Total content per country

TV shows with more than 5 seasons

Documentaries and movies by specific directors

Content release trends over the last 5 and 10 years

Top genres and actor participation

Classification of content by keywords like "kill" and "violence"

🧠 Key Concepts Used

string_split and cross apply for splitting comma-separated values

try_cast and dateadd for safe type conversion and date operations

Aggregations using group by, count, top, and order by

Text search with like and conditional categorization using case when


💾 Dataset Info

Source: Kaggle - Netflix Titles

Format: CSV file, imported into SQL Server

Main columns: type, title, director, cast, country, release_year, date_added, listed_in, description


🛠 How to Use

Import the CSV into SQL Server (e.g., using SQL Server Management Studio).

Run each query individually to explore different insights.

Customize filters (e.g., country, actor, genre) as needed for deeper analysis.


📁 Folder Structure (if applicable)
bash

Copy code

/sql-queries

  ├── top_countries.sql
  
  ├── tv_shows_seasons.sql
  
  ├── director_filter.sql
  
  ├── actor_analysis.sql
  
  ├── content_categorization.sql
  
  └── ...

  
📌 Requirements

Microsoft SQL Server 2017 or later

SQL Server Management Studio (SSMS) or Azure Data Studio

Netflix Titles CSV dataset


📈 Future Improvements

Power BI or Tableau visualization

ETL automation with Python

Deployment to Azure SQL Database




🧑‍💻 Author
Olzhas

GitHub Profile: @olzhaszz

Feel free to contribute or raise issues!
