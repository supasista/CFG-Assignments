-- IrokoTV wants to manage its Nigerian movie streaming service by storing and managing information about movies, users, and movie views.
-- I want to help IrokoTV by creating a database with the following tables to solve this problem:

-- Movies:
-- movie_id
-- title
-- genre
-- release_year

-- Users:
-- user_id
-- first_name
-- last_name
-- email
-- subscription_type

-- Movie Views:
-- view_id
-- user_id
-- movie_id
-- view_date
-- device

-- I will write SQL queries to add, retrieve, and delete data. I will also use aggregate functions to generate statistics, such as total views per movie.
-- I will connect the tables using primary and foreign keys, with appropriate constraints and data types.
-- I will also normalise the database.


CREATE DATABASE irokomovies_database;
-- Create movies table
CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    release_year INT
);

-- Create users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    subscription_type ENUM('free', 'premium') DEFAULT 'free'
);

-- Create movie_views table
CREATE TABLE movie_views (
    view_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    view_date DATE,
    device VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- Insert mock data into movies table
INSERT INTO movies (title, genre, release_year)
VALUES
    ('King of Boys', 'Drama', 2018),
    ('The Wedding Party', 'Romance', 2016),
    ('Living in Bondage', 'Thriller', 1992),
    ('Merry Men: The Real Yoruba Demons', 'Comedy', 2018),
    ('The Figurine', 'Drama', 2009),
    ('October 1', 'Thriller', 2014),
    ('76', 'Drama', 2016),
    ('Phone Swap', 'Romance', 2012);

-- Insert mock data into users table
INSERT INTO users (first_name, last_name, email, subscription_type)
VALUES
    ('Bimpe', 'Adegbite', 'bimpeadegbite@test.com', 'premium'),
    ('Nneka', 'Mgbatogu', 'nekkybabes@test.com', 'free'),
    ('Chris', 'Okonkwo', 'chrisokonkwo@test.com', 'premium'),
    ('Abike', 'Johnson', 'michaeljohnson@test.com', 'premium'),
    ('Laide', 'Onam', 'laideonam@test.com', 'free'),
    ('Tope', 'Adisa', 'topeadisa@test.com', 'free'),
    ('Harleemah', 'Anyene', 'harleemahanyene@test.com', 'free'),
    ('Olivia', 'Alao', 'oalao@test.com', 'free');

-- Insert mock data into movie_views table
INSERT INTO movie_views (user_id, movie_id, view_date, device)
VALUES
    (1, 1, '2024-06-15', 'Desktop'),
    (2, 3, '2024-06-14', 'Smartphone'),
    (3, 2, '2024-06-13', 'Tablet'),
    (1, 4, '2024-06-12', 'Smart TV');
-- Insert a new movie record
INSERT INTO movies (title, genre, release_year)
VALUES ('The Black Book', 'Thriller', 2023);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

ALTER TABLE movies
ADD COLUMN genre_id INT,
ADD CONSTRAINT fk_genre_id
    FOREIGN KEY (genre_id)
    REFERENCES genres(genre_id);

-- Ensure foreign key constraint for movie_views.user_id
ALTER TABLE movie_views
ADD CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES users(user_id);

-- Ensure foreign key constraint for movie_views.movie_id
ALTER TABLE movie_views
ADD CONSTRAINT fk_movie_id
    FOREIGN KEY (movie_id)
    REFERENCES movies(movie_id);

SELECT m.title, g.genre_name
FROM movies m
JOIN genres g ON m.genre_id = g.genre_id;

SELECT u.first_name, u.last_name, mv.view_date
FROM users u
JOIN movie_views mv ON u.user_id = mv.user_id
JOIN movies m ON mv.movie_id = m.movie_id
WHERE m.title = 'The Black Book';

SELECT g.genre_name, COUNT(mv.view_id) AS total_views
FROM genres g
JOIN movies m ON g.genre_id = m.genre_id
LEFT JOIN movie_views mv ON m.movie_id = mv.movie_id
GROUP BY g.genre_name;
