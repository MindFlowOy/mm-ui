var coffeescript = require('coffee-script');
var path = require('path');
var fs = require('fs');

module.exports = function(builder) {

    // Monkey patching the builder alias()-method so that it doesn't add coffee files to aliases
    var orgAlias = builder.alias;
    builder.constructor.prototype.alias = function(a,b) {
        if (a.indexOf('coffee') != -1) {
            //return;
            // Or change the aliases?
            a = a.replace('.coffee', '.js');
            b = b.replace('.coffee', '.js');
        }
        var result = orgAlias.call(this, a, b);
        //console.log('=', result);
        return result;
    }

    // Before sciripts -hook
    builder.hook('before scripts', compileCoffee);



    // CoffeeScript converter
    function compileCoffee(pkg, cb) {

        // No scripts in the component.json
        if (pkg.config.scripts === undefined) return cb();

        // Filter coffee script
        var coffee = pkg.config.scripts.filter(function(file) {
              return path.extname(file) === '.coffee';
        });

        // No coffee scripts found
        if( coffee.length === 0 ) return cb();

        // Compile, save as js and remove
        coffee.forEach(function(file, i){
            var path = pkg.path(file);
            var str = fs.readFileSync(path, 'utf8');
            var code = coffeescript.compile(str, { filename : path, bare: true });
            var filename = file.replace('.coffee', '.js');
            pkg.addFile('scripts', filename, code);
            pkg.removeFile('scripts', file);
        });
        cb();

        // auto reboot
       // builder.append("require('boot');");
    };

    /*
    See https://github.com/gingkoapp/component-minify/blob/master/index.js If more options needed for minification
    // -> Use something like
    // Before styles -hook
    builder.hook('before scripts', addCSSPrefixes);
    function addPrefixes(pkg, cb) {
        // No styles
        if (!pkg.config.styles) return cb();

        var files = pkg.config.styles.filter(function(file) {
              return path.extname(file) === '.styl';
        });

        files.forEach(function(file) {
            var styl = fs.readFileSync(pkg.path(file), 'utf-8');
            css = autoprefixer.compile(css)
            pkg.addFile('styles', file, css);
        });

      process.nextTick(cb);
    }
    */

};

