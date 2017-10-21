## UPDATE-COPYRIGHT.SH
#
# Updates copyright statements between lines surrounded by:
#    % /©
#.   ...
#.   % ©/
# with the text in the file COPYRIGHT
#
# Updates the first line of the file to match the filename

for ii in *.tex *.ltx *.dtx ; do

echo $ii

awk 'FNR==NR{ _[++d]=$0;next}
/^% \/©$/{
  print
  for(i=1;i<=d;i++){ print _[i] }
  f=1;next
}
/^% ©\/$/{f=0}!f' COPYRIGHT $ii > tmpfile

mv tmpfile $ii

sed -i'.tmp' "1s/.*/%%^^J%%  $ii  -  part of UNICODE-MATH \<github.com\/wspr\/unicode-math\>/" $ii

rm $ii.tmp

done

