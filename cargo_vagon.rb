# frozen_string_literal: true

# fff
class VagonCargo
  include Company
  attr_reader :type

  def initialize
    @type = 'cargo'
  end
end
