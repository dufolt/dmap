#!/usr/bin/env node

var cli = require('commander');
var dmap = require('./dmap-lib.js');

function processOptions(options) {
    if (options.relative) {
        dmap.context.relative = options.relative;
    }
}

cli
    .option("-r, --relative <addr>", "execute relative to given address")
cli
    .command("<path>")
    .description("`get <path>`")
cli
    .command("get <path>")
    .description("get the value at the given dmap path")
    .action((path, options) => {
        var logger = () => {};
        processOptions(options.parent);
        dmap.get(path, logger)
            .then(console.log)
            .then(process.exit)
            .catch((err) => { console.log(err); });
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
            .catch((err) => {console.log(err); });
    })
cli
    .command("type-list")
    .description("Print a list of known type names")
    .action(() => {
        var types = require("./dmap-types");
        for (t in types) {
            console.log(t);
        }
        process.exit();
    });
cli
    .command("type-abi <type>")
    .description("Print the ABI for a given type")
    .action((typename) => {
        var types = require("./dmap-types");
        var t = types[typename];
        if (t != undefined) {
            console.log(JSON.stringify(t.abi));
        }
        process.exit();
    });
cli
    .command("type-bin <type>")
    .description("Print the bytecode for a type")
    .action((typename) => {
        var types = require("./dmap-types");
        var t = types[typename];
        if (t != undefined) {
            console.log(t.bin);
        }
        process.exit();
    });
cli
    .command("type-rtb <type>")
    .description("Print the runtime bytecode for a type")
    .action((typename) => {
        var types = require("./dmap-types");
        var t = types[typename];
        if (t != undefined) {
            console.log(t.bin);
        }
        process.exit();
    });



cli.parse(process.argv);

if (cli.args.length == 1) {
    processOptions(cli.options);
    var logger = () => {};
    dmap.get(cli.args[0], logger)
        .then(console.log)
        .then(process.exit)
        .catch((err) => {console.log(err); });
}

if (cli.args.length == 0) {
    cli.help();
    process.exit(0);
}

