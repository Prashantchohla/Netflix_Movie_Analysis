# Netflix_Movie_Analysis
Analysis of NETFLIX movie data

Overview

This project focuses on an in-depth examination of Netflix's movies and TV shows dataset using SQL. The primary aim is to uncover meaningful insights and address various business-related questions derived from the data. This README outlines the project's goals, business challenges, proposed solutions, key insights, and overall conclusions.

Objectives

Examine the proportion of content types, such as movies and TV shows.
Determine the most frequently assigned ratings for both movies and TV shows.
Review and evaluate content by release years, production countries, and runtime.
Investigate and classify content based on defined keywords and categories.

Schema

DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
