# frozen_string_literal: true

# sss
class Station
  attr_reader :train
  attr_accessor :name

  VALIDATION = /^[A-Z]{1}[a-z]+$/

  @@all = []

  def initialize(name)
    @name = name
    validate!
    @train = {}
    @@all << name
    puts "Station #{name} was created!"
  end

  def coming(trn)
    train[trn.number] = { type: trn.type, size: trn.size }
    puts "Trains that stands here: #{train.keys.join(', ')}"
  end

  def show_all
    puts "Trains that stands here: #{train.keys.join(', ')}"
  end

  # грузові
  def show_freight
    puts 'Freigh trains that stands here: '
    train.each { |k, _v| puts k if train[k][:type] == 'freight' }
  end

  # пасажирські
  def show_passanger
    puts 'Passanger trains that stands here: '
    train.each { |k, _v| puts k if train[k][:type] == 'passanger' }
  end

  def send(number)
    train.delete(number)
  end

  def self.all_stations
    @@all.each { |station| puts station }
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Name can't be that" if name !~ VALIDATION

    true
  end
end
