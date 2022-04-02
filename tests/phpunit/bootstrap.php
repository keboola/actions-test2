<?php

declare(strict_types=1);

var_dump('Variable');
var_dump(strrev((string) getenv('TEST_VAR')));
var_dump('End');

require __DIR__ . '/../../vendor/autoload.php';
