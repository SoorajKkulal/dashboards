use projects;

select * from hr

alter table hr
change column  ï»¿id emp_id varchar(20) NULL;

describe hr;

select birthdate from hr;

set sql_safe_updates=0;

-----------------------------------Update birthdate

update hr
set birthdate  = CASE 
WHEN birthdate like '%/%' THEN DATE_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
WHEN birthdate like '%-%' THEN DATE_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
ELSE NULL
END;

select birthdate from hr

ALTER TABLE hr
modify column birthdate DATE;
-----------------------------------------hiredate

update hr
set hire_date  = CASE 
WHEN hire_date like '%/%' THEN DATE_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
WHEN hire_date like '%-%' THEN DATE_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE hr
modify column hire_date DATE;

select hire_date from hr

-------------------Update_termdate
select termdate from hr

update hr
set termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate!='';

update hr
set termdate = '0000-00-00'
where  termdate IS  NULL OR termdate='';

select termdate from hr;

ALTER TABLE hr
modify column termdate DATE;

UPDATE hr 
SET termdate = '1970-01-01' 
WHERE termdate = '0000-00-00';

UPDATE hr 
SET termdate = null
WHERE termdate = '1970-01-01'

alter table hr add column age INT;

select * from hr;

update hr
set age = timestampdiff(YEAR, birthdate, Curdate());

select birthdate,age from hr;

----------------------Analsys

select min(age) as youngest,
max(age) as oldest
from hr;

select count(*) from hr where age<18;

s