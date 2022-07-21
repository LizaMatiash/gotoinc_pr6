# frozen_string_literal: true

# fff
class VagonPassanger
  include Company
  attr_reader :type

  def initialize
    @type = 'passanger'
  end
end
