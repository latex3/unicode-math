#!/bin/sh

cat stix-tbl.txt |
awk '
  {
	# USV characters to ignore
	
	#
	ignoreusv["000C5"] = "\\AA                      "
	ignoreusv["000C6"] = "\\AE                      "
	ignoreusv["000D0"] = "\\DH                      "
	ignoreusv["000DE"] = "\\TH                      "
	ignoreusv["000DF"] = "\\ss                      "
	ignoreusv["000E5"] = "\\aa                      "
	ignoreusv["000E6"] = "\\ae                      "
	ignoreusv["000F0"] = "\\dh                      "
	ignoreusv["000FE"] = "\\th                      "
	ignoreusv["00110"] = "\\DJ                      "
	ignoreusv["00111"] = "\\dj                      "
	ignoreusv["00131"] = "\\imath                   "
	ignoreusv["0014A"] = "\\NG                      "
	ignoreusv["0014B"] = "\\ng                      "
	ignoreusv["00152"] = "\\OE                      "
	ignoreusv["00153"] = "\\oe                      "
	
	ignoreusv["0019B"] = "\\lambdaslash             "
	ignoreusv["001A0"] = "\\Ohorn                   "
	ignoreusv["001A1"] = "\\ohorn                   "
	ignoreusv["001AF"] = "\\Uhorn                   "
	ignoreusv["001B0"] = "\\uhorn                   "
	
	ignoreusv["002B9"] = "\\cprime                  "
	ignoreusv["002BA"] = "\\cdprime                 "
	ignoreusv["002BC"] = "\\rasp                    "
	ignoreusv["002BD"] = "\\lasp                    "
		
	ignoreusv["02002"] = "\\enspace                 "
	ignoreusv["02003"] = "\\quad                    "
	ignoreusv["02004"] = "\\thirdemspace            "
	ignoreusv["02005"] = "\\thickspace              "
	ignoreusv["02006"] = "\\sixthemspace            "
	ignoreusv["02007"] = "\\digitspace              "
	ignoreusv["02008"] = "\\punctspace              "
	ignoreusv["02009"] = "\\thinspace               "
	ignoreusv["0200A"] = "\\hspace                  "
	ignoreusv["0200B"] = "\\zwspace                 "
	ignoreusv["0200C"] = "\\zwnonjoin               "
	ignoreusv["0200D"] = "\\zwjoin                  "
	ignoreusv["0200E"] = "\\LtoRmark                "
	ignoreusv["0200F"] = "\\RtoLmark                "
	ignoreusv["02011"] = "\\nobreakhyphen           "
	ignoreusv["02012"] = "\\figdash                 "
	ignoreusv["02013"] = "\\endash                  "
	ignoreusv["02014"] = "\\emdash                  "
	
	ignoreusv["0205F"] = "\\medmathspace            "
	ignoreusv["02060"] = "\\wordjoin                "
	ignoreusv["02061"] = "\\functionapply           "
	ignoreusv["02062"] = "\\invisibletimes          "
	ignoreusv["02063"] = "\\invisiblesep            "
	ignoreusv["02064"] = "\\invisibleplus           "
		
	ignoreusv["02329"] = "\\clangle                 "
	ignoreusv["0232A"] = "\\crangle                 "

	ignoreusv["024C8"] = "\\circledS                "
	
	ignoreusv["027CB"] = "\\mathoverlaylongsolidus  "
	
	ignoreusv["0300A"] = "\\lAngle                  "
	ignoreusv["0300B"] = "\\rAngle                  "
	ignoreusv["0301A"] = "\\lBrack                  "
	ignoreusv["0301B"] = "\\rBrack                  "
	ignoreusv["0301E"] = "\\cjkdprimequote          "
	
	ignoreusv["0FFFD"] = "\\unknown                 "
		
	ignoreusv["0FE35"] = "\\overparen               "
	ignoreusv["0FE36"] = "\\underparen              "
	ignoreusv["0FE37"] = "\\overbrace               "
	ignoreusv["0FE38"] = "\\underbrace              "

	ignoreusv["0203E"] = "\\overline                " # primitive in luatex
		
	# READ LINE
	if (  \
      printusv != substr($0,2,5) &&  \
      printtexname != substr($0,84,25) &&  \
      substr($0,2,1) != " " \
    )
    {
	  # GRAB INFO
	  flag = substr($0,1,1)
	  usv = substr($0,2,5)
      texname = substr($0,84,25)
      type = substr($0,55,1)
      class = substr($0,57,1)
      description = tolower(substr($0,233,350))

      # THROW AWAY NON-MATH CHARS
      if ( \
	    !( usv in ignoreusv ) && \
	    flag !~ "%" && \
	    texname      ~ /[\\]/ && \
        substr(texname,0,5) != "\\text"    && \
        substr(texname,0,4) != "\\ipa"    && \
        substr(texname,0,5) != "\\tone"    && \
        substr(texname,3,1) != " "    && \
        type !~ 1 && \
        description !~ /<reserved>/  && \
        description !~ /box drawings/  && \
        description !~ /crop mark/  && \
        description !~ /circled digit/  && \
        description !~ /circled latin/  && \
        description !~ /dingbat circled/  && \
        description !~ /dingbat negative circled/  && \
        description !~ /quot/  \
      )
      {
		# SAVE DATA FOR NEXT LINE READS
        printusv = usv;
        printtexname = texname;

		# FIXES
		if (texname == "\\bigtriangleup           ") { class = "B" }
		if (texname == "\\Vvert                   ") { class = "F" }
		if (usv == "02995") { class = "O" }
		if (usv == "02996") { class = "C" }
		if (usv == "02982") { class = "B" }
		if (usv == "022EF") { class = "N" }
		if (usv == "0219C")                          { printtexname = "\\leftwavearrow           " }
		if (usv == "0219D")                          { printtexname = "\\rightwavearrow          " }
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
		if (texname == "\\slash                   ") { printtexname = "\\divslash                " }
		if (texname == "\\colon                   ") { printtexname = "\\mathratio               " }
		if (texname == "\\dots                    ") { printtexname = "\\unicodeellipsis         " }
		if (texname == "\\cdots                   ") { printtexname = "\\unicodecdots            " }
			
		if (texname == "\\#                       ") { printtexname = "\\mathoctothorpe          " }
		if (texname == "\\%                       ") { printtexname = "\\mathpercent             " }
		if (texname == "\\&                       ") { printtexname = "\\mathampersand           " }

        # Corrections
		if (usv == "025B5") { class = "\\mathrel" }

		# OVER/UNDER brackets/parens/braces (resp.)
		if (usv == "023B4") { class = "\\mathover" }
		if (usv == "023DC") { class = "\\mathover" }
		if (usv == "023DE") { class = "\\mathover" }
		if (usv == "023B5") { class = "\\mathunder" }
		if (usv == "023DD") { class = "\\mathunder" }
		if (usv == "023DF") { class = "\\mathunder" }

		if (usv == "0203E") { class = "\\mathover" } # overline

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
