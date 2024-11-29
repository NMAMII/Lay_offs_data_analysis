-- Data cleaning 
SELECT * FROM layoffs;

-- fisrt creating a staging table to avoid working on the raw data in the layoffs table
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT * 
FROM layoffs;
SELECT * FROM layoffs_staging;
-- 1 Remove duplicates

SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage,country, funds_raised_millions) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS (
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage,country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * FROM duplicate_cte WHERE row_num >1;

-- removing JUST one of the duplicates
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2 
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage,country, funds_raised_millions) 
AS row_num
FROM layoffs_staging;

SELECT * FROM layoffs_staging2
WHERE row_num > 1;

DELETE FROM layoffs_staging2
WHERE row_num > 1;

SELECT * FROM layoffs_staging2
WHERE row_num > 1;
SELECT * FROM layoffs_staging2;
 
-- 2 Standerdize the data
-- removing spaces at the beggining and ending by TRIM
 SELECT company,TRIM(company)
 FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT * FROM layoffs_staging2;

SELECT distinct(industry) FROM layoffs_staging2 order by 1;

-- setting the same multi occured industeries with slightly diff names as one
SELECT * FROM layoffs_staging2 WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2 
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT distinct(industry) FROM layoffs_staging2 order by 1;
--
SELECT distinct(location) FROM layoffs_staging2 order by 1;
SELECT distinct(country) FROM layoffs_staging2 order by 1;


UPDATE layoffs_staging2 
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT distinct(country) FROM layoffs_staging2 order by 1;
-- * or update layoffs_staging2 set country = trim(trailing '.' from country) where country like 'United States%'

-- changing date column type to datetime
-- the formate typed between '' not `` date is in `` because its a sensetive word in sql
SELECT `date`, str_to_date(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

update layoffs_staging2 
SET `date` = str_to_date(`date`,'%m/%d/%Y');

SELECT `date` FROM layoffs_staging2;
-- now after changing the formate we will change the data type

alter table layoffs_staging2
modify column `date` DATE;

select * from layoffs_staging2;


-- 3 Null/blank values

SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

select *
from layoffs_staging2
where industry is null 
or industry= '' ;


select *
from layoffs_staging2
where company = 'airbnb';

select * from layoffs_staging2 st1
join layoffs_staging2 st2
on st1.company = st2.company
and st1.location = st2.location
where (st1.industry is null or st1.industry = '') and st2.industry is not null or  st2.industry = '';

update layoffs_staging2
set industry = null 
where industry ='';

update layoffs_staging2 st1
join layoffs_staging2 st2
	on st1.company = st2.company
set st1.industry = st2.industry
where st1.industry is null 
and st2.industry is not null;


select *
from layoffs_staging2
where company like 'Bally%';

select *
from layoffs_staging2;
-- finally removing the column that we added for removing the duplictes 
alter table layoffs_staging2
drop column row_num;
