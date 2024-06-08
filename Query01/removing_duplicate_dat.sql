


create table brands
(
 brand1  varchar,
 brand2  varchar,
 year    int,
 custom1 int,
 custom2 int,
 custom3 int,
 custom4 int
);

insert into brands(brand1,brand2,year,custom1,custom2,custom3,custom4) 
values('apple','samsung',2020,1,2,1,2);
insert  into brands values('samsung','apple',2020,1,2,1,2);
insert into brands values('apple','samsung',2021,1,2,5,3);
insert into brands values('samsung','apple',2021,5,3,1,2);
insert into brands values('google',null,2020,5,9,null,null);
insert into brands values('oneplus','nothing',2020,5,9,6,3);

select * from brands b ;

with cte as
    (select * 
	 
	, case  when brand1<brand2 then concat(brand1,brand2 , year)
	else concat(brand2,brand1,year) end as pair_id 
	from brands),
  cte_rn as
     (
     select * ,
     row_number() over(partition by pair_id order by pair_id) as rn
     from cte
     )
select brand1,brand2,year,custom1,custom2,custom3,custom4 
from cte_rn
where rn = 1
or (custom1 <> custom3 and custom2 <> custom4)
;