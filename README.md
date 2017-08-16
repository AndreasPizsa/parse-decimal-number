# parse-decimal-number ![Travis](https://img.shields.io/travis/AndreasPizsa/parse-decimal-number.svg?style=flat-square) [![Coverage Status](https://img.shields.io/coveralls/AndreasPizsa/parse-decimal-number.svg?style=flat-square)](https://coveralls.io/github/AndreasPizsa/parse-decimal-number?branch=master) ![Downloads](https://img.shields.io/npm/dm/parse-decimal-number.svg?style=flat-square)
> Parse a decimal number with i18n format support (localized decimal points and thousands separators)

## About
OK, let’s fix international numbers **parsing** and **validation** once and forever. I got the inspiration for this in a UI project because somehow the libraries we used didn’t do a great job, so I wrote my own parser, and this is a more polished version of it.

These are the design goals:

* **Simple.** String in, float out, done. ✓
* **Accurate.** Parses numbers and returns `NaN` for non-numbers. (=good for input validation) ✓
* **Lightweight.** (<1k minified) ✓
* **Complete.** No external dependencies ✓
* **Solid.** 100% Code Coverage ✓
* **CLDR Support.** Supports `cldr` data ✓

In it’s simplest form, you just use it as a `parseFloat` replacement.


## Install
#### Install with [npm](npmjs.org)

```bash
npm i parse-decimal-number --save
```

## Usage
```javascript
parseDecimalNumber = require('parse-decimal-number');
console.log(parseDecimalNumber('12,345,678.90'));
// -> 12345678.90

console.log(parseDecimalNumber('12.345.678,90','.,'));
// -> 12345678.90
```

### parseDecimalNumber(string _[,options]_)
Returns a `float` representation of _string_ or `NaN` if _string_ is not a parseable number. Use the optional `options` parameter to specify the thousands and decimal point characters.

#### Parameters
**string** A String that is supposed to contain a number.

**options** _optional_ A string, array or hash with thousands and decimal separators.

* _String_
  a two-character string consisting of the thousands character followed by the decimal point character, e.g. `',.'`

* _Array_
  An array of two elements, the first being the thousands character, the second being the decimal point character, e.g. `['.',',']`

* _Hash_ with the following elements (this is compatible with NumeralJS)
  * **`thousands`** thousands separator character. _Default:_ `,`
  * **`decimal`** decimal point character. _Default:_ `.`

**enforceGroupSize** A boolean indicating whether to support that individual groups between the thousands character are exactly 3 digits

#### Examples

```javascript
console.log(parseDecimalNumber('12.345.678,90'));
// -> 12345678.90
```

###### String `options`
```javascript
console.log(parseDecimalNumber('12.345.678,90','.,'));
// -> 12345678.90
```

###### Array `options`
```javascript
console.log(parseDecimalNumber('12.345.678,90',['.',',']));
// -> 12345678.90
```

###### Hash `options`
```javascript
var customSeparators = {thousands:'.',decimal:','};
console.log(parseDecimalNumber('12.345.678,90',customSeparators));
// -> 12345678.90
```

### parseDecimalNumber.withOptions(options)
Returns a _function_ that will take a _string_ as an argument and return a `float` or `NaN`, just like `parseDecimalNumber`.

#### Example

```javascript
  const cldr = require('cldr');

  const locale = 'de_DE';
  const options = cldr.extractNumberSymbols(locale);

  const parse = parseDecimalNumber.withOptions(options);

  parse('123.456.789,0123'); // -> 123456789.0123
```


### Setting and Resetting Default Options

##### parseDecimalNumber.setOptions
Set the default thousands and decimal characters that are used when no options are passed to `parseDecimalNumber`.

```javascript
var defaultSeparators = {thousands:'.',decimal:','};
parseDecimalNumber.setOptions(defaultSeparators);

console.log(parseDecimalNumber('12.345.678,90'));
// -> 12345678.90
```


##### parseDecimalNumber.factorySettings
has the same effect as `parseDecimalNumber.setOptions({thousands:',',decimal:'.'};)`

## Using with `cldr`

You can easily apply CLDR data using the [`cldr`](https://www.npmjs.com/package/cldr) package:

```javascript
  const cldr = require('cldr');

  parseDecimalNumber(
    '12.345.678,90',
    cldr.extractNumberSymbols('de_DE')
  );
```


## Using with Numeral.js
[Numeral.js](http://numeraljs.com/) is good at formatting numbers and comes with an extensive set of locale data that you can use with `parse-decimal-number`.

If you use `numeral` in your project, you can use their locale data as follows:

```javascript
parseDecimalNumber('12.345.678,90', numeral.localeData('de').delimiters);
// -> 12345678.9
```

You can of course use the same data to set the default values for `parse-decimal-number`:

```javascript
parseDecimalNumber.setOptions(numeral.localeData('de').delimiters);
parseDecimalNumber('12.345.678,90');
// -> 12345678.9
```

Done :relaxed:


## Related Projects
To keep this project as small and modular as possible, the locale data itself has been left out of this library. If you need locale date, other projects might be helpful:

* [cldr](https://www.npmjs.com/package/cldr)
* [Numeral](http://numeraljs.com)
* [jsi18n](https://github.com/marcoscaceres/jsi18n)
* [Unicode Common Locale Data Repository](http://cldr.unicode.org/index/downloads/latest)
* [Wikipedia](http://en.wikipedia.org/wiki/Decimal_mark#Examples_of_use)


## Running tests
{%= include("tests") %}

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality, and please re-build the documentation with [gulp-verb](https://github.com/assemble/gulp-verb) before submitting a pull request.


## Author

**Andreas Pizsa (http://github.com/AndreasPizsa)**

+ [github/AndreasPizsa](https://github.com/AndreasPizsa)
+ [twitter/AndreasPizsa](http://twitter.com/AndreasPizsa)

## License
Copyright (c) 2017 Andreas Pizsa (http://github.com/AndreasPizsa), contributors.  
