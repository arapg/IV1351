-- Query 1: Planned hours per course instance
SELECT 
    ci.course_code,
    ci.instance_id,
    cl.hp,
    ci.study_period AS period,
    ci.num_students,
    
    SUM(CASE WHEN ta.activity_type = 'Lecture' THEN pa.planned_hours * ta.factor ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN ta.activity_type = 'Tutorial' THEN pa.planned_hours * ta.factor ELSE 0 END) AS tutorial_hours,
    SUM(CASE WHEN ta.activity_type = 'Lab' THEN pa.planned_hours * ta.factor ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN ta.activity_type = 'Seminar' THEN pa.planned_hours * ta.factor ELSE 0 END) AS seminar_hours,
    
    SUM(pa.planned_hours * ta.factor) AS total_hours

FROM course_instance ci
JOIN course_layout cl 
    ON ci.course_code = cl.course_code AND ci.layout_version = cl.layout_version
JOIN planned_activity pa 
    ON pa.instance_id = ci.instance_id
JOIN teaching_activity ta 
    ON ta.activity_id = pa.activity_id

GROUP BY 
    ci.course_code, ci.instance_id, cl.hp, ci.study_period, ci.num_students

ORDER BY ci.instance_id;


-- Query 2: Calculated hours per teacher per course instance
SELECT
    ci.course_code,
    ci.instance_id,
    cl.hp,
    CONCAT(p.first_name, ' ', p.last_name) AS teacher_name,
    e.job_title AS designation,

    SUM(CASE WHEN ta.activity_type = 'Lecture' THEN a.allocated_hours ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN ta.activity_type = 'Tutorial' THEN a.allocated_hours ELSE 0 END) AS tutorial_hours,
    SUM(CASE WHEN ta.activity_type = 'Lab' THEN a.allocated_hours ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN ta.activity_type = 'Seminar' THEN a.allocated_hours ELSE 0 END) AS seminar_hours,

    SUM(a.allocated_hours) AS total_hours

FROM allocation a
JOIN teaching_activity ta 
    ON a.activity_id = ta.activity_id
JOIN course_instance ci 
    ON a.instance_id = ci.instance_id
JOIN course_layout cl 
    ON ci.course_code = cl.course_code AND ci.layout_version = cl.layout_version
JOIN employee e 
    ON a.employee_id = e.employee_id
JOIN person p
    ON e.personal_number = p.personal_number

GROUP BY 
    ci.course_code, ci.instance_id, cl.hp,
    teacher_name, designation

ORDER BY ci.instance_id, teacher_name;


-- Query 3: Total hours for a teacher
SELECT
    ci.course_code,
    ci.instance_id,
    cl.hp,
    ci.study_period,
    CONCAT(p.first_name, ' ', p.last_name) AS teacher_name,

    SUM(CASE WHEN ta.activity_type = 'Lecture' THEN a.allocated_hours ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN ta.activity_type = 'Tutorial' THEN a.allocated_hours ELSE 0 END) AS tutorial_hours,
    SUM(CASE WHEN ta.activity_type = 'Lab' THEN a.allocated_hours ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN ta.activity_type = 'Seminar' THEN a.allocated_hours ELSE 0 END) AS seminar_hours,

    SUM(a.allocated_hours) AS total_hours

FROM allocation a
JOIN teaching_activity ta 
    ON a.activity_id = ta.activity_id
JOIN course_instance ci 
    ON a.instance_id = ci.instance_id
JOIN course_layout cl 
    ON ci.course_code = cl.course_code AND ci.layout_version = cl.layout_version
JOIN employee e 
    ON a.employee_id = e.employee_id
JOIN person p
    ON e.personal_number = p.personal_number

WHERE ci.study_year = '2025-01-01'
  AND e.employee_id = 'EMP003'   -- välj valfri lärare här

GROUP BY
    ci.course_code, ci.instance_id, cl.hp, ci.study_period, teacher_name

ORDER BY ci.study_period;


-- Query 4: Teachers allocated to more than N course instances
SELECT
    e.employee_id,
    CONCAT(p.first_name, ' ', p.last_name) AS teacher_name,
    ci.study_period,
    COUNT(DISTINCT ci.instance_id) AS num_courses

FROM allocation a
JOIN course_instance ci 
    ON a.instance_id = ci.instance_id
JOIN employee e 
    ON a.employee_id = e.employee_id
JOIN person p
    ON e.personal_number = p.personal_number

WHERE ci.study_year = '2025-01-01'

GROUP BY 
    e.employee_id, teacher_name, ci.study_period

HAVING COUNT(DISTINCT ci.instance_id) > 1

ORDER BY num_courses DESC;