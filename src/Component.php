<?php

declare(strict_types=1);

namespace MyComponent;

use Keboola\Component\BaseComponent;
use Keboola\Component\Manifest\ManifestManager;
use Keboola\Component\Manifest\ManifestManager\Options\OutFileManifestOptions;

class Component extends BaseComponent
{
    protected function run(): void
    {
        $this->getLogger()->info('Fantômas');
        $this->getLogger()->info('Token: ' . substr(getenv('KBC_TOKEN'), 0, 10));
        $this->getLogger()->info('ConfigRow: ' . getenv('KBC_CONFIGROWID'));
        file_put_contents($this->getDataDir() . '/out/files/my-file', 'Fantômas');
        $m = new OutFileManifestOptions();
        $m->setTags(['Fantômas', 'was-here']);
        $mm = new ManifestManager($this->getDataDir());
        $mm->writeFileManifest('my-file', $m);
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
