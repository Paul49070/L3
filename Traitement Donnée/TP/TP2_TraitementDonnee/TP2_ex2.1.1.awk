NF > 0 {
    print toupper(substr($1,0,1)) substr($1,2) " " toupper($2)
}

BEGIN {
    FS=" "
}