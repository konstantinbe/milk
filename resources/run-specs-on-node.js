//
// Quick and extremely dirty reporter to run jasmine specs on NodeJS.
//

/*globals global jasmine process */

var verbose = true;

var jasmine = require('./jasmine/jasmine.js');

for(var key in jasmine) {
  global[key] = jasmine[key];
}

require('./milk.js');
require('./specs.js');

function colorize(string, color) {
    var color_code_begin = "\33[0m";
    var color_code_end = "\33[0m";

    switch (color) {
        case 'red':
        color_code_begin = "\33[31m";
        break;

        case 'green':
        color_code_begin = "\33[32m";
        break;

        case 'yellow':
        color_code_begin = "\33[33m";
        break;

        case 'blue':
        color_code_begin = "\33[34m";
        break;

        case 'magenta':
        color_code_begin = "\33[35m";
        break;

        case 'cyan':
        color_code_begin = "\33[36m";
        break;

        default:
        break;
    }

    return color_code_begin + string + color_code_end;
}

function print(string, color) {
    if (color) {
        string = colorize(string, color);
    }
    process.stdout.write(string);
}

function printLine(string, color) {
    print(string + "\n", color);
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

function failureMessageFor(spec) {
    var message = "\n    ";
    suitesFor(spec).forEach(function(suite) {
        message += suite.description + " ";
    });
    message += spec.description;

    spec.results().getItems().forEach(function(result) {
        if (result.type == 'expect' && !result.passed()) {
            message += "\n        - " + result.message;
        }
    });

    return message;
}

function printFailureMessageFor(spec) {
    printLine(failureMessageFor(spec));
}

jasmine.CommandLineReporter = function() {
    this.numberOfExamples = 0;
    this.numberOfFailedExamples = 0;
};

jasmine.CommandLineReporter.prototype.reportRunnerStarting = function(runner) {
    this.startedAt = new Date();
    printLine("\n");
};

jasmine.CommandLineReporter.prototype.reportRunnerResults = function(runner) {
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
                printFailureMessageFor(spec);
            }
        });
    }

    printLine("\nFinished in " + durationInSeconds + " seconds");
    color = results.failedCount > 0 ? 'red' : 'green';
    examples = this.numberOfExamples === 1 ? 'example' : 'examples';
    failures = this.numberOfFailedExamples === 1 ? 'failure' : 'failures';
    printLine(this.numberOfExamples + " " + examples + ", " + colorize(this.numberOfFailedExamples + " " + failures + "\n", color));
};

jasmine.CommandLineReporter.prototype.reportSuiteResults = function(suite) {
    // do nothing
};

jasmine.CommandLineReporter.prototype.reportSpecStarting = function(spec) {
    // do nothing
};

var counter = 0;

jasmine.CommandLineReporter.prototype.reportSpecResults = function(spec) {
    this.numberOfExamples++;

    if (!spec.results().passed()) {
        this.numberOfFailedExamples++;
    }

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

    if (verbose) {
        if (!spec.printed) {
            printLine(indentation + "- " + spec.description + (passed ? "" : colorize(" FAILED", 'red')));
            spec.printed = true;
        }

    } else {
        print(passed ? "." : colorize("F", 'red'));
        counter = counter >= 100 ? 0 : counter + 1;
        if (counter === 0) {
            print("\n");
        }
    }
};

jasmine.jasmine.getEnv().addReporter(new jasmine.CommandLineReporter());
jasmine.jasmine.getEnv().execute();
