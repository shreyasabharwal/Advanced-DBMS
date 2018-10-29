
/*SEL - Finding reservations for a specific date range*/
select * from reservation where checkindate between '2018-08-01' and '2018-09-01'

/*JOIN - Finding reservation and room details for a specific date range for check-in*/

select r1.reservationid, r1.numberofdays, r2.roomtype, r2.roomnumber, r2.hotelid
from reservation r1
join room r2
on r1.roomid = r2.roomid
where  r1.checkindate between '2018-08-01' and '2018-09-01'

/*GRP - Finding average of number of stay for guests based on room type*/
select round(avg(r1.numberofdays),2), r2.roomtype
from reservation r1
join room r2
on r1.roomid = r2.roomid
where  r1.checkindate between '2018-08-01' and '2018-09-01'
group by r2.roomtype
