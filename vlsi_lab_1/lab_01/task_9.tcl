set fp [open "data.txt" "w"]

puts $fp "Line1"
puts $fp "Line2"
puts $fp "Line3"

close $fp

puts "Data has been written to data.txt"