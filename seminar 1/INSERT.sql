INSERT INTO settings (max_teaching_load)
VALUES (4);

INSERT INTO job_title VALUES
('Professor'),
('Associate Professor'),
('Lecturer'),
('PhD Student'),
('Teaching Assistant');

INSERT INTO skill_set VALUES
('Databases'),
('Discrete Maths'),
('Programming'),
('Algorithms'),
('Machine Learning');

INSERT INTO address VALUES
('ADDR1','Kistagången','16440','Stockholm',12),
('ADDR2','Valhallavägen','11428','Stockholm',7),
('ADDR3','Teknikringen','11422','Stockholm',32),
('ADDR4','Lindstedtsvägen','11428','Stockholm',9),
('ADDR5','Sveavägen','11350','Stockholm',15);

INSERT INTO person VALUES
('198001012345','Anders','Andersson','ADDR1'),
('198505052222','Sven','Svensson','ADDR2'),
('199001015555','Isak','Isaksson','ADDR3'),
('199505059999','Brian','Karlsson','ADDR4'),
('199804041111','Adam','Svensson','ADDR5');


INSERT INTO phone_number VALUES
('198001012345','0701111111'),
('198505052222','0702222222'),
('199001015555','0703333333'),
('199505059999','0704444444'),
('199804041111','0705555555');

INSERT INTO employee (employee_id, supervisor, personal_number, job_title) VALUES
('EMP001', NULL,'198001012345','Associate Professor'), 
('EMP002','EMP001','198505052222','Lecturer'),
('EMP003','EMP001','199001015555','Lecturer'),
('EMP004','EMP002','199505059999','PhD Student'),
('EMP005','EMP002','199804041111','Teaching Assistant');

INSERT INTO department VALUES
('Computer Science','EMP001'),
('Mathematics','EMP002');

INSERT INTO employee_department VALUES
('EMP001','Computer Science'),
('EMP002','Computer Science'),
('EMP003','Computer Science'),
('EMP004','Computer Science'),
('EMP005','Mathematics');

INSERT INTO employee_skill_set VALUES
('Databases','EMP001'),
('Algorithms','EMP002'),
('Databases','EMP003'),
('Machine Learning','EMP004'),
('Discrete Maths','EMP005');

INSERT INTO employee_salary_history VALUES
('EMP001',60000,'2024-01-01',NULL),
('EMP002',45000,'2024-01-01',NULL),
('EMP003',42000,'2024-01-01',NULL),
('EMP004',30000,'2024-01-01',NULL),
('EMP005',22000,'2024-01-01',NULL);

INSERT INTO course_layout VALUES
('IV1351',1,'Data Storage Paradigms',50,250,7.5,'2023-01-01',NULL,TRUE),
('IX1500',1,'Discrete Mathematics',50,150,7.5,'2023-01-01',NULL,TRUE),
('ID2214',1,'Advanced Algorithms',30,120,7.5,'2023-01-01',NULL,TRUE),
('IV1350',1,'Programming Paradigms',40,200,7.5,'2023-01-01',NULL,TRUE);

INSERT INTO course_instance VALUES
('2025-50273','IV1351',1,200,2,'2025-01-01'),
('2025-50413','IX1500',1,150,1,'2025-01-01'),
('2025-50341','ID2214',1,80,2,'2025-01-01'),
('2025-60104','IV1350',1,90,3,'2025-01-01');

INSERT INTO teaching_activity VALUES
('A1','2025-50273','IV1351',1,'Lecture',3.6),
('A2','2025-50273','IV1351',1,'Tutorial',2.4),
('A3','2025-50273','IV1351',1,'Lab',2.4),
('A4','2025-50273','IV1351',1,'Seminar',1.8),

('A5','2025-50413','IX1500',1,'Lecture',3.6),
('A6','2025-50413','IX1500',1,'Seminar',1.8),

('A7','2025-50341','ID2214',1,'Lecture',3.6),
('A8','2025-50341','ID2214',1,'Tutorial',2.4),

('A9','2025-60104','IV1350',1,'Tutorial',2.4),
('A10','2025-60104','IV1350',1,'Seminar',1.8);

INSERT INTO planned_activity VALUES
('2025-50273','A1','IV1351',1,20),
('2025-50273','A2','IV1351',1,80),
('2025-50273','A3','IV1351',1,40),
('2025-50273','A4','IV1351',1,80),

('2025-50413','A5','IX1500',1,44),
('2025-50413','A6','IX1500',1,64),

('2025-50341','A7','ID2214',1,44),
('2025-50341','A8','ID2214',1,36),

('2025-60104','A9','IV1350',1,25),
('2025-60104','A10','IV1350',1,60);

INSERT INTO allocation VALUES
('2025-50273','A1','EMP001','IV1351',1,20),
('2025-50273','A2','EMP003','IV1351',1,80),
('2025-50273','A3','EMP004','IV1351',1,40),
('2025-50273','A4','EMP005','IV1351',1,30),

('2025-50413','A5','EMP003','IX1500',1,44),
('2025-50413','A6','EMP001','IX1500',1,64),

('2025-50341','A7','EMP003','ID2214',1,44),
('2025-50341','A8','EMP001','ID2214',1,36),

('2025-60104','A9','EMP005','IV1350',1,25),
('2025-60104','A10','EMP004','IV1350',1,60);
