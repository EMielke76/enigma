require './keyable'
require './dateable'
require 'date'

module Encryptable
  include Keyable
  include Dateable
end
