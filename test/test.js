var fs = require("fs");
var cp = require("child_process");
var assert = require("assert");

it("pass", ()=>{}); // This is necessary to pick up tests in callback
describe("regression tests", () => {
    var filenames;
    var truths = {};
    fs.readdir("test/truth", (err, files) => {
        if(err) { throw err; }
        filenames = files;
        for(filename of filenames) {
            fs.readFile("test/truth/" + filename, (err, truth) => {
                if(err) throw err;
                truths[filename] = truth;
            });
            it(filename, (done) => {
                let cmd = "cmd/dmap-cmd.js " + filename;
                console.log(cmd);
                cp.exec(cmd, (err, stdout, stderr) => {
                    if(err) { throw err; }
                    if(stderr) { throw stderr; }
                    assert.equal(stdout, truths[filename]);
                    done();
                });
            });
        }
    });
});
