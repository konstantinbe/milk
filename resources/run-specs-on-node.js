/*globals global jasmine process */

var verbose = false;

var jasmine = require('./jasmine/jasmine.js');

for(var key in jasmine) {
  global[key] = jasmine[key];
}

require('./milk.js');
require('./specs.js');

function print(string) {
    process.stdout.write(string);
}

function printLine(string) {
    print(string + "\n");
}

function suitesFor(spec) {
    var suites = [];
    var suite = spec.suite;
    while (suite) {
        suites.push(suite);
        suite = suite.parentSuite;
    }
    return suites.reverse();
}

function printFailureFor(spec) {
    var message = "\n    ";
    suitesFor(spec).forEach(function(suite) {
        message += suite.description + " => ";
    });
    message += spec.description;

    spec.results().getItems().forEach(function(result) {
        if (result.type == 'expect' && !result.passed()) {
            message += "\n        - " + result.message;
        }
    });

    printLine(message);
}

jasmine.TrivialReporter = function() {
    // do nothing
};

jasmine.TrivialReporter.prototype.reportRunnerStarting = function(runner) {
    this.startedAt = new Date();
};

jasmine.TrivialReporter.prototype.reportRunnerResults = function(runner) {
    var finishedAt = new Date();
    var durationInSeconds = (finishedAt - this.startedAt) / 1000.0;
    var results = runner.results();

    if (!verbose) {
        printLine("");
    }

    if (results.failedCount > 0) {
        printLine("\nFailures:");

        runner.specs().forEach(function(spec) {
            if (!spec.results().passed()) {
                printFailureFor(spec);
            }
        });
    }

    printLine("\nFinished in " + durationInSeconds + " seconds");
    printLine(results.totalCount + " examples, " + results.failedCount + " failures\n");
};

jasmine.TrivialReporter.prototype.reportSuiteResults = function(suite) {
    // do nothing
};

jasmine.TrivialReporter.prototype.reportSpecStarting = function(spec) {
    // do nothing
};

var counter = 0;

jasmine.TrivialReporter.prototype.reportSpecResults = function(spec) {
    var indentation = "";
    suitesFor(spec).forEach(function(suite){
        if (!suite.printed) {
            if (verbose) {
                printLine("\n" + indentation + suite.description);
            }
            suite.printed = true;
        }
        indentation += "    ";
    });

    var passed = spec.results().passed();
    var bullet = passed ? "- " : "* ";

    if (verbose) {
        printLine(indentation + bullet + spec.description);
    } else {
        print(passed ? "." : "F");
        counter = counter >= 80 ? 0 : counter + 1;
        if (counter === 0) {
            print("\n");
        }
    }
};

printLine("\n");

jasmine.jasmine.getEnv().addReporter(new jasmine.TrivialReporter());
jasmine.jasmine.getEnv().execute();
