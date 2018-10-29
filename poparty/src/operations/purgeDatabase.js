const { Client } = require('pg')

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

exports.purge = async function(deleteLogs){
    client = createClient();
    client.connect();
    commands = ['DELETE FROM reservation;', 'DELETE FROM room;', 'DELETE FROM hotel;', 'DELETE FROM guest;'];
    if(deleteLogs == true){
        commands.push('DELETE FROM results_log;');
    }
    for (var command in commands){
        var res = await client.query(commands[command]);
    }
    client.end();
}
