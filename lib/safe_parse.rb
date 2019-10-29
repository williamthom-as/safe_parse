require 'json'

# The most lazy way to find things in hashes and JSON.
# Provides default and optional params
# Provides safe navigation with hash key dot notation ('this.is.a.key')
module SafeParse

  # @param [String] json_str
  # @param [Symbol] key
  # @param [Boolean] optional
  # @param [Object] default
  # @return [Object]
  def self.extract_from_json(json_str, key, optional = false, default = nil)
    json = lazy_parse_json(json_str)
    extract_from_hash(json, key, optional, default)
  rescue JSON::ParserError, ArgumentError => e
    raise e unless optional
    default
  end

  # @param [Hash] hash
  # @param [Symbol] key
  # @param [Boolean] optional
  # @param [Object] default
  # @return [Object]
  def self.extract_from_hash(hash, key, optional = false, default = nil)
    return hash[key] || default if hash.key? key
    return hash[key.to_s] || default if hash.key? key.to_s

    return nil unless optional
    default
  end

  # @param [String] json_str
  # @param [Boolean] optional
  # @param [Object] default
  # @return [Hash]
  def self.lazy_parse_json(json_str)
    if json_str.nil? || !json_str.is_a?(String)
      raise ArgumentError, "Invalid string passed: #{json_str}"
    end

    JSON.parse(json_str)
  end

end
