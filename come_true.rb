Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'rexml/document'
require 'date'

current_path = File.dirname(__FILE__)
file_name = current_path + '/wish_chest.xml'

file = File.new(file_name, "r:UTF-8")
doc = nil

begin
  doc = REXML::Document.new(file)
rescue REXML::ParseException => e
  puts "XML файл с желаниями повреждён"
  abort e.message
end

file.close


came_true = Hash.new
come_true = Hash.new

doc.elements.each('wishes/wish') do | item |
  wish_text = item.text.strip #strip убирает пробелы
  wish_date = Date.parse(item.attributes['deadline'])
  if wish_date < Date.today
    came_true[wish_date.strftime('%d.%m.%Y')] = wish_text
  else
    come_true[wish_date.strftime('%d.%m.%Y')] = wish_text
  end
end

puts "Эти желания должны уже были сбыться к сегодняшнему дню"
came_true.each {|k, v| puts "#{k}: #{v}"}
puts
puts "А этим желаниям ещё предстоит сбыться"
come_true.each {|k, v| puts "#{k}: #{v}"}




