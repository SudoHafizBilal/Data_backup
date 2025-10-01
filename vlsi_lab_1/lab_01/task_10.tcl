set fp [open "data.txt" "r"]
set count 0

while {[gets $fp line] >= 0} {
    incr count
}
close $fp

puts "Number of lines: $count"