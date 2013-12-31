SRC = $(wildcard ./*/*.coffee)
STYLES = $(wildcard ./*/*.styl)
TEMPLATES = $(wildcard ./*/*.jade)
BROWSERS ?= 'ie6..11, chrome, iphone, safari, opera, firefox'

test = http://localhost:4200
component = node_modules/component/bin/component
uglifyjs = node_modules/uglify-js/bin/uglifyjs
phantomjs = node_modules/.bin/mocha-phantomjs --setting web-security=false --setting local-to-remote-url-access=true


default build: build/build.js



# For js-coverage see
# https://github.com/Frapwings/component-jscoverage
# and
# https://github.com/Frapwings/component-jscoverage/blob/master/example/Makefile
#--use component-jscoverage
#build-dev: index.html components $(SRC) $(STYLES) $(TEMPLATES) index.coffee index.html
#	@component build -v --dev --use "component-jade,component-stylus,build-coffee.js" -n mm-ui

#build: index.html components $(SRC) $(STYLES) $(TEMPLATES) index.coffee index.html
#	@component build -v  --use "component-jade,component-stylus,build-coffee.js,component-minify" -n mm-ui

build/build.js: node_modules components $(shell find lib)
	@component build -v --dev --use "component-jade,component-stylus,build-coffee.js" --name mm-ui

mm-ui.js: node_modules components $(shell find lib)
	@$(component) build -v  --standalone mirrormonkey --use "component-jade,component-stylus,build-coffee.js" --out ./dist --name mm-ui

#for minified:
#@$(component) build -v --dev --standalone mirrormonkey --use "component-jade,component-stylus,build-coffee.js,component-minify" --out ./dist --name mm-ui.min
#or
#@$(uglifyjs) ./dist/mm-ui.js --output mm-ui.min.js


# add 'test' target to release once exist
release: mm-ui.js

components: component.json
	@component install --dev

# add node_modules?
clean:
	rm -fr build components


node_modules: package.json
	@npm install

server: node_modules kill
	@node test/server/index.js &> /dev/null &

kill:
	-@test ! -s test/server/pid.txt || kill `cat test/server/pid.txt`
	@rm -f test/server/pid.txt


test: node_modules build/build.js server
	@sleep 1
	-@$(phantomjs) $(test)
	@make kill

test-browser: node_modules build/build.js server
	@sleep 1
	@open $(test)

coverage: node_modules build/build.js server
	@sleep 1
	@open $(test)/coverage

test-sauce: node_modules build/build.js server
	@sleep 1
	@BROWSERS=$(BROWSERS) node_modules/.bin/gravy --url $(test)

.PHONY: clean kill release server test test-browser test-sauce
