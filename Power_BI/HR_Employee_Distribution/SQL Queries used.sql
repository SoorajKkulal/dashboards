-- QUESTIONS and Answers
select * from hr
-- 1. What is the gender breakdown of employees in the company?

select gender,count(*) from hr
where age>=18 and termdate is  null
group by gender

-- 2. What is the race/ethnicity breakdown of employees in the company?

select race,count(*) as count from hr
where age>=18 and termdate is  null
group by race
order  by count(*) desc

-- 3. What is the age distribution of employees in the company?

select min(age) as youngest,max(age) as oldest from hr
where age>=18 and termdate is  null 

select 
	 case 
		when age>=18 and age<=24 THEN '18-24'
        when age>=25 and age<=34 THEN '25-34'
        when age>=35 and age<=44 THEN '35-44'
        when age>=45 and age<=54 THEN '45-54'
        when age>=55 and age<=64 THEN '55-64'
        ELSE '65+'
     END   as age_group, 
     count(*) as count
     FROM hr
     where age>=18 and termdate is  null 
     group by age_group
     order by age_group
     
select count(*) from hr
where age>=18 and termdate is  null

select 
	 case 
		when age>=18 and age<=24 THEN '18-24'
        when age>=25 and age<=34 THEN '25-34'
        when age>=35 and age<=44 THEN '35-44'
        when age>=45 and age<=54 THEN '45-54'
        when age>=55 and age<=64 THEN '55-64'
        ELSE '65+'
     END  as age_group, gender,
     count(*) as count FROM hr
     where age>=18 and termdate is null 
     group by age_group,gender
     order by age_group,gender;
-- 4. How many employees work at headquarters versus remote locations?
select location, count(*) as count from hr
where age>=18 and termdate is null 
group by location

-- 5. What is the average length of employment for employees who have been terminated?
select round(avg(datediff(termdate, hire_date))/365,0) as avg_length_employement from hr
where age>=18 and termdate <= curdate() and termdate is not null;

-- 6. How does the gender distribution vary across departments and job titles?
select department,gender,count(*) from hr
where age>=18 and termdate is  null
group by gender,department
order by department

-- 7. What is the distribution of job titles across the company?
select jobtitle,count(*) from hr
where age>=18 and termdate is  null
group by jobtitle
order by jobtitle desc


-- 8. Which department has the highest turnover rate?
select department, total_count, terminated_count, terminated_count/total_count AS termination_rate FROM(
select department, count(*) AS total_count, sum(case when termdate is not null and  termdate<curdate()  then 1 else 0 END) As terminated_count
from hr
where age>=18
group by department) as subquery
order by termination_rate desc

-- 9. What is the distribution of employees across locations by city and state?
select location_state, count(*) as count from hr
where age>=18 and termdate is null 
group by location_state
order by count desc


-- 10. How has the company's employee count changed over time based on hire and term dates?
select
	year,
    terminations,
    hires - terminations as net_change,
    round((hires - terminations)/hires*100,2) as net_change_percent
    FROM
    (select YEAR(hire_date) AS year,
    count(*) AS hires,
    SUM(case when termdate is not  null AND termdate<curdate() THEN 1 else 0 END) AS terminations
    FROM hr
    where age>=18
    group by year(hire_date)
    )as sub
order by year asc    
    
-- 11. What is the tenure distribution for each department?
select department,round(avg(datediff(termdate,hire_date)/365),0) AS avg_teure
From hr
where termdate<=curdate() and termdate is not null and age>=18
group by department
