# Amazon_Vine_Analysis
## Deliverable 1
[Amazon Reviews Notebook](https://github.com/jzebker/Amazon_Vine_Analysis/blob/main/Amazon_Reviews_ETL.ipynb)
• the video games reviews data set (TSV) is read in as a DataFrame

    from pyspark import SparkFiles
    url = "https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Video_Games_v1_00.tsv.gz"
    spark.sparkContext.addFile(url)
    df = spark.read.option("encoding", "UTF-8").csv(SparkFiles.get("amazon_reviews_us_Video_Games_v1_00.tsv.gz"), sep="\t", header=True, inferSchema=True)
    df.show()
