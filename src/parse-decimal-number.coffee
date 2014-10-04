patterns=[]
options ={}

module.exports = (value,inOptions)->

  if typeof inOptions is 'string'
    if inOptions.length isnt 2 then throw {name:'ArgumentException',message:'The format for string options is \'<thousands><decimal>\' (exactly two characters)'}
    thousands = inOptions[0]
    decimal   = inOptions[1]
  else if inOptions instanceof Array
    if inOptions.length isnt 2 then throw {name:'ArgumentException',message:'The format for array options is [\'<thousands>\',\'[<decimal>\'] (exactly two elements)'}
    thousands = inOptions[0]
    decimal   = inOptions[1]
  else
    thousands = inOptions?.thousands or options.thousands
    decimal   = inOptions?.decimal    or options.decimal

  patternIndex = "#{thousands}#{decimal}"
  pattern = patterns[patternIndex]
  if not pattern
    pattern = patterns[patternIndex] = new RegExp ('^\\s*((?:\\d{1,3}(?:\\' + thousands + '\\d{3})+)|\\d*)(?:\\' + decimal + '(\\d*))?\\s*$')

  result = value.match pattern
  return NaN if not result or result.length != 3

  integerPart  = result[1].replace new RegExp("\\#{thousands}",'g'),''
  fractionPart = result[2]
  number = parseFloat "#{integerPart}.#{fractionPart}"
  return number

module.exports.setOptions = (newOptions)->
  options[key] = value for key, value of newOptions
  return

module.exports.factoryReset = ->
  options =
    thousands : ','
    decimal   : '.'

module.exports.factoryReset()
