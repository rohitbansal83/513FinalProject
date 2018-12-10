# CS513 Data Cleaning Final Project

# Team: 

Rohit Bansal (rbansal3@illinois.edu) 

Parul Mainwal (mainwal2@illinois.edu)


# Objective:

In the project we performed data cleaning operations on NYPL_DataSet using various tools like pythong scripts, Open Refine, SQLite, Yes Workflow. Objective was to clean the data to a point that it can be loaded into the database and some basic data analysis could be performed. The goal of our cleaning process is to have it clean enough to be able to support basic user queries like menu structure, popularity of a dish over time etc. We also decided to make the clean data available via public tableau dashboards.


We did not intend to remove the ambiguity in the data. We did not want to remove ambiguity by making assumptions. For example, if we found an item as omelette 1 and omelette 2 then we did not try to merge it to “omelette”. The reason behind that was that these two could be a variant of omelette with different ingredient and sometime different size of servings.  Assuming them to represent one dish could hamper the data integrity.

# Data Source: 

NYPL_DataSet (New York Public Library’s crowd-sourced historical menus dataset)

# Resources:

Python	3.6.0	

OpenRefine	2.6-rc.2

SQLiteStudio	3.2.1	

YesWorkflow	http://try.yesworkflow.org/

Tableau	2018.1.2	

Vertabelo 	https://my.vertabelo.com/

# Results:

The cleaned data can be accessed @ 
https://public.tableau.com/profile/rohit.bansal#!/vizhome/ComparisonNYPLDataset/Comparison

