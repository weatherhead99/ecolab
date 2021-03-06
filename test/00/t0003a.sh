#! /bin/sh
#  @copyright Russell Standish 2000-2013
#  @author Russell Standish
#  This file is part of Classdesc
#
#  Open source licensed under the MIT license. See LICENSE for details.


here=`pwd`
if test $? -ne 0; then exit 2; fi
tmp=/tmp/$$
mkdir $tmp
if test $? -ne 0; then exit 2; fi
cd $tmp
if test $? -ne 0; then exit 2; fi

fail()
{
    echo "FAILED" 1>&2
    cd $here
    chmod -R u+w $tmp
    rm -rf $tmp
    exit 1
}

pass()
{
    echo "PASSED" 1>&2
    cd $here
    chmod -R u+w $tmp
    rm -rf $tmp
    exit 0
}

trap "fail" 1 2 3 15
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# insert ecolab script code here
# use \$ in place of $ to refer to variable contents
cat >input.tcl <<EOF
array_urand.seed 10
ecolab.species {1 2}
ecolab.density {100 100} 
ecolab.create {0 0}
ecolab.repro_rate {.1 -.1}
ecolab.interaction.diag {-.0001 -1e-5}
ecolab.interaction.val {-0.001 0.001}
ecolab.interaction.row {0 1}
ecolab.interaction.col {1 0}
ecolab.mutation {.01 .01}
ecolab.sp_sep .1
ecolab.repro_min -.1
ecolab.repro_max .1
ecolab.odiag_min -1e-3
ecolab.odiag_max 1e-3
ecolab.mut_max .01

set output [open "out.dat" "w"]
for {set j 0} {\$j<10} {incr j} {
    for {set i 0} {\$i<100} {incr i} {
	    ecolab.generate
	}
	ecolab.condense
        puts \$output [ecolab.density]
    }
close \$output
EOF

$here/models/ecolab input.tcl
if test $? -ne 0; then fail; fi

# for parallel
#cat >out1.dat <<EOF
#102 85
#99 87
#105 93
#97 89
#98 99
#102 79
#97 101
#110 82
#98 87
#103 91
#EOF
# for gigaboot
cat >out1.dat <<EOF
106 79
90 99
112 82
90 96
103 84
100 101
97 82
98 108
100 70
93 106
EOF

if diff out.dat out1.dat; then 
pass
else
fail
fi;

pass
