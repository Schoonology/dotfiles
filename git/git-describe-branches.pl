#!/usr/bin/perl

$output= `git branch`;

foreach my $line (split(/^/, $output)) {
    my ($is_current, $name) = split(/\s+/, $line);
    my $description = `git config branch.$name.description`;

    $description =~ s/\s+$//;
    printf("%1s %-22s %s\n", $is_current, $name, $description);
}
