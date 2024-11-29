-- EDA Exploratory  Data Analysis 
SELECT * FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- these companies laid off 100% of thier employees
SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1;


SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- order by sum(total_laid_off)
SELECT company,sum(total_laid_off) FROM layoffs_staging2
GROUP BY company ORDER BY 2 DESC;

-- exploring the start and end date 
SELECT MIN(`date`) as 'Starting date',MAX(`date`) as 'Ending date' 
FROM layoffs_staging2;


SELECT industry,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY industry ORDER BY 2 DESC;
-- having consumer, retail and transportiation to be ranked highly among other industries

SELECT country,sum(total_laid_off)
FROM layoffs_staging2
GROUP BY country ORDER BY 2 DESC;
-- most people in the US had lost their jobs after US comes India and Netherlands

SELECT YEAR(`date`),sum(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`) 
ORDER BY 2 DESC;
-- having 2022 as the most year among the recorded that when people lost their jobs the most


SELECT company, YEAR(`date`) as `year`, sum(total_laid_off) 
FROM layoffs_staging2
GROUP BY company,`year` 
ORDER BY 3 desc;


-- the most 5 companies that laid people off in each year
WITH company_yr_cte (company, years, total_laid_off) as 
(
-- looking at how many each company laid off in each year
SELECT company, YEAR(`date`) as `year`, sum(total_laid_off) 
FROM layoffs_staging2
GROUP BY company,`year` 
), 
-- then giving it a rank by another cte
company_rank_cte as (
SELECT * ,DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_yr_cte
WHERE years IS NOT NULL
 )
SELECT * 
FROM company_rank_cte
WHERE Ranking < 6;