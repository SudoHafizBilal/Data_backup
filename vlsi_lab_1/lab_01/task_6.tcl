set num_list {1 2 3 4 5}


foreach num $num_list {
    set square [expr {$num * $num}]
    puts "Square of $num is: $square"
}


