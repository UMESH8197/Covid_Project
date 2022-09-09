create database covid_db
use covid_db

create table if not exists covid_tb (
iso_code varchar(90),	
continent varchar(80),	
location varchar(70),	
`date` date,
population int,
total_cases int,	
new_cases int,	
new_cases_smoothed int,	
total_deaths int,	
new_deaths int,	
new_deaths_smoothed int,	
total_cases_per_million int,	
new_cases_per_million int,	
new_cases_smoothed_per_million int,	
total_deaths_per_million int,	
new_deaths_per_million int,	
new_deaths_smoothed_per_million int,	
reproduction_rate int,	
icu_patients int,	
icu_patients_per_million int,	
hosp_patients int,	
hosp_patients_per_million int,	
weekly_icu_admissions int,	
weekly_icu_admissions_per_million int,	
weekly_hosp_admissions int,	
weekly_hosp_admissions_per_million int
)

select * from covid_tb
show date
insert into covid_tb values('AFG',	'Asia',	'Afghanistan', "2020/02/02", 40099462, 5, 5, null,null,	null,null,	0.125,	0.125,null, null, null, null,null, null,null,null, null,null, null,null,null );
desc covid_tb
		
alter table covid_tb modify `date` varchar(220);

alter covid_tb 

truncate table covid_tb
update covid_vaccine_tb set `date` = date_format(`date`,"%d/%m/%Y");
update covid_tb set ship_date_new = str_to_date(ship_date, '%m/%d/%Y');
desc covid_tb

update covid_tb set `date` = str_to_date(`date`, '%m/%d/%Y')

load data local infile 
'C:/Users/user/Downloads/covid_death-data.csv'
into table covid_tb 
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
set global local_infile = 1;

----------------------------------------------------------------------------------------------------------------------------------------------
SHIVANANDA SONWANE11:08 AM

load data infile 
'D:/sales_data_final.csv'
into table sales1 
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows

SHOW GLOBAL VARIABLES LIKE 'local_infile';
set global local_infile = 1;

OPT_LOCAL_INFILE=1


------------------------------------------------------------------------------------------------------------------------------------------------
desc covid_vaccine_tb 
alter table covid_vaccine_tb modify `date` varchar(220);
SET SQL_SAFE_UPDATES = 0;
update covid_vaccine_tb set `date` = date_format(`date`,"%d/%m/%Y");
load data local infile 
'C:/Users/user/Downloads/covid_vacination-data.csv'
into table covid_vaccine_tb 
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


create table if not exists covid_vaccine_tb (
iso_code varchar(90),	
continent varchar(90),	
location varchar(90),	
`date` date,	
total_tests int,	
new_tests int,	
total_tests_per_thousand int,
new_tests_per_thousand int,	
new_tests_smoothed int,
new_tests_smoothed_per_thousand int,	
positive_rate int,	
tests_per_case int,	
tests_units int,	
total_vaccinations int,	
people_vaccinated int,	
people_fully_vaccinated int,	
total_boosters int,	
new_vaccinations int,	
new_vaccinations_smoothed int,	
total_vaccinations_per_hundred int,	
people_vaccinated_per_hundred int,	
people_fully_vaccinated_per_hundred int,	
total_boosters_per_hundred int,	
new_vaccinations_smoothed_per_million int,	
new_people_vaccinated_smoothed int,	
new_people_vaccinated_smoothed_per_hundred int,	
stringency_index int,	
population_density int,	
median_age int,	
aged_65_older int,	
aged_70_older int,	
gdp_per_capita int,	
extreme_poverty int,	
cardiovasc_death_rate int,	
diabetes_prevalence int,	
female_smokers int,	
male_smokers int,	
handwashing_facilities int,	
hospital_beds_per_thousand int,	
life_expectancy int,	
human_development_index int,	
excess_mortality_cumulative_absolute int,	
excess_mortality_cumulative int,	
excess_mortality int,	
excess_mortality_cumulative_per_million int

)

select * from covid_vaccine_tb
truncate table covid_vaccine_tb
load data local infile 
'C:/Users/user/Downloads/covid_vacination-data.csv'
into table covid_vaccine_tb 
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

insert into covid_vaccine_tb values('AFG','Asia','Afghanistan',	'2020/02/24', 0, 0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8.33,54.422,18.6,	2.581,	1.337,	1803.987,597.029,9.59,37.746,0.5,64.83,	0.511, 0, 0, 0, 0);			
delete from covid_vaccine_tb where total_tests = null

--------------------------------------------------------------------------------------------------------------------------------------------

select * from covid_tb
select * from covid_vaccine_tb

select * from covid_tb 
where continent is not null
order by 3,4;

select * from covid_vaccine_tb order by 3,4

select location, date,total_cases, new_cases, total_deaths, population from covid_tb order by 1,2;  

-- Looking at total cases vs total deaths--
-- Shows likelihood of dying if you contract covid in your country. 
select location, date,total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage from covid_tb order by 1,2;  
select location, date,total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage from covid_tb where location like '%india%' order by 1,2;   

-- looking at total cases vs population. 
-- show what percentage of population got covid. 
select location, date, Population, total_cases, (total_cases/population) * 100 as Population_Percentage 
from covid_tb 
where location like '%india%' 
order by 1,2;   

-- Looking at countries with the highest infection rate compared to population. 

select location, Population, max(total_cases) as HighestInfectionCount, max(total_cases/population) * 100 as Population_Percentage_infected 
from covid_tb 
-- where location like '%india%' 
group by location, population
order by Population_Percentage_infected desc ; 

-- showing countries with highest death count per population
 
select location, max(total_deaths) as TotalDeathCount
from covid_db.covid_tb 
-- where location like '%india%' 
where continent is not null
group by location
order by TotalDeathCount desc ; 

-- Let's break things down by continent

select continent, max(total_deaths) as TotalDeathCount
from covid_tb 
-- where location like '%india%' 
where continent is not null
group by continent
order by TotalDeathCount desc ; 

-- showing continent with highest death count per population. 
select continent, max(total_deaths) as TotalDeathCount
from covid_tb 
-- where location like '%india%' 
where continent is not null
group by continent
order by TotalDeathCount desc ; 

-- Global numbers 
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths) / sum(new_cases)*100 as DeathPercentage 
from covid_tb 
-- where location like '%india%' 
where continent is not null
order by 1,2;   

----------------------------------------------------------------------------------------------------------------------------------------------

select * 
 from covid_vaccine_tb ; 
 
 -- join 2 tables. 
 
 select * from covid_tb dea join covid_vaccine_tb vac on dea.location = vac.location and dea.date = vac.date ;
 
-- Looking at total population vs vaccinations 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
, sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from covid_tb dea join covid_vaccine_tb vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
order by 1,2;


-- USE CTE 

with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as 
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
, sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from covid_tb dea join covid_vaccine_tb vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
-- order by 1,2;
)
select *, (RollingPeopleVaccinated/Population)*100
from popvsVac; 

-- TEMP TABLE 
create table PercentPopulationVacinated
(
Continent varchar(255),
Location varchar(255),
Date datetime,
Population int,
New_vaccinations int,
RollingPeopleVaccinated int
);

insert into PercentPopulationVacinated 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
, sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from covid_tb dea join covid_vaccine_tb vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null;
-- order by 1,2;

select *, (RollingPeopleVaccinated/Population)*100
from PercentPopulationVacinated;


-- create view to store data for later visualisation. 

create view PercentPopulationVacinated1 as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
, sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from covid_tb dea join covid_vaccine_tb vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null;
-- order by 1,2;

select * from PercentPopulationVacinated1
