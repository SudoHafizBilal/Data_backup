array set person {
    name Bilal
    city Multan
    age  23
}

foreach key [array names person] {
    puts "$key : $person($key)"
}