SRC = $(wildcard ./*/*.coffee)
STYLES = $(wildcard ./*/*.styl)
TEMPLATES = $(wildcard ./*/*.jade)

# For js-coverage see
# https://github.com/Frapwings/component-jscoverage
# and
# https://github.com/Frapwings/component-jscoverage/blob/master/example/Makefile
#--use component-jscoverage

build: index.html components $(SRC) $(STYLES) $(TEMPLATES) index.coffee index.html
	@component build -v --dev --use "component-jade,component-stylus,build-coffee.js"

build-prod: index.html components $(SRC) $(STYLES) $(TEMPLATES) index.coffee index.html
	@component build -v --dev --use "component-jade,component-stylus,build-coffee.js,component-minify"


components: component.json
	@component install --dev

clean:
	rm -fr build components

.PHONY: clean
