#!/bin/csh
#
foreach i ($argv)
  echo $i |awk '{printf "%s ",$1}' >>t1
  grep energies $i | sed s/\,/\ /g | awk '{printf "%f %f\n",$8,$9}' >>t1
  grep Desol $i | sed s/\,/\ /g | awk '{print $4}' >>t2
  grep Symm $i | sed s/\,/\ /g | awk '{print $4}' >>t3
  grep "water - chain1" $i | awk '{print $6}' >>t4
  grep "water - chain2" $i | awk '{print $6}' >>t5
  grep "water - water" $i | awk '{print $6}' >>t6
  grep "water - chain1" $i | awk '{print $7}' >>t7
  grep "water - chain2" $i | awk '{print $7}' >>t8
  grep "water - water" $i | awk '{print $7}' >>t9
end
paste t1 t2 t3 t4 t5 t6 t7 t8 t9 | awk '{printf "%s%s %f%s\n", $1," { ",($2+$6+$7+$8+0.2*($3+$9+$10+$11)+$4+0.1*$5)," }"}' |sort -n -k3 >file.list
awk '{print $1}' file.list >file.nam
\rm t1 t2 t3 t4 t5 t6 t7 t8 t9
