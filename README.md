# Amazon_Vine_Analysis
## Deliverable 1
[Amazon Reviews Notebook](https://github.com/jzebker/Amazon_Vine_Analysis/blob/main/Amazon_Reviews_ETL.ipynb)

• the video games reviews data set (TSV) is read in as a DataFrame (Notebook cell 4)

    from pyspark import SparkFiles
    url = "https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Video_Games_v1_00.tsv.gz"
    spark.sparkContext.addFile(url)
    df = spark.read.option("encoding", "UTF-8").csv(SparkFiles.get("amazon_reviews_us_Video_Games_v1_00.tsv.gz"), sep="\t", header=True, inferSchema=True)
    df.show()
<p align="center"><img src="https://user-images.githubusercontent.com/84994321/135727569-3e9c9045-3a0a-49a6-b075-2717db502a4a.png"></p>

• the dataset is transformed into 4 DataFrames in cells 6-9

• the 4 DataFrames are loaded in pgAdmin in cells 11-14

## Deliverable 2 - using SQL in pgAdmin
[Queries](https://github.com/jzebker/Amazon_Vine_Analysis/blob/main/vine_review_analysis.sql)

• vine_table is created

<p align="center"><img src="https://github.com/jzebker/Amazon_Vine_Analysis/blob/main/img/d2VineTable.png?raw=true"></p>

• totalVotes20 table is created from vine_table

    CREATE TABLE totalVotes20 AS
	SELECT *
	FROM vine_table
	WHERE total_votes>=20;

• helpfulReviews table is created - only reviews with >20 votes were considered for helpfulReviews
    
    CREATE TABLE helpfulReviews AS
	SELECT *
	FROM totalVotes20
	WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

• helpfulReviewsVine table is created - only "helpful" reviews were considered for vine

    CREATE TABLE helpfulReviewsVine AS
	SELECT *
	FROM helpfulReviews
	WHERE vine='Y';
    
• helpfulReviewsNotVine table is created - only "helpful" reviews were considered for not vine

    CREATE TABLE helpfulReviewsNotVine AS
	SELECT *
	FROM helpfulReviews
	WHERE vine='N';

• requested calculations were performed on reviews deemed "helpful"

<p align="center"><img src="https://github.com/jzebker/Amazon_Vine_Analysis/blob/main/img/d2VineCalculated.png?raw=true"></p>

## Deliverable 3
### Overview
Since your work with Jennifer on the SellBy project was so successful, you’ve been tasked with another, larger project: analyzing Amazon reviews written by members of the paid Amazon Vine program. The Amazon Vine program is a service that allows manufacturers and publishers to receive reviews for their products. Companies like SellBy pay a small fee to Amazon and provide products to Amazon Vine members, who are then required to publish a review.

In this project, you’ll have access to approximately 50 datasets. Each one contains reviews of a specific product, from clothing apparel to wireless products. You’ll need to pick one of these datasets and use PySpark to perform the ETL process to extract the dataset, transform the data, connect to an AWS RDS instance, and load the transformed data into pgAdmin. Next, you’ll use PySpark, Pandas, or SQL to determine if there is any bias toward favorable reviews from Vine members in your dataset. Then, you’ll write a summary of the analysis for Jennifer to submit to the SellBy stakeholders.

### Results
How many Vine reviews and non-Vine reviews were there?

• there were ***94 total Vine reviews*** categorized as helpful

• there were ***40,471 total non-Vine reviews*** categorized as helpful

How many Vine reviews were 5 stars? How many non-Vine reviews were 5 stars?

• there were ***48 total Vine reviews*** categorized as helpful

• there were ***15,663 total non-Vine reviews*** categorized as helpful

What percentage of Vine reviews were 5 stars? What percentage of non-Vine reviews were 5 stars?

• ***51%*** of Vine reviews categorized as helpful were 5-stars

• ***39%*** of non-Vine reviews categorized as helpful were 5-stars

### Summary
I cannot conclude whether or not there is a bias for reviews from the Vine program based on the results above.  For this data set, Vine reviewers left "helpful" 5-star reviews 12% more often than non-Vine reviewers.  However, there is nothing to indicate why this is and only that a discrepancy exists.  In the absence of definintive proof, I am inclined to say there is no bias in reviews.  A deeper, product-level analysis may reveal more clues.
