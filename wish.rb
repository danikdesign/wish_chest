Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'rexml/document'
require 'date'

puts "В этом сундуке хранятся ваши желания."
puts "Чего бы вы хотели?"

wish_point = STDIN.gets.chomp

puts "До какого числа вы хотите осуществить это желание?\n(укажите дату в формате ДД.ММ.ГГГГ)"

date_input = STDIN.gets.chomp
deadline = Date.parse(date_input)

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

wishes = doc.elements.find('wishes').first

wish = wishes.add_element 'wish', {
  'deadline' => deadline.strftime('%Y.%m.%d')
}

wish.text = wish_point

file = File.new(file_name, "w:UTF-8")
doc.write(file, 2)
puts "Ваше желание в сундуке"







