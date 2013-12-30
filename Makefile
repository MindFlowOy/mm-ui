SRC = $(wildcard ./*/*.coffee)
STYLES = $(wildcard ./*/*.styl)
TEMPLATES = $(wildcard ./*/*.jade)

# For js-coverage see
# https://github.com/Frapwings/component-jscoverage
# and
# https://github.com/Frapwings/component-jscoverage/blob/master/example/Makefile
#--use component-jscoverage

build: index.html components $(SRC) $(STYLES) $(TEMPLATES) index.coffee index.html
	@component build -v --dev --use "component-jade,component-stylus,build-coffee.js,component-minify" -n mm


build-dev: index.html components $(SRC) $(STYLES) $(TEMPLATES) index.coffee index.html
	@component build -v --dev --use "component-jade,component-stylus,build-coffee.js" -n mm


components: component.json
	@component install --dev

clean:
	rm -fr build components

.PHONY: clean

.PHONY: livereload
