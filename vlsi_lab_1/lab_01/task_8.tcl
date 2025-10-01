set numlist {5 10 15 20}
puts "Number list is: $numlist"

set new_numlist {}

foreach num $numlist {
    lappend new_numlist [expr {$num / 5}] 
}

puts "New Number list is: $new_numlist"