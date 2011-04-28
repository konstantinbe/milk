//
// Quick and extremely dirty reporter to run jasmine specs on NodeJS, V8, and Nitro.
//

/*globals global jasmine process */

var verbose = false;
var numberOfColumns = 50;

var put = null;
var colorOutputSupported = true;

// Add a print function 'put()' required by the spec runner.
if (typeof process !== 'undefined') {
    // We are on NodeJS
    put = function(string) {
        process.stdout.write(string);
    };
} else if (typeof document !== 'undefined' && document.body && document.body.innerHTML) {
    put = function(string) {
        string = string.replace(/\n/g, "<br />");
        string = string.replace(/\[31m/g, "<span style='color:#ff6c60'>");
        string = string.replace(/\[32m/g, "<span style='color:#a8ff60'>");
        string = string.replace(/\[33m/g, "<span style='color:#ffffb6'>");
        string = string.replace(/\[34m/g, "<span style='color:#96cbfe'>");
        string = string.replace(/\[1m/g, "<span style='color:white; font-weight:bold'>");
        string = string.replace(/\[0m/, "</span>");
        document.body.innerHTML += string;
    };
} else {
    // Because vanilla V8 can only print full lines, we use a buffer
    // and flush it as soon as there is a newline.
    var putBuffer = "";
    put = function(string) {
        putBuffer += string;

        var lines = putBuffer.split("\n");
        for (var i = 0; i < lines.length - 1; i++) {
            print(lines[i]);
        }

        putBuffer = lines[lines.length - 1];
    };
}

function stylize(string, style) {
    if (!colorOutputSupported) {
        return string;
    }

    var styleCodeBegin = "\033[";
    var styleCodeEnd = "\033[0m";
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
    put(failureMessageFor(spec) + "\n");
}

jasmine.CommandLineReporter = function() {
    this.numberOfExamples = 0;
    this.numberOfFailedExamples = 0;
};

jasmine.CommandLineReporter.prototype.reportRunnerStarting = function(runner) {
    this.startedAt = new Date();
    put("\n");
};

jasmine.CommandLineReporter.prototype.reportRunnerResults = function(runner) {
    var finishedAt = new Date();
    var durationInSeconds = (finishedAt - this.startedAt) / 1000.0;

    var results = runner.results();

    if (!verbose) {
        put("\n");
    }

    if (results.failedCount > 0) {
        put(stylize("\nFAILURES:", 'bold') + "\n");

        runner.specs().forEach(function(spec) {
            if (!spec.results().passed()) {
                printFailureMessageFor(spec);
            }
        });
    }

    put("\nFinished in " + durationInSeconds + " seconds\n");
    color = results.failedCount > 0 ? 'red' : 'green';
    examples = this.numberOfExamples === 1 ? 'example' : 'examples';
    failures = this.numberOfFailedExamples === 1 ? 'failure' : 'failures';
    put(this.numberOfExamples + " " + examples + ", " + stylize(this.numberOfFailedExamples + " " + failures + "\n", color) + "\n");
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
                put("\n" + indentation + suite.description + "\n");
            }
            suite.printed = true;
        }
        indentation += "    ";
    });


    var passed = spec.results().passed();

    if (verbose) {
        if (!spec.printed) {
            put(indentation + "- " + spec.description + (passed ? "" : stylize(" FAILED", 'red')) + "\n");
            spec.printed = true;
        }

    } else {
        put(passed ? "." : stylize("F", 'red'));
        counter = counter >= numberOfColumns - 1 ? 0 : counter + 1;
        if (counter === 0) {
            put("\n");
        }
    }
};

jasmine.getEnv().addReporter(new jasmine.CommandLineReporter());
jasmine.getEnv().execute();
