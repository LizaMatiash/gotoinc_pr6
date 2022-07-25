# frozen_string_literal: true

# fff
class VagonPassanger < Vagon
  attr_reader :type

  def initialize
    @type = 'passanger'
  end
end
