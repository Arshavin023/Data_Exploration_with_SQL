-- Queries used for Tableau Project
	
	
	

	-- 1. 
	

	Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
	From Covid_PP_Data_Exploration..covid_data_deaths
	--Where location like '%states%'
	where continent is not null 
	--Group By date
	order by 1,2
	

	-- Just a double check based off the data provided
	-- numbers are extremely close so we will keep them - The Second includes "International"  Location
	

		--Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
	--From PortfolioProject..CovidDeaths
	----Where location like '%states%'
	--where location = 'World'
	----Group By date
	--order by 1,2
	

	

	-- 2. 
	

	-- We take these out as they are not inluded in the above queries and want to stay consistent
	-- European Union is part of Europe
	

	Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
	From Covid_PP_Data_Exploration..covid_data_deaths
	--Where location like '%states%'
	Where continent is null 
	and location not in ('World', 'European Union', 'International')
	Group by location
	order by TotalDeathCount desc
	

	

	-- 3.
	

	Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
	From Covid_PP_Data_Exploration..covid_data_deaths
	--Where location like '%states%'
	Group by Location, Population
	order by PercentPopulationInfected desc
	

	

	-- 4.
	

	

	Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
	From Covid_PP_Data_Exploration..covid_data_deaths
	--Where location like '%states%'
	Group by Location, Population, date
	order by PercentPopulationInfected desc



Select *
From Covid_PP_Data_Exploration..covid_data_deaths
where continent is not null
order by 2,3

Select *
From Covid_PP_Data_Exploration..covid_data_deaths
where continent is not null
order by 2,3

-- Data I would be using 
Select Location, date, total_cases, new_cases, total_deaths, population
From Covid_PP_Data_Exploration..covid_data_deaths
where continent is not null
order by 1,2

-- Percentage total_deaths w.r.t total_cases.
-- likelihood of dying from covid-19 infection in United States
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS deaths_percent
From Covid_PP_Data_Exploration..covid_data_deaths
where Location = 'United States' and continent is not null
order by 1,2

-- Total Cases vs Population
-- Percentage of Population infected with Covid in the United States
Select Location, date, Population, total_cases, (total_cases/Population) * 100 AS cases_percent
From Covid_PP_Data_Exploration..covid_data_deaths
where Location = 'United States' and continent is not null
order by 1,2

-- Total Cases vs Population
-- Percentage of Population infected with Covid globally
Select Location, date, Population, total_cases, (total_cases/Population) * 100 AS cases_percent
From Covid_PP_Data_Exploration..covid_data_deaths
where continent is not null
order by 1,2

--Countries with highest infection rate compared to Population
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/Population) * 100 AS PercentPopulationInfected
From Covid_PP_Data_Exploration..covid_data_deaths
where continent is not null
Group by Location, Population
order by 4 DESC


--Countries witzh Highest Death Count per Population
Select location, MAX(cast(total_deaths as int)) as HighestDeathCount
From Covid_PP_Data_Exploration..covid_data_deaths
where continent is not null
Group by location
order by 2 DESC


-- LET's DIVE INTO CONTENT
--Countries witz Highest Death Count per Continent 
Select location, MAX(cast(total_deaths as int)) as HighestDeathCount
From Covid_PP_Data_Exploration..covid_data_deaths
where continent is null and location <> 'World'
group by location
order by 2 desc

--Countries witz Highest Death Count per Continent 
Select continent, MAX(cast(total_deaths as int)) as HighestDeathCount
From Covid_PP_Data_Exploration..covid_data_deaths
where continent is not null and location <> 'World'
group by continent
order by 2 desc

-- Global Numbers daily
Select date, sum(new_cases) as global_new_cases_per_day,  sum(cast(new_deaths as int)) as global_new_deaths_per_day, (sum(cast(new_deaths as int))/sum(new_cases))*100 as deaths_percentage_per_day
From Covid_PP_Data_Exploration..covid_data_deaths
-- where Location = 'United States'
where continent is not null
group by date
order by 1,2


-- Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, dea.new_cases, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.Date) as total_vaccinations
From Covid_PP_Data_Exploration..covid_data_deaths dea
Join Covid_PP_Data_Exploration..covid_data_vaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

-- USE CTE
With PopvsVac (Continent, location, Date, Population, new_vaccinations, cummulative_vaccinations)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date) as cummulative_vaccinations
From Covid_PP_Data_Exploration..covid_data_deaths dea
Join Covid_PP_Data_Exploration..covid_data_vaccinations vac
ON dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)

Select *, (cummulative_vaccinations/Population) * 100 as percentage_vaccination_per_day
From PopvsVac


-- TEMP TABLE
DROP Table if exist #PercentVac
Create Table PercentVaccc
(
Continent nvarchar(255),
location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
cummulative_vaccinations numeric
)

Insert into PercentVacc
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date) as cummulative_vaccinations
From Covid_PP_Data_Exploration..covid_data_deaths dea
Join Covid_PP_Data_Exploration..covid_data_vaccinations vac
ON dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Select *, (cummulative_vaccinations/Population) * 100
From PercentVaccc


Create View PercentVacci as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date) as cummulative_vaccinations
--(cummulative_vaccinations/Population) * 100
From Covid_PP_Data_Exploration..covid_data_deaths dea
Join Covid_PP_Data_Exploration..covid_data_vaccinations vac
ON dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
--order by 2,3