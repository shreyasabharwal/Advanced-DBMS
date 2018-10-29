poparty
=======

postgres party!

[![oclif](https://img.shields.io/badge/cli-oclif-brightgreen.svg)](https://oclif.io)
[![Version](https://img.shields.io/npm/v/poparty.svg)](https://npmjs.org/package/poparty)
[![Downloads/week](https://img.shields.io/npm/dw/poparty.svg)](https://npmjs.org/package/poparty)
[![License](https://img.shields.io/npm/l/poparty.svg)](https://github.com/adityachatterjee42/poparty/blob/master/package.json)

<!-- toc -->
* [Usage](#usage)
* [Commands](#commands)
<!-- tocstop -->
# Usage
<!-- usage -->
```sh-session
$ npm install -g poparty
$ poparty COMMAND
running command...
$ poparty (-v|--version|version)
poparty/0.0.0 win32-x64 node-v8.12.0
$ poparty --help [COMMAND]
USAGE
  $ poparty COMMAND
...
```
<!-- usagestop -->
# Commands
<!-- commands -->
* [`poparty addRecords`](#poparty-add-records)
* [`poparty hello`](#poparty-hello)
* [`poparty help [COMMAND]`](#poparty-help-command)
* [`poparty purge`](#poparty-purge)

## `poparty addRecords`

This command inserts synthetic data into an AWS postgres instance containing a database of hotels and reservations - the intended use is to rapidly load data in order to run database performance experiments

```
USAGE
  $ poparty addRecords

OPTIONS
  -g, --guests=guests              number of records to insert into guests table
  -h, --hotels=hotels              number of records to insert into hotels table
  -r, --rooms=rooms                number of records to insert into rooms table
  -s, --save                       save performance data into results_log table
  -x, --reservations=reservations  number of records to insert into reservations table

DESCRIPTION
  ...
  Extra documentation goes here
```

_See code: [src\commands\addRecords.js](https://github.com/adityachatterjee42/poparty/blob/v0.0.0/src\commands\addRecords.js)_

## `poparty hello`

Describe the command here

```
USAGE
  $ poparty hello

OPTIONS
  -n, --name=name  name to print

DESCRIPTION
  ...
  Extra documentation goes here
```

_See code: [src\commands\hello.js](https://github.com/adityachatterjee42/poparty/blob/v0.0.0/src\commands\hello.js)_

## `poparty help [COMMAND]`

display help for poparty

```
USAGE
  $ poparty help [COMMAND]

ARGUMENTS
  COMMAND  command to show help for

OPTIONS
  --all  see all commands in CLI
```

_See code: [@oclif/plugin-help](https://github.com/oclif/plugin-help/blob/v2.1.3/src\commands\help.ts)_

## `poparty purge`

Describe the command here

```
USAGE
  $ poparty purge

OPTIONS
  -l, --logs  delete performance metrics log table

DESCRIPTION
  ...
  Extra documentation goes here
```

_See code: [src\commands\purge.js](https://github.com/adityachatterjee42/poparty/blob/v0.0.0/src\commands\purge.js)_
<!-- commandsstop -->
