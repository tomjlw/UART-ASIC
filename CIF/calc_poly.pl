#!/usr/bin/perl

if (@ARGV[0] eq "") {
    print "\ncalc_poly.pl \<magic file\>\n\n";
    print " this script will calculate the poly density of your layout\n\n";
}

else {
    open (FILE1, @ARGV[0]) ||  die "   \nSorry. can not open file: @ARGV[0].  \n   Please recheck filename and add .mag extension is omitted\n\n";

$start = 0;
$start2 = 0;
$stop = 0;
$stop2 = 0;
$what2 = 0;
$start3 = 0; 
$stop3 = 0;
$start4 = 0;
$stop4 = 0;
$start5 = 0;
$stop5 = 0;

print "calculating total polysilicon area\.\.\.\n";

while (<FILE1>) {

    #######  Find and Start and Stop points for Calculating Poly Area

    if (($_ =~ /\<\</) && ($start == 1) && ($stop == 0)) {
#        print " stop polysilicon\n";
	$stop = 1;
    }

    if (($_ =~ /\<\</) && ($start2 == 1) && ($stop2 == 0)) {
#	print " stop rpoly\n";
	$stop2 = 1;
    }

    if (($_ =~ /\<\</) && ($start3 == 1) && ($stop3 ==0)) {
#	print " stop polycontact\n";
	$stop3 = 1;
    }

    if (($_ =~ /\<\</) && ($start4 == 1) && ($stop4 ==0)) {
#	print " stop ntransistor\n";
	$stop4 = 1;
    }

    if (($_ =~ /\<\</) && ($start5 == 1) && ($stop5 ==0)) {
#	print "stop ptransistor\n";
	$stop5 = 1;
    }

    if ($_ =~ /\<\< polysilicon/) {
#        print " start polysilicon\n";
	$start = 1;
    }

    if ($_ =~ /\<\< rpoly/) {
#        print " start rpoly\n";
	$start2 = 1;
    }

    if ($_ =~ /\<\< pseudo_rpoly/) {
#        print " start polycontact\n";
	$start3 = 1;
    }

    if ($_ =~ /\<\< ntransistor/) {
#        print " start ntransistor\n";
	$start4 = 1;
    }

    if ($_ =~ /\<\< ptransistor/) {
#        print " start ptransistor\n";
	$start5 = 1;
    }

    ######## Calculate Area for Polysilicon Rectangles 

    if (($_ =~ /rect/) && ($start == 1) && ($stop == 0)) {
	($junk, $x1, $y1, $x2, $y2) = split(/\s+/, $_);
        $width = abs($x1 - $x2);
	$height = abs($y1 - $y2);
        $area = $width*$height;
#	print "Rectangle = $width by $height, Area = $area\n";
	$totarea = $totarea + $area;
    }

    ######## Calculate Area for rpoly Rectangles 

    if (($_ =~ /rect/) && ($start2 == 1) && ($stop2 == 0)) {
	($junk, $x1, $y1, $x2, $y2) = split(/\s+/, $_);
        $width = abs($x1 - $x2);
	$height = abs($y1 - $y2);
        $area = $width*$height;
#	print "Rectangle = $width by $height, Area = $area\n";
	$totarea = $totarea + $area;
    }

    ######## Calculate Area for polycontact Rectangles 

    if (($_ =~ /rect/) && ($start3 == 1) && ($stop3 == 0)) {
	($junk, $x1, $y1, $x2, $y2) = split(/\s+/, $_);
        $width = abs($x1 - $x2);
	$height = abs($y1 - $y2);
        $area = $width*$height;
#	print "Rectangle = $width by $height, Area = $area\n";
	$totarea = $totarea + $area;
    }


    ######## Calculate Area gv1 Rectangles 

    if (($_ =~ /rect/) && ($start4 == 1) && ($stop4 == 0)) {
	($junk, $x1, $y1, $x2, $y2) = split(/\s+/, $_);
        $width = abs($x1 - $x2);
	$height = abs($y1 - $y2);
        $area = $width*$height;
#	print "Rectangle = $width by $height, Area = $area\n";
	$totarea = $totarea + $area;
    }

    ######## Calculate Area for gv2 Rectangles     

    if (($_ =~ /rect/) && ($start5 == 1) && ($stop5 == 0)) {
	($junk, $x1, $y1, $x2, $y2) = split(/\s+/, $_);
        $width = abs($x1 - $x2);
	$height = abs($y1 - $y2);
        $area = $width*$height;
#	print "Rectangle = $width by $height, Area = $area\n";
	$totarea = $totarea + $area;
    }

    ###### Calculate Local Area of the design

    if (($_ =~ /rect/) && ($what2 == 0)) {
        ($junk, $x1, $y1, $x2, $y2) = split(/\s+/, $_);
        $smallestx = $x1;
        $biggestx = $x2;
	$smallesty = $y1;
	$biggesty = $y2;
	$what2 = 1;
#        print "start $x1 $x2 $y1 $y2"
    }

    if (($_ =~ /rect/) && ($what2 == 1)) {
       	($junk, $x1, $y1, $x2, $y2) = split(/\s+/, $_);
	if ($x1 < $smallestx) {
	    $smallestx = $x1; }
	if ($x2 > $biggestx) {
	    $biggestx = $x2; }
	if ($y1 < $smallesty) {
	    $smallesty = $y1; }
	if ($y2 > $biggesty) {
	    $biggesty = $y2; }
    }

    ###### Print ERROR if the magic file is using subcells.

    if ($_ =~ /^use/) {
	print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
	print "ERROR: this script does not work on magic files with subcells\n";
	print " You need to flatten your magic file first\n";
        print " 1\) Goto MAGIC\n 2\) Load up MAGIC file \n 3\) \:flatten flatmag \n 4\) \:load flatmag \n 5\) :save flatmag\n";
	print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
        die;
    }

}
print "====================================================\n";

    ####### Print Results

print "Total PolySilicon Area = $totarea lambda squared\n";
$density = $totarea/25000000;
$percent_density = $density * 100;

#print "$biggestx $biggesty $smallestx $smallesty\n";
$local_width = abs($biggestx - $smallestx);
$local_height = abs($biggesty - $smallesty);
$local_area = $local_width * $local_height;
$local_density = $totarea/$local_area;
$percent_local = $local_density * 100;

printf ("given 5000 x 5000 area, total poly density = %2.5f percent\n", $percent_density);
printf ("Local polysilicon density = %2.5f percent \n", $percent_local);
print "====================================================\n";
}
