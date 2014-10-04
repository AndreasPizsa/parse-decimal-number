# Using with Numeral.js
[Numeral.js](http://numeraljs.com/) is good at formatting numbers and comes with an extensive set of locale data that you can use with `parse-decimal-number`.

If you use `numeral` in your project, you can use their locale data as follows:

```javascript
parseDecimalNumber('12.345.678,90', numeral.countryData('de').delimiters);
// -> 12345678.9
```

You can of course use the same data to set the default values for `parse-decimal-number`:

```javascript
parseDecimalNumber.setOptions(numeral.countryData('de').delimiters);
parseDecimalNumber('12.345.678,90');
// -> 12345678.9
```

Done :relaxed:
