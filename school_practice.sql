/*
Project: School Database
Author: Cindy Afia Frimpong
Database: SchoolPractice (Microsoft SQL Server)
Goal: Design and build a small school database from scratch, add data to it,
      change it, and answer questions about students, courses, teachers and scores.
Tables: teachers, courses, students, scores
*/



CREATE DATABASE SchoolPractice;

-- Step 1: Create the teachers table
-- Each teacher has a unique ID (primary key), a name and the subject they teach
CREATE TABLE teachers (
      teacher_id INT PRIMARY KEY,
	  teacher_name VARCHAR (100),
	  subject VARCHAR (50)
	  );

-- Step 2: Create the courses table
-- Each course has a unique ID and a name
-- teacher_id is a foreign key that links each course to a teacher in the teachers table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
	teachers_id INT FOREIGN KEY REFERENCES teachers(teacher_id)
	);

-- Step 3: Create the students table
-- Each student has a unique ID (primary key), a name, a class and a gender
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    class VARCHAR(20),
    gender VARCHAR(10)
);

-- Step 4: Create the scores table
-- Each score has a unique ID, the student who earned it, the course it belongs to, the term and the score
-- student_id and course_id are foreign keys that link to the students and courses tables
CREATE TABLE scores (
    score_id INT PRIMARY KEY,
    student_id INT FOREIGN KEY REFERENCES students(student_id),
    course_id INT FOREIGN KEY REFERENCES courses(course_id),
    term VARCHAR(20),
    score INT
	);
SELECT name FROM sys.tables;

SELECT * FROM teachers;

-- Step 5: Add teachers
INSERT INTO teachers VALUES
(191,'Mr. Amoah','Mathematics'),
(243,'Mrs. Agyeman','English'),
(391,'Mr. Danso','Science'),
(428,'Ms. Sarpong','ICT');

-- Step 6: Add courses
-- teacher_id links each course to a teacher
INSERT INTO courses VALUES
(1101,'Mathematics',191),
(1104,'English',243),
(3654,'Integrated Science',391),
(4907,'ICT',428);

SELECT * FROM courses;

-- Remove the old rows (courses first, because it depends on teachers)
DELETE FROM courses;
DELETE FROM teachers;

-- Step 7: Add students (realistic student IDs)
INSERT INTO students VALUES
(2026001,'Kwame Mensah','JHS 1','Male'),
(2026002,'Ama Owusu','JHS 1','Female'),
(2026003,'Kofi Boateng','JHS 2','Male'),
(2026004,'Akosua Asante','JHS 2','Female'),
(2026005,'Yaw Appiah','JHS 3','Male'),
(2026006,'Abena Addo','JHS 3','Female'),
(2026007,'Kojo Tetteh','JHS 1','Male'),
(2026008,'Efua Quaye','JHS 2','Female'),
(2026009,'Nana Darko','JHS 3','Male'),
(2026010,'Esi Ofori','JHS 1','Female');

-- Step 8: Add scores
-- Each row links a student to a course with a term and a score
-- Course IDs: 1101 Mathematics, 1104 English, 3654 Integrated Science, 4907 ICT
INSERT INTO scores VALUES
(1,2026001,1101,'Term 1',67),
(2,2026001,1104,'Term 1',92),
(3,2026001,3654,'Term 1',94),
(4,2026001,4907,'Term 1',56),
(5,2026002,1101,'Term 1',68),
(6,2026002,1104,'Term 1',82),
(7,2026002,3654,'Term 1',53),
(8,2026002,4907,'Term 1',81),
(9,2026003,1101,'Term 1',55),
(10,2026003,1104,'Term 1',69),
(11,2026003,3654,'Term 1',84),
(12,2026003,4907,'Term 1',62),
(13,2026004,1101,'Term 1',69),
(14,2026004,1104,'Term 1',66),
(15,2026004,3654,'Term 1',85),
(16,2026004,4907,'Term 1',65),
(17,2026005,1101,'Term 1',88),
(18,2026005,1104,'Term 1',65),
(19,2026005,3654,'Term 1',67),
(20,2026005,4907,'Term 1',68),
(21,2026006,1101,'Term 1',76),
(22,2026006,1104,'Term 1',75),
(23,2026006,3654,'Term 1',73),
(24,2026006,4907,'Term 1',93),
(25,2026007,1101,'Term 1',86),
(26,2026007,1104,'Term 1',86),
(27,2026007,3654,'Term 1',82),
(28,2026007,4907,'Term 1',79),
(29,2026008,1101,'Term 1',52),
(30,2026008,1104,'Term 1',79),
(31,2026008,3654,'Term 1',57),
(32,2026008,4907,'Term 1',47),
(33,2026009,1101,'Term 1',69),
(34,2026009,1104,'Term 1',40),
(35,2026009,3654,'Term 1',70),
(36,2026009,4907,'Term 1',59),
(37,2026010,1101,'Term 1',44),
(38,2026010,1104,'Term 1',41),
(39,2026010,3654,'Term 1',58),
(40,2026010,4907,'Term 1',41);
-- Each row follows the column order: score_id (unique ID), student_id (the student), course_id (the course), term, score (out of 100)

-- School Q1: List all students in JHS 2
-- Uses WHERE to filter the students table by class
SELECT * FROM students
WHERE class = 'JHS 2';

-- School Q2: Show each course with its teacher's name
-- Joins courses to teachers using teacher_id, because the name is in teachers and the course is in courses
SELECT c.course_id, c.course_name, t.teacher_name
FROM courses c
JOIN teachers t ON c.teachers_id = t.teacher_id;

-- School Q3: How many students are in each class?
-- Uses GROUP BY class to make one row per class, and COUNT(*) to count the students in each
SELECT class, COUNT(*) AS number_of_students
FROM students
GROUP BY class;

-- School Q4: Average score for each course
SELECT c.course_name, ROUND(AVG(s.score * 1.0), 1) AS average_score
FROM scores s
JOIN courses c ON s.course_id = c.course_id
GROUP BY c.course_name
ORDER BY average_score DESC;

-- School Q5: What is the average score for each student?
-- Joins scores to students to get each name, groups the scores by student, and uses AVG to find each student's mean score
-- Finding: Kojo Tetteh has the highest average (83.3) and Esi Ofori has the lowest (46.0), the only student below 50

SELECT st.student_name, ROUND(AVG(s.score * 1.0), 1) AS average_score
FROM scores s
JOIN students st ON s.student_id = st.student_id
GROUP BY st.student_id, st.student_name
ORDER BY average_score DESC;

-- School Q6: Which class has the highest average score?
-- scores has no class column, so students is joined to get it
-- Joins scores to students to get each student's class, groups the scores by class, and uses AVG to find the mean score in each class
SELECT st.class, ROUND(AVG(s.score * 1.0), 1) AS average_score
FROM scores s
JOIN students st ON s.student_id = st.student_id
GROUP BY st.class
ORDER BY average_score DESC;

-- School Q7: Who are the top 3 students by average score?
-- Joins scores to students, groups the scores by student, and uses AVG to find each mean score
-- TOP 3 keeps only the three highest averages after sorting
SELECT TOP 3 st.student_name, ROUND(AVG(s.score * 1.0), 1) AS average_score
FROM scores s
JOIN students st ON s.student_id = st.student_id
GROUP BY st.student_id, st.student_name
ORDER BY average_score DESC;
-- Finding: Kojo Tetteh (83.3), Abena Addo (79.3) and Kwame Mensah (77.3) are the top 3 students
-- School Q8: Which teacher's course has the lowest average score?
-- Joins scores to courses, then courses to teachers, groups the scores by teacher and course, and uses AVG to find the mean score
-- TOP 1 with ORDER BY ascending keeps only the lowest average

--School Q8: Which teacher's course has the lowest average score?
-- Joins scores to courses, then courses to teachers, groups the scores by teacher and course, and uses AVG to find the mean score
-- TOP 1 with ORDER BY ascending keeps only the lowest average
SELECT TOP 1 t.teacher_name, c.course_name, ROUND(AVG(s.score * 1.0), 1) AS average_score
FROM scores s
JOIN courses c ON s.course_id = c.course_id
JOIN teachers t ON c.teachers_id = t.teacher_id
GROUP BY t.teacher_id, t.teacher_name, c.course_id, c.course_name
ORDER BY average_score ASC;
-- Finding: Ms. Sarpong, who teaches ICT, has the lowest course average at 65.1

-- School Q9: What are each student's scores, with their name and course name?
-- Joins scores to students to get the student name and class, then joins scores to courses to get the course name
-- ORDER BY sorts the rows by student name, then by course name, so each student's scores sit together
SELECT st.student_name, st.class, c.course_name, s.term, s.score
FROM scores s
JOIN students st ON s.student_id = st.student_id
JOIN courses c ON s.course_id = c.course_id
ORDER BY st.student_name, c.course_name;
-- Finding: The query returns 40 rows, one for each student's score in each of the 4 courses, with the student's name and course name instead of IDs

-- School Q10: Update one student's score after a correction
-- First checks the current score, then uses UPDATE with WHERE so that only this one row changes
-- A final SELECT confirms that the new score was saved

-- Step 1: see the row before changing it
SELECT * FROM scores
WHERE student_id = 2026001 AND course_id = 1101 AND term = 'Term 1';

-- Step 2: change the score
UPDATE scores
SET score = 85
WHERE student_id = 2026001 AND course_id = 1101 AND term = 'Term 1';

-- Step 3: confirm the change
SELECT * FROM scores
WHERE student_id = 2026001 AND course_id = 1101 AND term = 'Term 1';


-- School Q11: Delete a student who left the school
-- Deletes the student's scores first because scores depends on students (foreign key), then deletes the student row
-- Both DELETE statements use WHERE so that only this one student is removed

-- Step 1: see the student and their scores before deleting
SELECT * FROM students WHERE student_id = 2026010;
SELECT * FROM scores WHERE student_id = 2026010;

-- Step 2: delete the scores first
DELETE FROM scores
WHERE student_id = 2026010;

-- Step 3: now delete the student
DELETE FROM students
WHERE student_id = 2026010;

-- Step 4: confirm the student is gone
SELECT * FROM students WHERE student_id = 2026010;
SELECT * FROM scores WHERE student_id = 2026010;

-- Finding: Student 2026010 and their 4 scores were removed, and no other students were affected

-- School Q11: Delete a student who left the school
-- Deletes the student's scores first because scores depends on students (foreign key), then deletes the student row
-- Both DELETE statements use WHERE so that only this one student is removed

-- Step 1: see the student and their scores before deleting
SELECT * FROM students WHERE student_id = 2026010;
SELECT * FROM scores WHERE student_id = 2026010;

-- Step 2: delete the scores first
DELETE FROM scores
WHERE student_id = 2026010;

-- Step 3: now delete the student
DELETE FROM students
WHERE student_id = 2026010;

-- Step 4: confirm the student is gone
SELECT * FROM students WHERE student_id = 2026010;
SELECT * FROM scores WHERE student_id = 2026010;
-- Finding: Student 2026010 and their 4 scores were removed, and no other students were affected

-- Step 2: delete the scores first
DELETE FROM scores
WHERE student_id = 2026010;

-- Step 3: now delete the student
DELETE FROM students
WHERE student_id = 2026010;

-- Step 4: confirm the student is gone
SELECT * FROM students WHERE student_id = 2026010;
SELECT * FROM scores WHERE student_id = 2026010;
-- Finding: Student 2026010 and their 4 scores were removed, and no other students were affected

-- School Q12: Label each score as Pass or Fail
-- Joins scores to students and courses to show names, then uses CASE WHEN to label each score as Pass (50 and above) or Fail (below 50)
-- ORDER BY sorts the rows by student name, then by course name
SELECT st.student_name, c.course_name, s.score,
       CASE
           WHEN s.score >= 50 THEN 'Pass'
           ELSE 'Fail'
       END AS result
FROM scores s
JOIN students st ON s.student_id = st.student_id
JOIN courses c ON s.course_id = c.course_id
ORDER BY st.student_name, c.course_name;

-- Finding: Every score is labeled Pass or Fail, and the low scores (below 50) show as Fail