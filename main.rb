# frozen_string_literal: true

require_relative 'company'
require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'passenger_train'
require_relative 'passanger_vagon'
require_relative 'cargo_train'
require_relative 'cargo_vagon'

message = {
  interfase: "Enter num(or anything to finish):  \n1 - add new station \n2 - create new train
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
}

def add_vagon(list, message)
  puts message[:list_of_trains]
  list.each { |tr| puts tr.number }
  puts message[:enter_train_number]
  number = gets.chomp.to_i
  puts message[:enter_type_of_vagon]
  v = gets.chomp.to_i
  vagon = nil
  case v
  when 1
    vagon = VagonPassanger.new
  when 2
    vagon = VagonCargo.new
  else
    puts message[:error_vagon_type]
  end

  list.each { |tr| tr.hook(vagon) if number == tr.number }
end

def delete_vagon(list, message)
  puts message[:list_of_trains]
  list.each { |tr| puts tr.number }
  puts message[:enter_train_number]
  number = gets.chomp.to_i
  list.each { |tr| tr.unhook if number == tr.number }
end

def train_to_station(station_list, train_list, message)
  puts message[:list_of_stations]
  station_list.each { |st| puts "#{station_list.index(st)} - #{st.name}" }
  puts message[:enter_station_number]
  station = gets.chomp.to_i
  puts message[:list_of_trains]
  train_list.each { |tr| puts tr.number }
  puts message[:enter_train_number]
  number = gets.chomp.to_i
  train_list.each { |tr| station_list[station].coming(tr) if number == tr.number }
end

station_list = []
passanger_train_list = []
cargo_train_list = []
station = nil
train = nil

puts message[:interfase]
loop do
  fin = false
  choise = gets.chomp.to_i
  case choise

  when 1
    begin
      puts message[:enter_station_name]
      name = gets.chomp
      station = Station.new(name)
    rescue
      puts message[:error_station_name]
      retry
    end
    station_list << station

  when 2
    puts message[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    begin
      puts message[:enter_train_number]
      number = gets.chomp
      case tr_choise
      when 1
        train = PassangerTrain.new(number)
        passanger_train_list << train
      when 2
        train = CargoTrain.new(number)
        cargo_train_list << train
      else
        puts message[:error_input]
      end
    rescue
      puts message[:error_train_name]
      retry
    end

  when 3
    puts message[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1
      add_vagon(passanger_train_list, message)
    when 2
      add_vagon(cargo_train_list, message)
    else
      puts message[:error_input]
    end

  when 4
    puts message[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1
      delete_vagon(passanger_train_list, message)
    when 2
      delete_vagon(cargo_train_list, message)
    else
      puts message[:error_input]
    end

  when 5
    puts message[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1
      train_to_station(station_list, passanger_train_list, message)
    when 2
      train_to_station(station_list, cargo_train_list, message)
    else
      puts message[:error_input]
    end

  when 6
    station_list.each { |st| puts "Station name: #{st.name} #{st.show_all}" }

  else
    fin = true
  end

  break if fin
end
#
# station.all_stations
# train.company_name('AAA')
# train.company_get
