## UPDATE-COPYRIGHT.SH
#
# Updates copyright statements between lines surrounded by:
#    % /©
#.   ...
#.   % ©/
# with the text in the file COPYRIGHT

for ii in *.tex *.ltx *.dtx; do

echo $ii ;

awk 'FNR==NR{ _[++d]=$0;next}
/^% \/©$/{
  print
  for(i=1;i<=d;i++){ print _[i] }
  f=1;next
}
/^% ©\/$/{f=0}!f' COPYRIGHT $ii > tmpfile

mv tmpfile $ii

done

