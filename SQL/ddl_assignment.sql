create database ddl_assgn;
use ddl_assgn;

create table students
(
student_id int auto_increment primary key,
first_name varchar(20) not null,
last_name varchar(20) not null,
email varchar(30) unique,
date_of_birth date,
gender enum ("Male", "Female", "Other")
);

INSERT INTO students (first_name, last_name, email, date_of_birth, gender) VALUES
('Emma', 'Stone', 'emma.stone@example.com', '1999-04-12', 'Female'),
('Liam', 'Johnson', null, '1998-06-25', 'Male'),
('Olivia', 'Brown', 'olivia.brown@example.com', '2000-09-18', 'Female'),
('Noah', 'Davis', 'noah.davis@example.com', '1997-12-03', 'Male'),
('Avery', 'Taylor', 'avery.taylor@example.com', '1999-02-14', 'Other'),
('Anderson', 'Brown', 'anderson.brown@example.com', '1996-03-12', 'Male');

create table courses
(
course_id int primary key,
course_name varchar(10) not null,
course_credits int check(course_credits >= 1 and course_credits <= 5),
department varchar(20)
);

INSERT INTO courses VALUES
(101, 'Python', 3, 'Computer Science'),
(102, 'SQL', 2, 'Data Analytics'),
(103, 'Cloud', 4, 'IT'),
(104, 'Stats', 3, 'Mathematics'),
(105, 'ML', 5, 'AI');

create table enrollments
(
enrollment_id int primary key,
student_id int,
course_id int,
enrollment_date date,
foreign key (student_id) references students (student_id),
foreign key (course_id) references courses (course_id)
);

INSERT INTO enrollments VALUES
(1, 1, 101, '2025-08-01'),
(2, 1, 103, '2025-08-01'),
(3, 1, 105, '2025-08-01'),
(4, 2, 102, '2025-08-03'),
(5, 3, 105, '2025-08-05'),
(6, null, 104, '2025-08-07'),
(7, 4, 103, '2025-08-09'),
(8, 5, 101, '2025-08-11'),
(9, 1, 102, '2025-08-11'),
(10, 2, 103, '2025-08-11'),
(11, 3, 103, '2025-08-11'),
(12, 5, 103, '2025-08-11'),
(13, 5, 103, '2025-08-11');

alter table students add constraint un_email unique(email);
describe students;

alter table students modify column date_of_birth date not null;
describe students;
alter table students add constraint chk_date check(date_of_birth > "1990-01-01" and date_of_birth < "2025-12-31");
select * from information_schema.table_constraints
where table_name = 'students';

alter table courses add constraint chk_credit check(course_credits between 1 and 5);
select * from information_schema.table_constraints
where table_name = 'courses';

alter table courses add constraint un_course_name unique(course_name);
select * from information_schema.table_constraints
where table_name = 'courses';

alter table enrollments add constraint fk_enroll_student foreign key (student_id) references students(student_id);
select * from information_schema.table_constraints
where table_name = 'enrollments';

alter table enrollments add constraint fk_enroll_course foreign key (course_id) references courses(course_id);
select * from information_schema.table_constraints
where table_name = 'enrollments';

alter table enrollments add constraint chk_enroll_date check(enrollment_date < "2025-12-31");
select * from information_schema.table_constraints
where table_name = 'enrollments';

alter table students add column phone_number varchar(12);
describe students;

alter table students drop column gender;
describe students;

alter table courses rename column department to dept_name;
describe courses;

alter table courses drop column course_credits;
describe courses;

select * from students where email is null;

select c.course_name from courses c
join enrollments e on c.course_id = e.course_id
where e.student_id is null;

select s.student_id, concat(s.first_name, " ", s.last_name) as full_name, 
count(e.course_id) as total_courses from students s
join enrollments e on s.student_id = e.student_id
group by s.student_id, s.first_name, s.last_name
having total_courses > 3;

select c.course_id, c.course_name, 
count(e.student_id) as total_students from courses c
join enrollments e on c.course_id = e.course_id
group by c.course_id, c.course_name
having total_students > 5;