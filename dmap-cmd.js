#!/usr/bin/env node

var cli = require('commander');
var dmap = require('./dmap-lib.js');

cli
    .arguments("[path]")
    .option("-r, --relative <addr>", "execute relative to given address")
cli
    .command("get <path>")
    .description("get the value at the given dmap path")
    .action((path, cmd) => {
        dmap.get(path, console.log)
            .then((ret) => {
                console.log(ret);
                process.exit(0);
            })
    });
cli
    .command("walk <path>")
    .description("traverse the given path, logging steps")
    .action((path, cmd) => {
        dmap.walk("", path, console.log)
            .then((ret) => {
                process.exit(0);
            })
    })
cli
    .command("abi <type>")
    .description("Print the ABI for a type known to dmap")
    .action((typename) => {
        var types = require("./dmap-abi");
        var t = types[typename];
        if (t != undefined) {
            console.log(JSON.stringify(JSON.parse(t.abi)));
        }
    });

cli.parse(process.argv);

if (cli.args.length == 0 || cli.args.length == 1) {
    cli.help();
    process.exit(0);
}

