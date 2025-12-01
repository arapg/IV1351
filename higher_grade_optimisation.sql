-- Higher Grade
-- Indexing
CREATE INDEX idx_course_instance_layout 
    ON course_instance(course_code, layout_version);

CREATE INDEX idx_allocation_instance 
    ON allocation(instance_id);

CREATE INDEX idx_allocation_activity 
    ON allocation(activity_id);

CREATE INDEX idx_allocation_employee 
    ON allocation(employee_id);

CREATE INDEX idx_employee_personal 
    ON employee(personal_number);

CREATE INDEX idx_course_instance_year 
    ON course_instance(study_year);

CREATE INDEX idx_course_instance_year_period 
    ON course_instance(study_year, study_period, instance_id);

CREATE INDEX idx_teaching_activity_type 
    ON teaching_activity(activity_id, activity_type);

-- Create materialized view for teacher allocations
CREATE MATERIALIZED VIEW mv_teacher_allocations AS
SELECT
    ci.course_code,
    ci.instance_id,
    ci.study_year,
    ci.study_period,
    ci.num_students,
    cl.hp,
    e.employee_id,
    e.job_title AS designation,
    CONCAT(p.first_name, ' ', p.last_name) AS teacher_name,
    p.personal_number,
    
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
    ci.course_code, ci.instance_id, ci.study_year, ci.study_period, ci.num_students,
    cl.hp, e.employee_id, e.job_title, teacher_name, p.personal_number;


CREATE INDEX idx_mv_teacher_alloc_instance 
    ON mv_teacher_allocations(instance_id);

CREATE INDEX idx_mv_teacher_alloc_employee_year 
    ON mv_teacher_allocations(employee_id, study_year);

CREATE INDEX idx_mv_teacher_alloc_year_period 
    ON mv_teacher_allocations(study_year, study_period);

CREATE INDEX idx_mv_teacher_alloc_emp_period 
    ON mv_teacher_allocations(study_year, study_period, employee_id);