let Web3 = require("web3");

let constants = require("./dmap-constants.js");

exports.context = constants.context;

exports.dPathRegex = /^(\.[a-z0-9-]{1,32})*\.$/;
exports.isDPath = function(path) {
    return exports.dPathRegex.test(path);
}

exports.get = function(path, log) {
    if( log == undefined ) {
        log = console.log;
    }
    log(`get ${path}`)
    if( !exports.isDPath(path) ) {
        let mustStart = path[0] == "."
                      ? ""
                      : "Path must start with a dot (.).";
        let mustEnd = path[path.length-1] == "."
                    ? ""
                    : "Path must end with a dot (.).";
        return Promise.reject(`Invalid path. ${mustStart} ${mustEnd}`);
    }
    return exports.walk(exports.context.relative, path, log)
        .catch((err) => {
            console.log(err);
        });
}

exports.walk = function(root, path, log) {
    if( log == undefined ) {
        log = console.log;
    }
    log(`walk ${path}`)
    if( !exports.isDPath(path) ) {
        return Promise.reject("Invalid path");
    }
    log(`step ${path}`)
    if( root == undefined || root == "" || root == "0x0") {
        root = exports.context.relative;
    }
    var register = root;
    let result = [];
    let step = function(path) {
        let cmd = `step ${path} -r ${register}`;
        log(cmd);
        if( register == ""
         || register == constants.ZERO_ADDRESS
         || register == constants.ZERO_BYTES32 )
        {
            let fail = `FAIL ${cmd}`;
            log(fail);
            return Promise.resolve(fail);
        }
        if( path == "." ) {
            log(`DONE ${register}`);
            return Promise.resolve(register);
        }
        let rune = ".";
        let words = path.split(rune)
        let word = words[1]
        let rest = path.slice(rune.length+word.length, path.length);
        return exports.getValue(register, word)
            .then((result) => {
                log(`  -> ${result}`);
                if (rest == "") {
                    return Promise.reject("UNREACHABLE");
                }
                register = result.substring(0, 42);
                return step(rest);
            });
    }
    return step(path);
}

exports.getValue = function(map, key) {
    var web3 = new Web3(exports.context.bootstrap);
    var dmap = new web3.eth.Contract(constants.types.dmap.abi, map);
    return dmap.methods
        .getValue(web3.utils.asciiToHex(key))
        .call()
}
