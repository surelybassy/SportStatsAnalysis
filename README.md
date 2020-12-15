# Sport Statistics Analysis
## Andrew Ashdown
### *December 2020*

Project exploring Data Collection, Visualisation and Analysis of Sports Statistics.


## Project Outline

I wanted to explore the world of Sport Statistics and specifically focus on my favourite club, the mighty Leeds United. There is a huge amount of data recorded on all aspects of the sport, from overall match statistics down to the specific body part used to score goals. My initial plan was to collect a large amount of data on the club and sport as a whole, clean it and use it to build a database in MySQL. With the database built, I would write I number of queries to deliver specific and useful insight into how the team is performing and use Tableau to create a dashboard to visualise the data. With a large amount of data recorded and processed, I would attempt to answer a number of statistical questions related to the sport.

![Project Outline](Images/FinalProjectDiagram.png?raw=true "Project Outline")


## The Data

With a large amount of data available, I explored a number of different sources that I could use to collect it. There are a number of sports statistics APIs, but many of the better ones require a paid licence key. I found the best sources for data were smaller, independent websites, where data scraping was trouble free and some even offer CSV files for direct download. Kaggle also had several large datasets with historical statistics from football matches around the world.

Using Python I was able to automate the process of collecting and combining data from numerous pages. I scraped a number of different tables into Pandas Dataframes and the began to explore and clean the data. After gathering information that I thought was the most useful and relevant, I exported the clean dataframes to CSV files to be used for further analysis in SQL and Tableau.

[Jupyter Notebooks can be found here.](https://github.com/surelybassy/SportStatsAnalysis/tree/master/JupyterNotebooks)


## The Database

Reviewing the feautres in the data collected and thinking about how to link it together, I designed an ERD for how I wanted my database to look and act. Using MySQL, I created a new schema, and imported the six CSV files created in Python and continued further investigation and analysis.

![ERD Design](Images/LeedsUnitedDatabase.png?raw=true "ERD Design")

## Visualisation

Using Tableau I was able to easily visualise different aspects of the team's performance and focus on how individual players were performing in different areas. I spent lots of time experimenting with different and creative ways to display the numerous features in the data and created several interactive dashboards. 

[The final Tableau story can be found here.](https://public.tableau.com/profile/andrew.ashdown#!/vizhome/SportStatisticsAnalysis/LeedsStatsStory)

![Dashboards](Images/Dashboards.png?raw=true "Tableau Dashboards")

## Statistical Analysis

With lots of data collected and stored, I attempted to answer a number of statistical question.

***1. Can you predict the total amount of goals a team will score in a season based on statistics from the games played?***

Using data from past Premier League seasons, I used a number of different regression models to try to predict the total amount of goals scored by a team. I found that I acheived the best accuracy using the Scikit-Learn Linear Regressor, giving a score of 88%.

[The Jupyter Notebook can be found here.](https://github.com/surelybassy/SportStatsAnalysis/blob/master/JupyterNotebooks/TotalGoalsPrediction.ipynb)

![Python Data Analysis](Images/PythonAnalysis.png?raw=true "Python Data Analysis")


***2. With the introduction of VAR, will we see an increase in the amount of penalties awarded?***

![Hypothesis testing](Images/HypothesisFormula.png?raw=true "Hypothesis Testing")

***3. With Corona regulations barring fans from entering stadium, will we still see a home ground advantage?***

Maybe so, maybe no!

## Delivering Insight

With a large amount of data collected, I wanted to create a tool used to deliver it to the public. Building an API server in Python, using the Flask library, I was able to create a number of routes that ran different queries on my database and rendered the results back to the user on a HTML page.

## Review
