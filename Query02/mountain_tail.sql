

create table mountain_huts 
(
	id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);


insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;


create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);

select * from mountain_huts;
select * from trails;

---Solution
with cte_trails1 as
		(select t.hut1 as start_hut,mh."name" as start_hut_name,
		mh.altitude as start_hut_altitude, t.hut2 as end_hut
		from 
		mountain_huts mh 
		join trails t on t.hut1 = mh.id) ,
   cte_trails2 as 
		(select t1.*,mh2."name" as end_hut_name,mh2.altitude as end_hut_altitude
		,case when start_hut_altitude > mh2.altitude then 1 else 0 end as flag_altitude
		from 
		cte_trails1 t1 
		join mountain_huts mh2 on t1.end_hut=mh2.id) ,
	cte_final as 
		(select 
		case when flag_altitude = 1 then start_hut else end_hut end as start_hut
		,case when flag_altitude = 1 then start_hut_name else end_hut_name end as start_hut_name
		,case when flag_altitude = 1 then end_hut else start_hut end as end_hut
		,case when flag_altitude = 1 then end_hut_name else start_hut_name end as end_hut_name
		from
		cte_trails2) 
select 
cf1.start_hut_name as startpt
,cf1.end_hut_name as middlept
,cf2.end_hut_name as endpt
from cte_final cf1
join cte_final cf2 on cf1.end_hut = cf2.start_hut;
