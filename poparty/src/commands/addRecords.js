const {Command, flags} = require('@oclif/command')
const { createGuests, createHotels, createRooms, createReservations, addPerfData, createGuestsBatch, latency } = require('../operations/populateDatabase')
const perfy = require('perfy')

class AddRecordsCommand extends Command {
  async run() {
    const {flags} = this.parse(AddRecordsCommand)
    const guests = flags.guests || 0
    const hotels = flags.hotels || 0
    const rooms = flags.rooms || 0
    const reservations = flags.reservations || 0
    const batchsize = flags.batchsize || 1
    const comment = flags.comment
    if(flags.latency==true){
      var time = await latency();
      console.log(time);
      process.exit(0);
    }
    if(guests>0) {
      if(flags.bulk==true){
        this.log(`Attempting to BULK insert ${guests} guest records into database`)
        perfy.start('guest-inserts')
        await createGuestsBatch(guests, batchsize)
        var result = perfy.end('guest-inserts');
      }
      else {
        this.log(`Attempting to insert ${guests} guest records into database`)
        perfy.start('guest-inserts')
        await createGuests(guests)
        var result = perfy.end('guest-inserts');
      }
      console.log(`Insertion took ${result.time}`);
      if(flags.save==true){
        console.log('saving');
        await addPerfData(guests, result.time, flags.bulk, comment);
      }
    }
    if(hotels>0) {
      this.log(`Attempting to insert ${hotels} hotel records into database`)
      await createHotels(hotels)
    }
    if(rooms>0 && hotels>0) {
      this.log(`Attempting to insert ${rooms} room records into database`)
      await createRooms(rooms, hotels)
    }
    if(reservations>0 && rooms>0 && hotels>0 && guests>0) {
      this.log(`Attempting to insert ${reservations} reservation records into database`)
      await createReservations(reservations, guests, hotels, rooms)
    }
    process.exit(0);
  }
}

AddRecordsCommand.description = ` This command inserts synthetic data into an AWS postgres instance containing a database of hotels and reservations - the intended use is to rapidly load data in order to run database performance experiments
...
Extra documentation goes here
`

AddRecordsCommand.flags = {
  guests: flags.integer({char: 'g', description: 'number of records to insert into guests table'}),
  hotels: flags.integer({char: 'h', description: 'number of records to insert into hotels table'}),
  rooms: flags.integer({char: 'r', description: 'number of records to insert into rooms table'}),
  reservations: flags.integer({char: 'x', description: 'number of records to insert into reservations table'}),
  save: flags.boolean({char: 's', default: false, description: 'save performance data into results_log table'}),
  bulk: flags.boolean({char: 'b', default: false, description: 'use bulk load syntax (currently available only for guests)'}),
  batchsize: flags.integer({char: 'n', default: 0, description: 'batch size'}),
  comment: flags.string({char: 'c', default: '', description: 'comment'}),
  latency: flags.boolean({char: 'l', default: false, description: 'basic latency experiment'})
}

module.exports = AddRecordsCommand

