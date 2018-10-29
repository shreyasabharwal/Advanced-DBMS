    -- extracting details of guests staying in room num 15, hotel 'Dicki Inc' 

    explain analyze
    select firstname, lastname from master_view 
    where roomnumber = '15' and hotelname = 'Dicki Inc'
    and checkindate = '2018-08-07'


    "Nested Loop  (cost=0.56..68.89 rows=1 width=13) (actual time=0.032..0.300 rows=1 loops=1)"
"  ->  Nested Loop Left Join  (cost=0.28..63.56 rows=1 width=17) (actual time=0.022..0.283 rows=4 loops=1)"
"        ->  Nested Loop  (cost=0.00..61.12 rows=1 width=8) (actual time=0.014..0.263 rows=4 loops=1)"
"              Join Filter: (res.hotelid = hotel.hotelid)"
"              Rows Removed by Join Filter: 26"
"              ->  Seq Scan on hotel  (cost=0.00..3.25 rows=1 width=4) (actual time=0.008..0.013 rows=1 loops=1)"
"                    Filter: ((hotelname)::text = 'Dicki Inc'::text)"
"                    Rows Removed by Filter: 99"
"              ->  Seq Scan on reservation res  (cost=0.00..57.50 rows=30 width=12) (actual time=0.005..0.240 rows=30 loops=1)"
"                    Filter: (checkindate = '2018-08-07'::date)"
"                    Rows Removed by Filter: 2970"
"        ->  Index Scan using guest_pkey on guest  (cost=0.28..2.43 rows=1 width=17) (actual time=0.004..0.004 rows=1 loops=4)"
"              Index Cond: (res.guestid = guestid)"
"  ->  Index Scan using room_pkey on room  (cost=0.28..5.24 rows=1 width=4) (actual time=0.003..0.003 rows=0 loops=4)"
"        Index Cond: (roomid = res.roomid)"
"        Filter: (roomnumber = 15)"
"        Rows Removed by Filter: 1"
"Planning time: 0.804 ms"
"Execution time: 0.366 ms"


-- get hotelname with maximum guest count till date

explain analyze
select hotelname from v_hotel_guest
limit 1;

"Limit  (cost=111.13..111.14 rows=1 width=17) (actual time=3.478..3.478 rows=1 loops=1)"
"  ->  Subquery Scan on v_hotel_guest  (cost=111.13..112.37 rows=99 width=17) (actual time=3.477..3.477 rows=1 loops=1)"
"        ->  Sort  (cost=111.13..111.38 rows=99 width=25) (actual time=3.476..3.476 rows=1 loops=1)"
"              Sort Key: (count(res.guestid)) DESC"
"              Sort Method: quicksort  Memory: 32kB"
"              ->  HashAggregate  (cost=106.86..107.85 rows=99 width=25) (actual time=3.407..3.434 rows=98 loops=1)"
"                    Group Key: hotel.hotelname"
"                    ->  Hash Left Join  (cost=4.25..91.86 rows=3000 width=21) (actual time=0.073..2.295 rows=3000 loops=1)"
"                          Hash Cond: (res.hotelid = hotel.hotelid)"
"                          ->  Seq Scan on reservation res  (cost=0.00..50.00 rows=3000 width=8) (actual time=0.006..0.717 rows=3000 loops=1)"
"                          ->  Hash  (cost=3.00..3.00 rows=100 width=21) (actual time=0.061..0.061 rows=100 loops=1)"
"                                Buckets: 1024  Batches: 1  Memory Usage: 14kB"
"                                ->  Seq Scan on hotel  (cost=0.00..3.00 rows=100 width=21) (actual time=0.003..0.028 rows=100 loops=1)"
"Planning time: 0.199 ms"
"Execution time: 3.517 ms"


-- extracting number of classic rooms for hotel, 'OConner, Bergstrom and King'

explain analyze
select count from v_hotelroom
where roomtype='Classic' 
and hotelname = 'OConner, Bergstrom and King'

"Subquery Scan on v_hotelroom  (cost=164.72..165.25 rows=1 width=8) (actual time=2.658..2.659 rows=1 loops=1)"
"  ->  GroupAggregate  (cost=164.72..165.24 rows=1 width=198) (actual time=2.657..2.657 rows=1 loops=1)"
"        Group Key: h.hotelid, r.roomtype"
"        ->  Sort  (cost=164.72..164.85 rows=51 width=16) (actual time=2.628..2.638 rows=50 loops=1)"
"              Sort Key: h.hotelid"
"              Sort Method: quicksort  Memory: 27kB"
"              ->  Nested Loop  (cost=0.00..163.28 rows=51 width=16) (actual time=0.048..2.599 rows=50 loops=1)"
"                    Join Filter: (h.hotelid = r.hotelid)"
"                    Rows Removed by Join Filter: 4950"
"                    ->  Seq Scan on hotel h  (cost=0.00..3.25 rows=1 width=4) (actual time=0.007..0.015 rows=1 loops=1)"
"                          Filter: ((hotelname)::text = 'OConner, Bergstrom and King'::text)"
"                          Rows Removed by Filter: 99"
"                    ->  Seq Scan on room r  (cost=0.00..96.51 rows=5081 width=16) (actual time=0.004..1.538 rows=5000 loops=1)"
"                          Filter: ((roomtype)::text = 'Classic'::text)"
"Planning time: 0.211 ms"
"Execution time: 2.693 ms"





