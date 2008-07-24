#!/usr/bin/perl
# basic correctness and performance checks. Essentially we
# have a list of invocations and check the md5 of their 
# output and running time against a previously-saved run.

$prefix="./logrep -c wtop.cfg";
$suffix="small.log | md5 -q";
@tests = (
    "-o 'url,msec,bot'",
    "-o 'url,msec,ts'",
    "-o 'url,msec,class'",
    "-o 'url,msec,bot,ts,class'",
    "-f 'url!~/q/,msec>500' -o 'url,msec,bot,ts,class'",
    "-f 'url!~/q/,msec<500' -o 'url,msec,bot,ts,class,bytes'",
    "-f 'url!~/q/,msec<500,bot=1' -o 'url,msec,bot,ts,class,bytes'"
);

#"""time ./logrep --config wtop.cfg --output='status,count(*),dev(bytes),avg(bytes),min(bytes),max(bytes)' --x-tmp-dir='/tmp' -s '10:3:a' -q access.log """


foreach $test(@tests) {
    $cmd = "$prefix $test $suffix";
    print "$cmd\n";
    print `$cmd`;
    print "\n";
}
