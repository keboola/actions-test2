<?php

declare(strict_types=1);

namespace MyComponent;

use Keboola\Component\Config\BaseConfig;

class Config extends BaseConfig
{
    public function getFoo(): string
    {
        return $this->getStringValue(['parameters', 'foo']);
    }
}
