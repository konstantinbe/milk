//
// Quick and extremely dirty reporter to run jasmine specs on NodeJS.
//

/*globals global jasmine process */

var verbose = false;

var jasmine = require('./jasmine/jasmine.js');

for(var key in jasmine) {
  global[key] = jasmine[key];
}

require('./milk.js');
require('./specs.js');

function stylize(string, style) {
    var styleCodeBegin = "\33[";
    var styleCodeEnd = "\33[0m";
    var styleCode = "0m";

    switch (style) {
        case 'red':
        styleCode = "31m";
        break;

        case 'green':
        styleCode = "32m";
        break;

        case 'yellow':
        styleCode = "33m";
        break;

        case 'blue':
        styleCode = "34m";
        break;

        case 'bold':
        styleCode = "1m";
        break;

        default:
        break;
    }

    return styleCodeBegin + styleCode + string + styleCodeEnd;
}

function print(string, color) {
    if (color) {
        string = stylize(string, color);
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
        if (!result.passed()) {
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
    printLine("");
};

jasmine.CommandLineReporter.prototype.reportRunnerResults = function(runner) {
    var finishedAt = new Date();
    var durationInSeconds = (finishedAt - this.startedAt) / 1000.0;

    var results = runner.results();

    if (!verbose) {
        printLine("");
    }

    if (results.failedCount > 0) {
        printLine(stylize("\nFAILURES:", 'bold'));

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
    printLine(this.numberOfExamples + " " + examples + ", " + stylize(this.numberOfFailedExamples + " " + failures + "\n", color));
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
            printLine(indentation + spec.description + (passed ? "" : stylize(" FAILED", 'red')));
            spec.printed = true;
        }

    } else {
        print(passed ? "." : stylize("F", 'red'));
        counter = counter >= 100 ? 0 : counter + 1;
        if (counter === 0) {
            print("\n");
        }
    }
};

jasmine.jasmine.getEnv().addReporter(new jasmine.CommandLineReporter());
jasmine.jasmine.getEnv().execute();
