-- Query 2: Calculated hours per teacher per course instance
SELECT
    course_code,
    instance_id,
    hp,
    teacher_name,
    designation,
    lecture_hours,
    tutorial_hours,
    lab_hours,
    seminar_hours,
    total_hours
FROM mv_teacher_allocations
ORDER BY instance_id, teacher_name;

-- Query 3: Total hours for a teacher
SELECT
    course_code,
    instance_id,
    hp,
    study_period,
    teacher_name,
    lecture_hours,
    tutorial_hours,
    lab_hours,
    seminar_hours,
    total_hours
FROM mv_teacher_allocations
WHERE study_year = '2025-01-01'
  AND employee_id = 'EMP003'
ORDER BY study_period;

-- Query 4: Teachers teaching more than N course instances
SELECT
    employee_id,
    teacher_name,
    study_period,
    COUNT(DISTINCT instance_id) AS num_courses
FROM mv_teacher_allocations
WHERE study_year = '2025-01-01'
GROUP BY 
    employee_id, teacher_name, study_period
HAVING COUNT(DISTINCT instance_id) > 1
ORDER BY num_courses DESC;