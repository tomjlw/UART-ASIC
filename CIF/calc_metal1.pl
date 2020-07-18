#!/usr/bin/perl

if (@ARGV[0] eq "") {
    print "\ncalc_metal1.pl \<magic file\>\n\n";
    print " this script will calculate the metal1 density of your layout\n\n";
}

else {
    open (FILE1, @ARGV[0]) ||  die "   \nSorry. can not open file: @ARGV[0].  \n
   Please recheck filename and add .mag extension is omitted\n\n";


$start = 0;
$stop = 0;

print "calculating total metal1 area\.\.\.\n";

while (<FILE1>) {
    if (($_ =~ /\<\</) && ($start == 1)) {
	$stop = 1;
    }

    if ($_ =~ /\<\< metal1/) {
	$start = 1;
    }

    if (($_ =~ /rect/) && ($start == 1) && ($stop == 0)) {
	($junk, $x1, $y1, $x2, $y2) = split(/\s+/, $_);
        $width = abs($x1 - $x2);
	$height = abs($y1 - $y2);
        $area = $width*$height;
#	print "Rectangle = $width by $height, Area = $area\n";
	$totarea = $totarea + $area;
    }

    ###### Print ERROR if the magic file is using subcells.

    if ($_ =~ /^use/) {
        print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
        print "ERROR: this script does not work on magic files with subcells\n";
        print " You need to flatten your magic file first\n";
        print " 1\) Goto MAGIC\n 2\) Load up MAGIC file \n 3\) \:flatten flatmag \n 4\) \:load flatmag \n 5\) :save flatmag\n";
        print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
        die;
    }


}

print "====================================================\n";
print "Total Metal1 Area = $totarea lambda squared\n";
$density = $totarea/25000000;
$percent_density = $density * 100;


printf ("given 5000 x 5000 area, total metal1 density = %2.5f percent\n", $percent_density);

print "====================================================\n";

}
