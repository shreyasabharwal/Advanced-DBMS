const {Command, flags} = require('@oclif/command')
const { purge } = require('../operations/purgeDatabase')


class PurgeCommand extends Command {
  async run() {
    const {flags} = this.parse(PurgeCommand)
    const deleteLogs = flags.logs
    console.log('purging database...')
    await purge(deleteLogs)
    console.log('...done')
    process.exit(0);

  }
}

PurgeCommand.description = `Describe the command here
...
Extra documentation goes here
`

PurgeCommand.flags = {
  logs: flags.boolean({char: 'l', default: false, description: 'delete performance metrics log table'}),
}

module.exports = PurgeCommand
