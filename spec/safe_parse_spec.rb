RSpec.describe SafeParse do
  it 'should return correct value with correct json' do
    json_str = '{"abc": 123, "def": 456}'
    expect(SafeParse.extract_from_json(json_str, :abc)).to be 123
  end

  it 'should return correct value with different case key' do
    json_str = '{"abc": 123, "def": 456}'
    expect(SafeParse.extract_from_json(json_str, :Abc)).to be 123
  end

  it 'should return correct value with period notation case key' do
    json_str = '{"abc": { "def" : 123}, "def": 456}'
    expect(SafeParse.extract_from_json(json_str, 'abc.def')).to be 123
  end

  it 'should return correct value with period notation case key in incorrect casing' do
    json_str = '{"abc": { "def" : 123}, "def": 456}'
    expect(SafeParse.extract_from_json(json_str, 'abc.DEF')).to be 123
  end

  it 'should return default value with correct json and incorrect/missing key' do
    json_str = '{"abc": 123, "def": 456}'
    default = 789
    expect(SafeParse.extract_from_json(json_str, :abc_def, true, default)).to be default
  end

  it 'should return default value with incorrect json and optional flag' do
    json_str = 'X{"abc": 123, "def": 456}'
    default = 789
    expect(SafeParse.extract_from_json(json_str, :abc, true, default)).to be default
  end

  it 'should raise exception with incorrect json and not optional flag' do
    json_str = 'X{"abc": 123, "def": 456}'
    expect { SafeParse.extract_from_json(json_str, :abc) }.to raise_error JSON::ParserError
  end
end
