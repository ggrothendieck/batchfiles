# Perl script to reduce clutter in S4 html files and in S3 files
# with many repetitive functions.
# For an example of generated output, see
# http://www.menne-biomed.de/download/toggleDoc/00Index.html
# Put this script and the javascript file toggleDoc.js
# into the Rxxx/library directory (you should also find the R.css file there).
# When you run this script, new files 00IndexNew.html will be generated in
# each directory.
# ***** Warning: this script has been tested under Windows only.
# Please report required changes for Linux to
# dieter.menne@menne-biomed.de

use File::Find;
use strict;
use warnings;

sub process00Index {
  my $infile = "00Index.html";
  my $outfile = "00IndexNew.html";

  open(HTML,"<$infile") or die "Could not open $infile";
  open(OUT,">$outfile");
  my $dosave = 1;
  my $printall = 0;

  my $head = <<END;
<script type="text/javascript" src="../../toggleDoc.js"></script>
</head><body onLoad="javascript:toggleDoc();">
END

  my $check = <<END;
<div id="togglecheck" >
<input id="togglecheckid" type="checkbox" alt="Showit"
  onClick="javascript:toggleDoc();" value="" >Show all
</div>
END

  while(<HTML>){
    if ($printall){
      print OUT;
    }
    elsif (m&<h2>&) {
      print OUT $check;
      print OUT;
      print ;
      $printall = 1;
    }
    elsif (m&toggleDoc&)
    {
      $dosave = 0;
      last;
    }
    elsif (m&</head><body>&) {
      print OUT $head
    }
    else {
      print OUT;
    }
  }
  close(OUT);
  close(HTML);
  if (!$dosave) {
    unlink $outfile;
  }
  else
  {
    rename $infile,"00IndexOld.html";
    rename $outfile,$infile;
  }
}

sub procfiles {
  process00Index  if (/00Index.html/);
}

find( \&procfiles,".");


