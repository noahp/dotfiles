#!/usr/bin/env sh

# From:
# https://gist.github.com/bessarabov/674ea13c77fc8128f24b5e3f53b7f094

git log --author="$1" --date=iso | \
  perl -nalE 'if (/^Date:\s+[\d-]{10}\s(\d{2})/) { say $1+0 }' | \
  sort | uniq -c | perl -MList::Util=max -nalE '$h{$F[1]} = $F[0]; }{ $m = max values %h; foreach (0..23) { $h{$_} = 0 if not exists $h{$_} } foreach (sort {$a <=> $b } keys %h) { say sprintf "%02d - %4d %s", $_, $h{$_}, "*"x ($h{$_} / $m * 50); }'
