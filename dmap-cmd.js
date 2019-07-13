#!/usr/bin/env node

var cli = require('commander');
var dmap = require('./dmap-lib.js');

function processOptions(options) {
    if (options.relative) {
        dmap.context.relative = options.relative;
    }
}

cli
    .arguments("[path]")
    .option("-r, --relative <addr>", "execute relative to given address")
cli
    .command("get <path>")
    .description("get the value at the given dmap path")
    .action((path, options) => {
        var logger = () => {};
        processOptions(options.parent);
        dmap.get(path, logger)
            .then(console.log)
            .then(process.exit);
    });
cli
    .command("walk <path>")
    .description("traverse the given path, logging steps")
    .action((path, options) => {
        processOptions(options.parent);
        dmap.walk("", path, console.log)
            .then((ret) => {
                process.exit(0);
            })
    })
cli
    .command("abi <type>")
    .description("Print the ABI for a type known to dmap")
    .action((typename) => {
        var types = require("./dmap-types");
        var t = types[typename];
        if (t != undefined) {
            console.log(JSON.stringify(JSON.parse(t.abi)));
        }
    });

cli.parse(process.argv);

if (cli.args.length == 1) {
    processOptions(cli.options);
    var logger = () => {};
    dmap.get(cli.args[0], logger)
        .then(console.log)
        .then(process.exit)
}

if (cli.args.length == 0) {
    cli.help();
    process.exit(0);
}

