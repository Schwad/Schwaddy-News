# Schwaddy-News
HackerNews Style Aggregator of tech and development news.

Runs a rake task several times a day to update stories. 250 stories at a time.

productionerror:
ActiveRecord::StatementInvalid: PG::UndefinedTable: ERROR:  relation "stories" does not exist

LINE 1: SELECT "stories".* FROM "stories"

Next steps:

-add scraping for remainder of pages
-include in rake task
-developing sorting formula and have heroku scheduler activated
-update display w/ header/footer
-general styling (donate button)
-allow embedding of schwaddynews

-after it's all good do same for jobs page


Include a tech jobs page:

- https://www.reddit.com/r/forhire/search?q=title%3A%27%5Bhiring%5D%27+OR+flair%3AHiring+reddit%3Aforhire+OR+reddit%3Ajobbit+OR+reddit%3A%3Ajobopenings&sort=new&t=all
-https://weworkremotely.com/
-




Sites to be included & notes

-https://news.ycombinator.com/ (30)
-http://longform.org/ (10)
-https://www.reddit.com/r/compsci/ (24)
-http://slashdot.org/recent (15)
-http://www.theregister.co.uk/ (10)
-https://thebrowser.com/ (5)
-http://thefeature.net/ (8)
-http://www.techmeme.com/river (70)
-https://www.reddit.com/r/webdev (25)
