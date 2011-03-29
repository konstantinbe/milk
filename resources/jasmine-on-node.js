/*globals jasmine */

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

    console.log(message);
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

    if (results.failedCount > 0) {
        console.log("\nFailures:");

        runner.specs().forEach(function(spec) {
            if (!spec.results().passed()) {
                printFailureFor(spec);
            }
        });
    }

    console.log("\nFinished in " + durationInSeconds + " seconds");
    console.log(results.totalCount + " examples, " + results.failedCount + " failures\n");
};

jasmine.TrivialReporter.prototype.reportSuiteResults = function(suite) {
    // do nothing
};

jasmine.TrivialReporter.prototype.reportSpecStarting = function(spec) {
    // do nothing
};

jasmine.TrivialReporter.prototype.reportSpecResults = function(spec) {
    var indentation = "";
    suitesFor(spec).forEach(function(suite){
        if (!suite.printed) {
            console.log("\n" + indentation + suite.description);
            suite.printed = true;
        }
        indentation += "    ";
    });

    var passed = spec.results().passed();
    var bullet = passed ? "- " : "* ";
    console.log(indentation + bullet + spec.description);
};
