#! /usr/bin/perl
# Script to show battery status for i3blocks. Calculates total battery
# percentage from both laptop batteries and adds nice colors and icons.

my $battery_now = 0;
my $battery_full = 0;
for my $i (0..1) {
    $battery_now += `cat /sys/class/power_supply/BAT$i/uevent | grep -Po 'POWER_SUPPLY_ENERGY_NOW=\\K\\d+'`;
    $battery_full += `cat /sys/class/power_supply/BAT$i/uevent | grep -Po 'POWER_SUPPLY_ENERGY_FULL=\\K\\d+'`;
}

my $battery_level_percent = int(100 * $battery_now / $battery_full);

my $text = "$battery_level_percent%";
my $label;
my $color;
my $charging = (`acpi` =~ 'Charging');

if ($charging) {
    $label = '';
    $color =  '#00FF00';
} else {
	if ($battery_level_percent < 20) {
        $label = '';
		$color = "#FF0000";
	} elsif ($battery_level_percent < 40) {
        $label = '';
		$color = "#FFAE00";
	} elsif ($battery_level_percent < 60) {
        $label = '';
		$color = "#FFF600";
	} elsif ($battery_level_percent < 80) {
        $label = '';
	} else {
        $label = '';
	}
}

my $full_text = "$label $text";

if ($battery_level_percent < 10 and not $charging) {
    print " $full_text \n";
    print " $full_text \n";
	exit(33); # Displays urgent colors
} else {
    print "$full_text\n";
    print "$full_text\n";
    print "$color\n";
    exit(0);
}
