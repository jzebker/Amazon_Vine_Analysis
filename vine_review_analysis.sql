CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

SELECT * FROM vine_table;

CREATE TABLE totalVotes20 AS
	SELECT *
	FROM vine_table
	WHERE total_votes>=20;
	
SELECT * FROM totalVotes20;

CREATE TABLE helpfulReviews AS
	SELECT *
	FROM totalVotes20
	WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

SELECT * FROM helpfulReviews;

CREATE TABLE helpfulReviewsVine AS
	SELECT *
	FROM helpfulReviews
	WHERE vine='Y';

SELECT * FROM helpfulReviewsVine;

CREATE TABLE helpfulReviewsNotVine AS
	SELECT *
	FROM helpfulReviews
	WHERE vine='N';

SELECT * FROM helpfulReviewsNotVine;

SELECT count(review_id) FROM helpfulReviews;
SELECT count(review_id) FROM helpfulReviewsVine;
SELECT count(review_id) FROM helpfulReviewsNotVine;

SELECT count(review_id) AS "5-Star Reviews" FROM helpfulReviewsVine
WHERE star_rating=5;

SELECT count(review_id) AS "5-Star Reviews" FROM helpfulReviewsNotVine
WHERE star_rating=5;

SELECT vine,COUNT(review_id) AS "5 Star Reviews",
CASE 
	WHEN vine='Y' THEN (SELECT count(review_id) FROM helpfulReviews WHERE vine='Y')
	WHEN vine='N' THEN (SELECT count(review_id) FROM helpfulReviews WHERE vine='N')
END AS "Total Reviews",
CAST(CAST(COUNT(review_id) AS FLOAT)/CAST(CASE 
	WHEN vine='Y' THEN (SELECT count(review_id) FROM helpfulReviews WHERE vine='Y')
	WHEN vine='N' THEN (SELECT count(review_id) FROM helpfulReviews WHERE vine='N')
END AS FLOAT) AS DEC(2,2)) AS "Percentage"
FROM helpfulReviews
WHERE star_rating=5
GROUP BY vine
ORDER BY vine DESC;
