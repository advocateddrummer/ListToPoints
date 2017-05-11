package require PWI_Glyph

set pointList {
   0.0 0.0 0.0
   1.0 0.0 0.0
   0.5 0.8660254 0.0
}


foreach {x y z} $pointList {
  puts "Creating point: $x $y $z"
  set point [pw::Point create]
  $point setPoint [list $x $y $z]
}
