# frozen_string_literal: true

require_relative 'company'
require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'vagon'
require_relative 'passenger_train'
require_relative 'passanger_vagon'
require_relative 'cargo_train'
require_relative 'cargo_vagon'

MESSAGE = {
  interfase: "\nEnter num(or anything to finish):  \n1 - add new station \n2 - create new train
3 - hook vagon to train \n4 - unhook vagon \n5 - add train to station \n6 - list of stations and trains",
  enter_station_name: 'Enter station name: ',
  enter_train_choise: "Which train you want to edit \n1 - passanger \n2 - cargo",
  enter_train_number: 'Enter train number: ',
  error_input: 'Your input is wrong',
  list_of_trains: 'List of your trains: ',
  enter_type_of_vagon: 'Enter 1 - passanger vagon, 2 - cargo vagon',
  error_vagon_type: 'There is no such type',
  list_of_stations: 'List of your stations: ',
  enter_station_number: 'Enter station index: ',
  error_station_name: 'Station name shoud start with big letter and be only with letters',
  error_train_name: 'Train name should look like XXX-XX or XXXXX'
}.freeze

# main class
class MainClass
  attr_accessor :station, :station_list, :cargo_train_list, :passanger_train_list

  def initialize
    @station_list = []
    @passanger_train_list = []
    @cargo_train_list = []
    @station = nil
    @train = nil
  end

  METHOD = {
    1 => :add_station,
    2 => :add_train,
    3 => :add_vagon,
    4 => :delete_vagon,
    5 => :train_on_station,
    6 => :show_all
  }.freeze

  def start_main
    loop do
      puts MESSAGE[:interfase]
      fin = false
      choise = gets.chomp.to_i

      choise.between?(1, METHOD.length) ? send(METHOD[choise]) : fin = true

      break if fin
    end
  end

  def add_station
    begin
      puts MESSAGE[:enter_station_name]
      name = gets.chomp
      station = Station.new(name)
    rescue
      puts MESSAGE[:error_station_name]
      retry
    end
    station_list << station
  end

  def add_train
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    begin
      puts MESSAGE[:enter_train_number]
      number = gets.chomp
      case tr_choise
      when 1
        train = PassangerTrain.new(number)
        passanger_train_list << train
      when 2
        train = CargoTrain.new(number)
        cargo_train_list << train
      else
        puts MESSAGE[:error_input]
      end
    rescue
      puts MESSAGE[:error_train_name]
      retry
    end
  end

  def add_vagon
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then hook_vagon(passanger_train_list)
    when 2 then hook_vagon(cargo_train_list)
    else puts MESSAGE[:error_input]
    end
  end

  def delete_vagon
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then unhook_vagon(passanger_train_list)
    when 2 then unhook_vagon(cargo_train_list)
    else puts MESSAGE[:error_input]
    end
  end

  def train_on_station
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then train_to_station(station_list, passanger_train_list)
    when 2 then train_to_station(station_list, cargo_train_list)
    else puts MESSAGE[:error_input]
    end
  end

  def show_all
    station_list.each { |st| puts "Station name: #{st.show_all} #{st.name} " }
  end

  private

  def hook_vagon(list)
    puts MESSAGE[:list_of_trains]
    list.each { |tr| puts tr.number }
    puts MESSAGE[:enter_train_number]
    number = gets.chomp.to_i
    puts MESSAGE[:enter_type_of_vagon]
    v = gets.chomp.to_i
    vagon = nil
    case v
    when 1 then vagon = VagonPassanger.new
    when 2 then vagon = VagonCargo.new
    else puts MESSAGE[:error_vagon_type]
    end
    list.each { |tr| tr.hook(vagon) if number == tr.number }
  end

  def unhook_vagon(list)
    puts MESSAGE[:list_of_trains]
    list.each { |tr| puts tr.number }
    puts MESSAGE[:enter_train_number]
    number = gets.chomp.to_i
    list.each { |tr| tr.unhook if number == tr.number }
  end

  def train_to_station(station_list, train_list)
    puts MESSAGE[:list_of_stations]
    station_list.each { |st| puts "#{station_list.index(st)} - #{st.name}" }
    puts MESSAGE[:enter_station_number]
    station = gets.chomp.to_i
    puts MESSAGE[:list_of_trains]
    train_list.each { |tr| puts tr.number }
    puts MESSAGE[:enter_train_number]
    number = gets.chomp
    train_list.each { |tr| station_list[station].coming(tr) if number == tr.number }
  end
end

# ----------------------------------------------------------------------------------------
main = MainClass.new
main.start_main
