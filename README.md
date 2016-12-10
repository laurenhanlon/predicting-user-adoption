## Asana User Adoption

### Author

Lauren Hanlon

## About the data

For this analysis I will refer to dummy data given to me by Asana. The user table ([takehome_users](https://s3.amazonaws.com/asana-data/takehome_users.csv)) contains data on 12,000 users who signed up for the product in the last two years. The usage summary table ([takehome_user_engagement](https://s3.amazonaws.com/asana-data/takehome_user_engagement.csv)) has a row for each day that a user logged into the product.

## Goal

Defining an "adopted user" as a user who has logged into the product on three separate days in at least one seven-day period, identify which factors predict future user adoption.

## How to follow this project

1. Data is loaded into an ipython notebook `adopted-users.ipynb` which then relies on the functions in `python-script.py` to aggregate users into adopted users and non adopted users. Extra variables are also created for use in analysis. New table is saved as `adopted_users_extended.csv` within the _data_ folder.
2. `adopted_users_extended` table is then loaded into R where exploratory data analysis was conducted within `eda-script.R`. Images saved in _images_ folder. 
3. Linear models were built within `linear-modeling.R`. All data output is saved as `linear-modeling.RData` within _data_ folder.
4. A summary report is constructed from the output of these R scripts.

## File Structure

<pre><code>asana-interview/
README.md
code/
    adopted-users.ipynb
    python-script.py
    eda-script.R
    linear-modeling.R
data/
    takehome_user_engagement.csv
    takehome_user.csv
    adopted_users_extended.csv
    linear-modeling.RData
images/
    *.png
report/
    summary.Rmd
    summary.pdf
</code></pre>