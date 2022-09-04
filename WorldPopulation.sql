Create database WorldPopulation
Use WorldPopulation

-- Over view database 
select * 
from 
	[dbo].[world_population]

-- Clean data
update [dbo].[world_population]
set [2022 Population]= null 
where [2022 Population]= 'North America'

update [dbo].[world_population]
set [World Population Percentage]= null
where [Country]='United States'
-- Convert data type for each column
alter table [dbo].[world_population]
alter column [Rank] int
alter table [dbo].[world_population]
alter column [2022 Population] int

-- Rank of top 10 country in 2022
with population2022 as(
	select 
		DENSE_RANK() over(order by [2022 Population] DESC) as 'Rank',
		[Country],
		[2022 Population]
	from
		[dbo].[world_population]
	where
		[2022 Population] is not null
)
select top 10 * from population2022


-- Rank of top 10 country in 2020
with population2020 as(
	select 
		DENSE_RANK() over(order by [2020 Population] DESC) as 'Rank',
		[Country],
		[2020 Population]
	from
		[dbo].[world_population]
	where
		[2020 Population] is not null
)
select top 10 *from population2020 

-- Rank of top 10 country in 2015
with population2015 as(
	select 
		DENSE_RANK() over(order by [2015 Population] DESC) as 'Rank',
		[Country],
		[2015 Population]
	from
		[dbo].[world_population]
	where
		[2015 Population] is not null
)
select top 10 *from population2015 

-- Rank of top 10 country in 2010
with population2010 as(
	select 
		DENSE_RANK() over(order by [2010 Population] DESC) as 'Rank',
		[Country],
		[2010 Population]
	from
		[dbo].[world_population]
	where
		[2010 Population] is not null
)
select top 10 *from population2010

-- Rank of top 10 country in 2000
with population2000 as(
	select 
		DENSE_RANK() over(order by [2000 Population] DESC) as 'Rank',
		[Country],
		[2000 Population]
	from
		[dbo].[world_population]
	where
		[2000 Population] is not null
)
select top 10 *from population2000

-- Compare population 2022 vs 2020

select 
	[Country],
	[2022 Population],
	[2020 Population],
	([2022 Population]-[2020 Population])*100/[2020 Population] as 'Percent 2022 vs 2020'
from
	[dbo].[world_population]
order by
	[2022 Population] DESC

-- Population in each continent in 2022
(
select 
	'Total population' as Territory,
	[Asia],
	[Europe],
	[Africa],
	[Oceania],
	[North America],
	[South America]
from
	(
		select [Continent],[2022 Population]
		from [dbo].[world_population]
	)
as resource_1
pivot
(
	SUM([2022 Population])
	for [Continent] in ([Asia],[Europe]	,[Africa],[Oceania],[North America],[South America])
) as population_continent
)
union all
(
select 
	'Total area' as Territory,
	[Asia],
	[Europe],
	[Africa],
	[Oceania],
	[North America],
	[South America]
from
	(
		select [Continent],[Area (km²)]
		from [dbo].[world_population]
	)
as resource_2
pivot
(
	SUM([Area (km²)])
	for [Continent] in ([Asia],[Europe]	,[Africa],[Oceania],[North America],[South America])
) as population_area
)