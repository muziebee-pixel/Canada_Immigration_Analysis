
/* CANADA IMMIGRATION ANALYSIS — SQL QUERIES
 Author: Precious Omondiale
 Data Source: IRCC open.canada.ca
 Period: 2015-2026.
After cleaning in Excel , I moved the data into MySQL Workbench for deeper analysis.
SQL stands for Structured Query Language. It is a tool that data analysts use to ask specific questions from large datasets.
Instead of scrolling through thousands of rows manually,I wrote queries 
 which are basically instructions I give the computer  and it immediately pulls out exactly the information I need.
Let me give you some examples of the questions I asked using SQL.

..How many Nigerians got Canadian PR each year from 2015 to 2025
..How badly did COVID affect Nigerian immigration in 2020 compared to 2019
..Which province received the most immigrants*/

SELECT * FROM province_pr;
-- 1, Nigeria Yearly & Monthly PR Admissions
SELECT 
    Country,
    `2015 TOTAL`, `2016 TOTAL`, `2017 TOTAL`,
    `2018 TOTAL`, `2019 TOTAL`, `2020`,
    `2021 TOTAL`, `2022`, `2023`,
    `2024 TOTAL`, `2025 TOTAL`
FROM countrypr
WHERE Country = 'Nigeria';

show tables;


-- 2, Top 10 Countries By Total PR Admissions
SELECT 
    Country,
    (`2015 TOTAL` + `2016 TOTAL` + `2017 TOTAL` + `2018 TOTAL` +
     `2019 TOTAL` + `2020` + `2021 TOTAL` + `2022` +
     `2023` + `2024 TOTAL` + `2025 TOTAL`) AS Grand_Total
FROM countrypr
ORDER BY Grand_Total DESC
LIMIT 10;

DESCRIBE countrypr;

-- 3, Nigeria vs Top African Countries
SELECT 
    Country,
    `2020` AS Year_2020,
    `2021 TOTAL` AS Year_2021,
    `2022` AS Year_2022,
    `2023` AS Year_2023,
    `2024 TOTAL` AS Year_2024
FROM countrypr
WHERE Country IN (
    'Nigeria', 'Ghana', 'Kenya', 'Ethiopia',
    'Cameroon', 'Morocco')
ORDER BY `2026 TOTAL` DESC;

select * from countrypr;

-- 4, COVID Impact On Nigeria
SELECT
    Country,
    `2019 TOTAL` AS Pre_COVID_2019,
    `2020` AS COVID_2020,
    (`2020` - `2019 TOTAL`) AS Drop_In_Admissions,
    `2021 TOTAL` AS Recovery_2021,
    `2022` AS Boom_2022
FROM countrypr
WHERE Country = 'Nigeria';

-- 5, Nigeria Recovery After COVID
SELECT
    Country,
    `2020` AS Year_2020,
    `2021 TOTAL` AS Year_2021,
    `2022` AS Year_2022,
    `2023` AS Year_2023,
    `2024 TOTAL` AS Year_2024,
    ROUND(((`2024 TOTAL` - `2020`) / `2020`) * 100, 1) AS Growth_Pct_Since_COVID
FROM countrypr
WHERE Country = 'Nigeria';

-- 6, Nigeria Monthly Trend 2024
SELECT
    Country,
    `24-Jan` AS Jan_2024,
    `24-Feb` AS Feb_2024,
    `24-Mar` AS Mar_2024,
    `24-May` AS May_2024,
    `24-Jun` AS Jun_2024,
    `24-Jul` AS Jul_2024,
    `24-Aug` AS Aug_2024,
    `24-Sep` AS Sep_2024,
    `24-Oct` AS Oct_2024,
    `24-Nov` AS Nov_2024,
    `24-Dec` AS Dec_2024,
    `2024 TOTAL` AS Total_2024
FROM countrypr
WHERE Country = 'Nigeria';

 -- 7, Nigeria Rank Among All Countries in 2024-2025
SELECT 
    Country,
     `2024 TOTAL` AS Year_2024,
     `2025 TOTAL` AS Year_2025,
    RANK() OVER (ORDER BY `2025 TOTAL` DESC) AS Global_Rank
FROM countrypr
ORDER BY `2025 TOTAL` DESC
LIMIT 20;

-- 8, Most Popular Immigration Pathway Canada-Wide
SELECT *
FROM categorypr
ORDER BY `2026 Total` DESC;

-- 9, Which Province Receives Most Immigrants
SELECT *
FROM province_pr
ORDER BY `2024_2024 Total` DESC;
 
 -- 10. Which Pathway Dominates Each Province
 SELECT 
    Province_Immigration_Category AS Province,
    Program AS Pathway,
    `2025` AS Year_2025, 
    `2024` AS Year_2024,
    `2023` AS Year_2023,
    `2022` AS Year_2022
FROM province_pathway
ORDER BY Province_Immigration_Category, `2025` DESC;

