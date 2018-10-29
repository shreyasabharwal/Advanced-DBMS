var faker = require('faker')
const { Client } = require('pg')
const perfy = require('perfy')
const stats = require('stats-lite')

function createClient(){
    client = new Client({
        user: 'masterusername',
        host: 'rds-postgresql-hotelreservation.cqfnnuiplrsh.us-east-2.rds.amazonaws.com',
        database: 'hotelreservation',
        password: 'aass!!07',
        port: 5432
    });

    return client;
}

function getRandom(min, max) {
    return Math.floor(Math.random() * (max - min) + min);
}

exports.createGuests = async function(n){
    client = createClient();
    client.connect();
    var queries = [];
    for(var guestid=1; guestid<=n; guestid++){
        var text = 
        `INSERT INTO guest(guestid, firstname, lastname, address, city, zipcode) 
        VALUES(${guestid}, 
        '${faker.name.firstName().replace(/'/g, "")}',
        '${faker.name.lastName().replace(/'/g, "")}',
        '${faker.address.streetAddress().replace(/'/g, "")}',
        '${faker.address.city().replace(/'/g, "")}',
        ${faker.address.zipCode()}
        )`;
        queries.push(client.query(text));
    }
    await Promise.all(queries);

    client.end();
}

exports.createGuestsBulk = async function(n) {
    client = createClient();
    client.connect();
    var text = `INSERT INTO guest(guestid, firstname, lastname, address, city, zipcode) VALUES`;
    for(var guestid=1; guestid<=n; guestid++){
        text += 
        `(${guestid}, 
        '${faker.name.firstName().replace(/'/g, "")}',
        '${faker.name.lastName().replace(/'/g, "")}',
        '${faker.address.streetAddress().replace(/'/g, "")}',
        '${faker.address.city().replace(/'/g, "")}',
        ${faker.address.zipCode()}
        ),`;
    }
    text = text.substring(0, text.length - 1);

    var res = await client.query(text);
    await client.end();
    
}

exports.createGuestsBatch = async function(n, b) {
    client = createClient();
    client.connect();
    var guestid = 1;
    for(var i=0; i<n/b; i++){
        var text = `INSERT INTO guest(guestid, firstname, lastname, address, city, zipcode) VALUES`;
        for(var j=0; j<b; j++){
        text += 
        `(${guestid++}, 
        '${faker.name.firstName().replace(/'/g, "")}',
        '${faker.name.lastName().replace(/'/g, "")}',
        '${faker.address.streetAddress().replace(/'/g, "")}',
        '${faker.address.city().replace(/'/g, "")}',
        ${faker.address.zipCode()}
        ),`;
        }
        text = text.substring(0, text.length - 1);
        var res = await client.query(text);     
    }
    await client.end();
}

exports.createRooms = async function(r, n){
    client = createClient();
    client.connect();
    for(var hotelid=1; hotelid<=n; hotelid++){
        for(var roomnumber=1; roomnumber<=r; roomnumber++){
            var text = 
            `INSERT INTO room(roomid, roomnumber, hotelid) 
            VALUES(${hotelid*100+roomnumber}, 
            '${roomnumber}',
            '${hotelid}'
            )`;
            var res = await client.query(text);
            //console.log(res);
        }
    }
    await client.end();
}

exports.createHotels = async function(n){
    client = createClient();
    client.connect();
    for(var hotelid=1; hotelid<=n; hotelid++){
        var text = 
        `INSERT INTO hotel(hotelid, hotelname, address, city, zipcode) 
        VALUES(${hotelid}, 
        '${faker.company.companyName().replace(/'/g, "")}',
        '${faker.address.streetAddress().replace(/'/g, "")}',
        '${faker.address.city().replace(/'/g, "")}',
        ${faker.address.zipCode()}
        )`;
        var res = await client.query(text);
        //console.log(res);
    }
    await client.end();
}

exports.createReservations = async function(n, g, h, r){
    client = createClient();
    client.connect();
    for(var i=1; i<=n; i++){
        var hotel = getRandom(1, h);
        var room = getRandom(1, r);
        var guest = getRandom(1, g);
        var roomid = hotel*100+room;
        var text = 
        `INSERT INTO reservation(reservationid, hotelid, roomid, guestid, checkindate, numberofdays) 
        VALUES(${i}, 
        ${hotel},
        ${roomid},
        ${guest},
        NOW() - '1 day'::INTERVAL * ROUND(RANDOM() * 100),
        ${getRandom(1, 20)}
        )`;
        var res = await client.query(text);
        //console.log(res);
    }
    await client.end();
}

exports.addPerfData = async function(records, time, bulk=false, comment) {
    client = createClient();
    client.connect();
    //var comment = bulk?'from_client_bulk':'from_client';w
    var text =
    `INSERT INTO results_log(batch_size, index_desc, time_elapsed, throughput, notes) VALUES(${records},
    'standard',
    ${time},
    ${records/time},
    '${comment}'
    )`;
    var res = await client.query(text);
    return res;
    await client.end();
}

exports.latency = async function() {
    client = createClient();
    client.connect();
    var results = [];
    for(var i=1; i<=100; i++){
        perfy.start('latency');
        await client.query('SELECT 1;');
        var res =  await perfy.end('latency').time;
        results.push(res);
    }
    return {
        'mean': stats.mean(results),
        'median': stats.median(results),
        'variance': stats.variance(results),
        'sd': stats.stdev(results) 
    };
    
}

