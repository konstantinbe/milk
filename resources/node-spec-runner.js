jasmine = require('./jasmine/jasmine.js');

for(var key in jasmine) {
  global[key] = jasmine[key];
}

milk = require('./milk.js');
specs = require('./specs.js');
