```javascript
parseDecimalNumber = require('parse-decimal-number');
console.log(parseDecimalNumber('12,345,678.90'));
// -> 12345678.90

console.log(parseDecimalNumber('12.345.678,90','.,'));
// -> 12345678.90
```

## parseDecimalNumber(string _[,options]_)
Returns a `float` representation of _string_ or `NaN` if _string_ is not a parseable number. Use the optional `options` parameter to specify the thousands and decimal point characters.

### Parameters
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

### Examples

```javascript
console.log(parseDecimalNumber('12.345.678,90'));
// -> 12345678.90
```

##### String `options`
```javascript
console.log(parseDecimalNumber('12.345.678,90','.,'));
// -> 12345678.90
```

##### Array `options`
```javascript
console.log(parseDecimalNumber('12.345.678,90',['.',',']));
// -> 12345678.90
```

##### Hash `options`
```javascript
var customSeparators = {thousands:'.',decimal:','};
console.log(parseDecimalNumber('12.345.678,90',customSeparators));
// -> 12345678.90
```

## Setting and Resetting Default Options

#### parseDecimalNumber.setOptions
Set the default thousands and decimal characters that are used when no options are passed to `parseDecimalNumber`.

```javascript
var defaultSeparators = {thousands:'.',decimal:','};
parseDecimalNumber.setOptions(defaultSeparators);

console.log(parseDecimalNumber('12.345.678,90'));
// -> 12345678.90
```


#### parseDecimalNumber.factorySettings
has the same effect as `parseDecimalNumber.setOptions({thousands:',',decimal:'.'};)`
