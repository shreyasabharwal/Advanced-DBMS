-- total reservations with hotel, room and guest data
create view master_view as 
select res.reservationid, res.hotelid, res.checkindate, res.guestid, guest.firstname, guest.lastname, hotel.hotelname, hotel.address as Hotel_Address, 
hotel.city as Hotel_City, hotel.zipcode as Hotel_Zipcode, res.roomid, room.roomnumber, room.roomtype, guest.address as Guest_Address,
guest.city as Guest_City, guest.zipcode as Guest_Zipcode
from reservation res
left join guest on res.guestid = guest.guestid
left join room on res.roomid = room.roomid
left join hotel on res.hotelid = hotel.hotelid


-- how many guests made reservations for each hotel
create view v_hotel_guest as
select hotel.hotelname, count(res.guestid) as No_of_guests
from reservation res
left join guest on res.guestid = guest.guestid
left join hotel on res.hotelid = hotel.hotelid
group by hotel.hotelname
order by No_of_guests DESC


-- calculating number of rooms for each hotel
create view v_hotelroom as
select h.hotelid, count(r.roomid), h.hotelname,
r.roomtype
from hotel h
join room r
on r.hotelid = h.hotelid
group by h.hotelid, r.roomtype;


select * from information_schema.table_constraints where
table_name='reservation'