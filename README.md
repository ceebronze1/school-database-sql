# School Database SQL Analysis

A SQL practice project built in SQL Server Management Studio (SSMS). It uses a small school database to practice joins, aggregation, and changing data safely.

Author: Cindy Afia Frimpong

## Database Structure

The database has four related tables:

| Table | Description |
| teachers | Teacher ID, name, and subject area |
| courses | Course ID, course name, and the teacher who teaches it |
| students | Student ID, name, and class (JHS 1, JHS 2, JHS 3) |
| scores | Each student's score in each course, by term |

The tables are linked by `student_id`, `course_id`, and `teacher_id`.

![Database diagram](diagram.png)

## Questions Covered

| # | Question | SQL Skills |
|---|----------|------------|
| 1 | Students in JHS 2 | SELECT, WHERE |
| 2 | Courses with teacher names | JOIN |
| 3 | Student count per class | COUNT, GROUP BY |
| 4 | Average score per course | JOIN, AVG, GROUP BY |
| 5 | Average score per student | JOIN, AVG, GROUP BY |
| 6 | Average score per class | JOIN, AVG, GROUP BY |
| 7 | Top 3 students by average score | TOP, ORDER BY |
| 8 | Teacher whose course has the lowest average | 3-table JOIN, AVG |
| 9 | Each student's scores with student and course names | Multiple JOINs |
| 10 | Correct a student's score | UPDATE with WHERE |
| 11 | Remove a student who left | DELETE with WHERE, foreign keys |
| 12 | Label each score as Pass or Fail | CASE WHEN |

## Key Findings (original data)

- Integrated Science had the highest course average (72.3) and ICT the lowest (65.1)
- Kojo Tetteh had the highest student average (83.3)
- JHS 3 had the highest class average (70.3) and JHS 2 the lowest (65.8)

## What I Learned

- How to connect tables with JOINs, including chaining three tables together
- How to summarize data with COUNT, AVG, and GROUP BY
- How to label data with CASE WHEN
- How to change data safely: always check the row first, use WHERE, and confirm afterwards
- Why child rows (scores) must be deleted before the parent row (student) because of foreign keys

## Notes

Questions 10 and 11 change the data. One score was corrected, and one student who left was removed along with their scores. Queries run after those steps give slightly different averages, so the findings above come from the original data.

## Files


- `school_practice.sql`: table creation, sample data, and all 12 queries with comments
- `diagram.png`: database diagram showing how the tables connected
