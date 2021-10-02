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
