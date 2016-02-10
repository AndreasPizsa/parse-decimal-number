assert = require 'assert'
_=require 'lodash'

parseDecimalNumber = require '../'

localSeparators = [
  {thousands:',', decimal:'.'}  # 1,234.56   -- United States
  {thousands:'.', decimal:','}  # 1.234,56   -- German
  {thousands:'\'', decimal:'.'} # 1'234.56   -- Switzerland
  {thousands:' ', decimal:','}  # 1 234,56   -- French
  {thousands:',', decimal:'/'}  # 1,234/56   -- Persian (Iran)
  {thousands:' ', decimal:'-'}  # 1 234-56   -- Kazakhstan
  {thousands:' ', decimal:' '}  # 1 234.56   -- Estonia
]

buildNumber = (max,doFraction,separators)->
  int = originalValue    = Math.ceil(Math.random() * max)

  string = ''
  while int > 999
    remainder = int % 1000
    zeros = if remainder < 100 then '0' else ''
    zeros += if remainder< 10 then '0' else ''
    string = separators.thousands + zeros + remainder + string
    int-=remainder
    int/=1000
  string = int + string
  if doFraction
    fraction = Math.ceil(Math.random() * 99999999)
    string += separators.decimal + fraction
    return text:string,number:parseFloat(originalValue+'.'+fraction)

  return text:string, number:originalValue

testAllNumbers = (maxInt,toFractions)->
  for separators in localSeparators
    number = buildNumber maxInt,toFractions,separators
    assert.strictEqual parseDecimalNumber(number.text, separators),number.number

describe 'parse-decimal-number',->
  beforeEach ->
    parseDecimalNumber.factoryReset()

  it 'correctly parses decimal formats with default options',->
    assert.strictEqual parseDecimalNumber('12,345,679.90'),12345679.90

  it 'correctly parses integer formats with default options',->
    assert.strictEqual parseDecimalNumber('12,345,679'),12345679

  it 'correctly parses normal integers with default options',->
    assert.strictEqual parseDecimalNumber('12345679'),12345679

  it 'can set other options and then parse correctly',->
    parseDecimalNumber.setOptions thousands:' ', decimal:':'
    assert.strictEqual parseDecimalNumber('123 456 789:98765432'),123456789.98765432

  it 'correctly parses normal floats with default options',->
    assert.strictEqual parseDecimalNumber('12345679.09'),12345679.09

  it 'correctly parses negative floats with default options',->
    assert.strictEqual parseDecimalNumber('-12345679.09'),-12345679.09

  it 'correctly parses all decimal formats',->
    testAllNumbers 999999999,true

  it 'correctly parses all integer formats',->
    testAllNumbers 999999999,false

  it 'correctly parses all decimal formats < 1000',->
    testAllNumbers 1000,true

  it 'correctly parses all integer formats < 1000',->
    testAllNumbers 1000,false

  it 'returns NaN if a value can\'t be parsed', ->
    assert.strictEqual _.isNaN(parseDecimalNumber('whatever', {thousands:',',decimal:'.'})), true

  it 'accepts a two-character string as options argument', ->
    assert.strictEqual parseDecimalNumber('123,456.78', ',.'), 123456.78

  it 'throws an error if a string with a length other than two is used as options argument', ->
    assert.throws -> parseDecimalNumber('123,456.78', 'ABC')
    assert.throws -> parseDecimalNumber('123,456.78', 'D')

  it 'accepts a two-element array as options', ->
    assert.strictEqual parseDecimalNumber('123,456.78', [',','.']), 123456.78

  it 'throws an error if an array with a length other than two is used as options argument', ->
    assert.throws -> parseDecimalNumber('123,456.78', [',','.','#'])
    assert.throws -> parseDecimalNumber('123,456.78', [','])
