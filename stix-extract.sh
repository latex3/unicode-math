#!/bin/sh

cat stix-tbl.txt |
awk '
  {
	# USV characters to ignore
	
	#   (temporary, probably)
	ignoreusv["023DE"] = "\\overbrace               "
	ignoreusv["023DF"] = "\\underbrace              "
	
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
	
	ignoreusv["02070"] = "\\supzero                 "
	ignoreusv["02074"] = "\\supfour                 "
	ignoreusv["02075"] = "\\supfive                 "
	ignoreusv["02076"] = "\\supsix                  "
	ignoreusv["02077"] = "\\supseven                "
	ignoreusv["02078"] = "\\supeight                "
	ignoreusv["02079"] = "\\supnine                 "
	ignoreusv["0207D"] = "\\suplparen               "
	ignoreusv["0207E"] = "\\suprparen               "
	ignoreusv["0207F"] = "\\supn                    "
	ignoreusv["02080"] = "\\subzero                 "
	ignoreusv["02081"] = "\\subone                  "
	ignoreusv["02082"] = "\\subtwo                  "
	ignoreusv["02083"] = "\\subthree                "
	ignoreusv["02084"] = "\\subfour                 "
	ignoreusv["02085"] = "\\subfive                 "
	ignoreusv["02086"] = "\\subsix                  "
	ignoreusv["02087"] = "\\subseven                "
	ignoreusv["02088"] = "\\subeight                "
	ignoreusv["02089"] = "\\subnine                 "
	ignoreusv["0208D"] = "\\sublparen               "
	ignoreusv["0208E"] = "\\subrparen               "
	
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
		
	ignoreusv["02153"] = "\\fraconethird            "
	ignoreusv["02154"] = "\\fractwothirds           "
	ignoreusv["02155"] = "\\fraconefifth            "
	ignoreusv["02156"] = "\\fractwofifths           "
	ignoreusv["02157"] = "\\fracthreefifths         "
	ignoreusv["02158"] = "\\fracfourfifths          "
	ignoreusv["02159"] = "\\fraconesixth            "
	ignoreusv["0215A"] = "\\fracfivesixths          "
	ignoreusv["0215B"] = "\\fraconeeighth           "
	ignoreusv["0215C"] = "\\fracthreeeighths        "
	ignoreusv["0215D"] = "\\fracfiveeighths         "
	ignoreusv["0215E"] = "\\fracseveneights         "
	
	ignoreusv["02329"] = "\\clangle                 "
	ignoreusv["0232A"] = "\\crangle                 "
	
	ignoreusv["027CB"] = "\\mathoverlaylongsolidus  "
	
	ignoreusv["0300A"] = "\\lAngle                  "
	ignoreusv["0300B"] = "\\rAngle                  "
	ignoreusv["0301A"] = "\\lBrack                  "
	ignoreusv["0301B"] = "\\rBrack                  "
	ignoreusv["0301E"] = "\\cjkdprimequote          "
	
	ignoreusv["0FE35"] = "\\overparen               "
	ignoreusv["0FE36"] = "\\underparen              "
	ignoreusv["0FE37"] = "\\overbrace               "
	ignoreusv["0FE38"] = "\\underbrace              "
	ignoreusv["0FFFD"] = "\\unknown                 "
	
	ignoreusv["02460"] = "\circledone              "
	ignoreusv["02461"] = "\circledtwo              "
	ignoreusv["02462"] = "\circledthree            "
	ignoreusv["02463"] = "\circledfour             "
	ignoreusv["02464"] = "\circledfive             "
	ignoreusv["02465"] = "\circledsix              "
	ignoreusv["02466"] = "\circledseven            "
	ignoreusv["02467"] = "\circledeight            "
	ignoreusv["02468"] = "\circlednine             "
	ignoreusv["024B6"] = "\circledA                "
	ignoreusv["024B7"] = "\circledB                "
	ignoreusv["024B8"] = "\circledC                "
	ignoreusv["024B9"] = "\circledD                "
	ignoreusv["024BA"] = "\circledE                "
	ignoreusv["024BB"] = "\circledF                "
	ignoreusv["024BC"] = "\circledG                "
	ignoreusv["024BD"] = "\circledH                "
	ignoreusv["024BE"] = "\circledI                "
	ignoreusv["024BF"] = "\circledJ                "
	ignoreusv["024C0"] = "\circledK                "
	ignoreusv["024C1"] = "\circledL                "
	ignoreusv["024C2"] = "\circledM                "
	ignoreusv["024C3"] = "\circledN                "
	ignoreusv["024C4"] = "\circledO                "
	ignoreusv["024C5"] = "\circledP                "
	ignoreusv["024C6"] = "\circledQ                "
	ignoreusv["024C7"] = "\circledR                "
	ignoreusv["024C8"] = "\circledS                "
	ignoreusv["024C9"] = "\circledT                "
	ignoreusv["024CA"] = "\circledU                "
	ignoreusv["024CB"] = "\circledV                "
	ignoreusv["024CC"] = "\circledW                "
	ignoreusv["024CD"] = "\circledX                "
	ignoreusv["024CE"] = "\circledY                "
	ignoreusv["024CF"] = "\circledZ                "
	ignoreusv["024D0"] = "\circleda                "
	ignoreusv["024D1"] = "\circledb                "
	ignoreusv["024D2"] = "\circledc                "
	ignoreusv["024D3"] = "\circledd                "
	ignoreusv["024D4"] = "\circlede                "
	ignoreusv["024D5"] = "\circledf                "
	ignoreusv["024D6"] = "\circledg                "
	ignoreusv["024D7"] = "\circledh                "
	ignoreusv["024D8"] = "\circledi                "
	ignoreusv["024D9"] = "\circledj                "
	ignoreusv["024DA"] = "\circledk                "
	ignoreusv["024DB"] = "\circledl                "
	ignoreusv["024DC"] = "\circledm                "
	ignoreusv["024DD"] = "\circledn                "
	ignoreusv["024DE"] = "\circledo                "
	ignoreusv["024DF"] = "\circledp                "
	ignoreusv["024E0"] = "\circledq                "
	ignoreusv["024E1"] = "\circledr                "
	ignoreusv["024E2"] = "\circleds                "
	ignoreusv["024E3"] = "\circledt                "
	ignoreusv["024E4"] = "\circledu                "
	ignoreusv["024E5"] = "\circledv                "
	ignoreusv["024E6"] = "\circledw                "
	ignoreusv["024E7"] = "\circledx                "
	ignoreusv["024E8"] = "\circledy                "
	ignoreusv["024E9"] = "\circledz                "
	ignoreusv["024EA"] = "\circledzero             "
	
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
      type = substr($0,55,1)
      class = substr($0,57,1)
      description = tolower(substr($0,233,350))

      # THROW AWAY NON-MATH CHARS
      if ( \
	    !( usv in ignoreusv ) && \
	    texname      ~ /[\\]/ && \
        substr(texname,0,5) != "\\text"    && \
        substr(texname,0,4) != "\\ipa"    && \
        substr(texname,0,5) != "\\tone"    && \
        substr(texname,3,1) != " "    && \
        type !~ 1 && \
        description !~ /<reserved>/  && \
        description !~ /box drawings/  && \
        description !~ /crop mark/  && \
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
