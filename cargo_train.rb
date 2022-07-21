# frozen_string_literal: true

# gggg
class CargoTrain < Train
  attr_accessor :type

  def initialize(number)
    super
    @type = 'cargo'
  end

  def hook(vagon)
    puts (@speed.zero? && vagon.type == 'cargo') ? self.size << vagon : 'Can`t hook vagon'
  end

  def unhook
    puts (@speed.zero? && size.any?) ? self.size.pop : 'Can`t unhook vagon'
  end
end
