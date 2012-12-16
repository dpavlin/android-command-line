#!/usr/bin/perl
use warnings;
use strict;

use Getopt::Long;

my $mode = lc($ARGV[0]) || die "usage: $0 (backup|restore|update)\n";

my $cmdline = <DATA>;
my $rkflashtool = '/virtual/android/android-command-line/rkflashtool/rkflashtool';

die "rkflashtool not found: $!" unless -x $rkflashtool;

$cmdline =~ s/^.*mtdparts=\w+:([^\s]+)\s.*$/$1/;
warn $cmdline;

foreach ( split(/,/,$cmdline) ) {
	print "$_\n";
	my ($size,$start,$name) = split(/[\@\(\)]/, $_, 4);

	my $cmd;

	my $backup_file = "$start-$size-$name";

	if ( $mode eq 'backup' ) {

		$cmd = "$rkflashtool r $start $size > $backup_file";

	} elsif ( $mode eq 'restore' ) {

		if ( -e $backup_file && -s $backup_file ) {
			$cmd = "$rkflashtool w $start $size < $backup_file";
		} else {
			warn "SKIP $backup_file restore: $!\n";
			next;
		}

	} elsif ( $mode eq 'update' ) {

		if ( -e "$name.img" ) {
			$cmd = "$rkflashtool w $start $size < $name.img";
		} else {
			warn "SKIP $start $size $name - not found in update\n";
			next;
		}
	}

	warn "# $cmd\n";
	system($cmd) == 0 || die $!;
}

if ( $mode eq 'update' || $mode eq 'restore' ) {
	warn "# reboot Android\n";
	system("$rkflashtool b");
}

__DATA__
console=ttyFIQ0 androidboot.console=ttyFIQ0 init=/init initrd=0x62000000,0x00200000 mtdparts=rk29xxnand:0x00002000@0x00002000(misc),0x00004000@0x00004000(kernel),0x00008000@0x00008000(boot),0x00008000@0x00010000(recovery),0x000C0000@0x00018000(backup),0x00040000@0x000D8000(cache),0x00300000@0x00118000(userdata),0x00002000@0x00418000(kpanic),0x00100000@0x0041A000(system),-@0x0053A000(user) bootver=2012-08-08#1.14 firmware_ver=4.0.4
