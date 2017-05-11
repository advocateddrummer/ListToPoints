package require PWI_Glyph

set targetLayer -42

############################################################################
# Find an empty layer
############################################################################
proc FindEmptyLayer {{start 0}} {
  # The 'start' parameter is the layer to start searching from; the '{start 0}'
  # syntax means that the default layer is 0 if one is not specified.

  set found "false"
  set maxLayer [pw::Layer getCount]

  for {set layer $start} {$layer <= $maxLayer} {incr layer} {
    set sum 0
    set nEntities [pw::Layer getLayerEntityCounts $layer]
    foreach i $nEntities {
      incr sum $i
    }
    if {$sum == 0} {
      set found "true"
      break
    }
  }

  # Return the first empty layer found, unless non were found.
  return [expr $found == "true" ? $layer : -42]
}

set pointList {
   0.0 0.0 0.0
   1.0 0.0 0.0
   0.5 0.8660254 0.0
}

# Save original layer.
set originalLayer [pw::Display getCurrentLayer]
puts "current layer is $originalLayer"

# Find and switch to empty layer to save points into if user hasn't specified a
# target layer.
if { $targetLayer <= 0} {
  set emptyLayer [FindEmptyLayer $originalLayer]
  puts "switching to empty layer $emptyLayer; all points created by this script will be there"
  pw::Display setCurrentLayer $emptyLayer
  pw::Layer setDescription $emptyLayer "Points added by ListToPoints.glf"
} else {
  puts "switching to target layer $targetLayer; all points created by this script will be there"
  pw::Display setCurrentLayer $targetLayer
}

foreach {x y z} $pointList {
  puts "Creating point: $x $y $z"
  set point [pw::Point create]
  $point setPoint [list $x $y $z]
}


puts "returning to original layer $originalLayer"
pw::Display setCurrentLayer $originalLayer
