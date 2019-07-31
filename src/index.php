<?php

$counter = 2;
for ($i = 0; $i < 1000; $i++) {
    echo $i;
    if ($i % 2) {
        $counter *= 2;
    }
    echo 'now sleeping for ' . $counter . ' microseconds';
    usleep((int)$counter);
}

