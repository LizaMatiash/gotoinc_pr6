# frozen_string_literal: true

# hhhhhh
class PassangerTrain < Train
  attr_accessor :type

  def initialize(number)
    super
    @type = 'passanger'
  end

  def hook(vagon)
    puts (@speed.zero? && vagon.type == 'passanger') ?  self.size << vagon: 'Can`t hook vagon'
  end

  def unhook
    puts (@speed.zero? && size.any?) ? self.size.pop : 'Can`t unhook vagon'
  end
end
