# frozen_string_literal: true

# fff
class VagonCargo < Vagon
  attr_reader :type

  def initialize
    @type = 'cargo'
  end
end
