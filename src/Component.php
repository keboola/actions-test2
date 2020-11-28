<?php

declare(strict_types=1);

namespace MyComponent;

use Keboola\Component\BaseComponent;

class Component extends BaseComponent
{
    protected function run(): void
    {
        $this->getLogger()->info('Fantômas');
        $this->getLogger()->info('Token: ' . substr(getenv('KBC_TOKEN'), 0, 10));
        $this->getLogger()->info('ConfigRow: ' . getenv('KBC_CONFIGROWID'));
        // @TODO implement
    }

    protected function getConfigClass(): string
    {
        return Config::class;
    }

    protected function getConfigDefinitionClass(): string
    {
        return ConfigDefinition::class;
    }
}
