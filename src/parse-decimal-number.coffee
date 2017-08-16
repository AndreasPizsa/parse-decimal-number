patterns=[]
options ={}

module.exports = (value,inOptions,enforceGroupSize=true)->

  if typeof inOptions is 'string'
    if inOptions.length isnt 2 then throw {name:'ArgumentException',message:'The format for string options is \'<thousands><decimal>\' (exactly two characters)'}
    [thousands, decimal] = inOptions
  else if Array.isArray inOptions
    if inOptions.length isnt 2 then throw {name:'ArgumentException',message:'The format for array options is [\'<thousands>\',\'[<decimal>\'] (exactly two elements)'}
    [thousands, decimal] = inOptions
  else
    thousands = inOptions?.thousands or options.thousands
    decimal   = inOptions?.decimal   or options.decimal

  patternIndex = "#{thousands}#{decimal}#{enforceGroupSize}"
  pattern = patterns[patternIndex]
  unless pattern?
    groupMinSize = if enforceGroupSize then 3 else 1
    pattern = patterns[patternIndex] = new RegExp "^\\s*([+\-]?(?:(?:\\d{1,3}(?:\\#{thousands}\\d{#{groupMinSize},3})+)|\\d*))(?:\\#{decimal}(\\d*))?\\s*$"

  result = value.match pattern
  return NaN unless result? and result.length is 3

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
  return

module.exports.factoryReset()
