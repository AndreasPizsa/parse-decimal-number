(function() {
  var options, patterns;

  patterns = [];

  options = {};

  module.exports = function(value, inOptions, enforceGroupSize) {
    var decimal, fractionPart, integerPart, number, pattern, patternIndex, result, thousands;
    if (enforceGroupSize == null) {
      enforceGroupSize = true;
    }
    if (typeof inOptions === 'string') {
      if (inOptions.length !== 2) {
        throw {
          name: 'ArgumentException',
          message: 'The format for string options is \'<thousands><decimal>\' (exactly two characters)'
        };
      }
      thousands = inOptions[0];
      decimal = inOptions[1];
    } else if (inOptions instanceof Array) {
      if (inOptions.length !== 2) {
        throw {
          name: 'ArgumentException',
          message: 'The format for array options is [\'<thousands>\',\'[<decimal>\'] (exactly two elements)'
        };
      }
      thousands = inOptions[0];
      decimal = inOptions[1];
    } else {
      thousands = (inOptions != null ? inOptions.thousands : void 0) || options.thousands;
      decimal = (inOptions != null ? inOptions.decimal : void 0) || options.decimal;
    }
    patternIndex = "" + thousands + decimal + enforceGroupSize;
    pattern = patterns[patternIndex];
    if (!pattern) {
      if (enforceGroupSize) {
        pattern = patterns[patternIndex] = new RegExp('^\\s*([+\-]?(?:(?:\\d{1,3}(?:\\' + thousands + '\\d{3})+)|\\d*))(?:\\' + decimal + '(\\d*))?\\s*$');
      } else {
        pattern = patterns[patternIndex] = new RegExp('^\\s*([+\-]?(?:(?:\\d{1,3}(?:\\' + thousands + '\\d{1,3})+)|\\d*))(?:\\' + decimal + '(\\d*))?\\s*$');
      }
    }
    result = value.match(pattern);
    if (!result || result.length !== 3) {
      return 0/0;
    }
    integerPart = result[1].replace(new RegExp("\\" + thousands, 'g'), '');
    fractionPart = result[2];
    number = parseFloat(integerPart + "." + fractionPart);
    return number;
  };

  module.exports.setOptions = function(newOptions) {
    var key, value;
    for (key in newOptions) {
      value = newOptions[key];
      options[key] = value;
    }
  };

  module.exports.factoryReset = function() {
    return options = {
      thousands: ',',
      decimal: '.'
    };
  };

  module.exports.factoryReset();

}).call(this);
