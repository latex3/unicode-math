#!/bin/sh

cat stix-tbl.txt |
awk '
  {
	# USV characters to ignore
	ignoreusv["000C5"] = "\\AA"
	ignoreusv["000C6"] = "\\AE"
	ignoreusv["000D0"] = "\\DH"
	ignoreusv["000DE"] = "\\TH"
	ignoreusv["000DF"] = "\\ss"
	ignoreusv["000E5"] = "\\aa"
	ignoreusv["000E6"] = "\\ae"
	ignoreusv["000F0"] = "\\dh"
	
	ignoreusv["000FE"] = "\\th   "
	ignoreusv["00110"] = "\\DJ   "
	ignoreusv["00111"] = "\\dj   "
	ignoreusv["00131"] = "\\imath"
	ignoreusv["0014A"] = "\\NG   "
	ignoreusv["0014B"] = "\\ng   "
	ignoreusv["00152"] = "\\OE   "
	ignoreusv["00153"] = "\\oe   "
	
	ignoreusv["0019B"] = "\\lambdaslash "
	ignoreusv["001A0"] = "\\Ohorn       "
	ignoreusv["001A1"] = "\\ohorn       "
	ignoreusv["001AF"] = "\\Uhorn       "
	ignoreusv["001B0"] = "\\uhorn       "
	
	# READ LINE
	if (  \
      printusv != substr($0,2,5) &&  \
      printtexname != substr($0,84,25) &&  \
      substr($0,2,1) != " " \
    )
    {
	  # GRAB INFO
	  usv = substr($0,2,5)
      texname = substr($0,84,25)
      class = substr($0,57,1)
      description = tolower(substr($0,233,350))

      # IGNORE DUDS
      if ( \
	    !( usv in ignoreusv ) && \
	    texname      ~ /[\\]/ && \
        substr(texname,0,5) != "\\text"    && \
        substr(texname,0,4) != "\\ipa"    && \
        substr(texname,0,5) != "\\tone"    && \
        substr(texname,3,1) != " "    && \
        description !~ /<reserved>/  \
      )
      {
		# SAVE DATA FOR NEXT LINE READS
        printusv = usv;
        printtexname = texname;

		# FIXES
		if (texname == "\\bigtriangleup           ") { class = "B" }
		if (texname == "\\upvarepsilon            ") { printtexname = "\\upepsilon               " }
		if (texname == "\\upepsilon               ") { printtexname = "\\upvarepsilon            " }
		if (texname == "\\mbfvarepsilon           ") { printtexname = "\\mbfepsilon              " }
		if (texname == "\\mbfepsilon              ") { printtexname = "\\mbfvarepsilon           " }
		if (texname == "\\mitvarepsilon           ") { printtexname = "\\mitepsilon              " }
		if (texname == "\\mitepsilon              ") { printtexname = "\\mitvarepsilon           " }
		if (texname == "\\mbfitvarepsilon         ") { printtexname = "\\mbfitepsilon            " }
		if (texname == "\\mbfitepsilon            ") { printtexname = "\\mbfitvarepsilon         " }
		if (texname == "\\mbfsansvarepsilon       ") { printtexname = "\\mbfsansepsilon          " }
		if (texname == "\\mbfsansepsilon          ") { printtexname = "\\mbfsansvarepsilon       " }
		if (texname == "\\mbfitsansvarepsilon     ") { printtexname = "\\mbfitsansepsilon        " }
		if (texname == "\\mbfitsansepsilon        ") { printtexname = "\\mbfitsansvarepsilon     " }
		if (texname == "\\colon                   ") { printtexname = "\\mathratio               " }
		if (texname == "\\cdots                   ") { printtexname = "\\unicodecdots            " }


	    # TRANSFORM MATH CLASSES
	    if (class == "N") { class = "\\mathord" }
	    if (class == " ") { class = "\\mathord" }
	    if (class == "F") { class = "\\mathfence" }
	    if (class == "A") { class = "\\mathalpha" }
	    if (class == "D") { class = "\\mathaccent" }
	    if (class == "P") { class = "\\mathpunct" }
	    if (class == "B") { class = "\\mathbin" }
	    if (class == "R") { class = "\\mathrel" }
	    if (class == "L") { class = "\\mathop" }
	    if (class == "O") { class = "\\mathopen" }
	    if (class == "C") { class = "\\mathclose" }
				

		# PRINT
		sub(/\^/, "\\string^", description)
		sub(/\%/, "\\\%", description)
        print "\\UnicodeMathSymbol{\"" \
              usv "}{" \
              printtexname "}{" \
              class "}{" \
              description "}%"
      }
    }
  }' > umtable.tex
