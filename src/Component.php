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
        $this->getLogger()->info('Token: ' . substr((string) getenv('KBC_TOKEN'), 0, 10));
        $this->getLogger()->info('ConfigRow: ' . getenv('KBC_CONFIGROWID'));
        $this->getLogger()->info('BranchId: ' . getenv('KBC_BRANCHID'));
        $this->getLogger()->info('RealUser: ' . getenv('KBC_REALUSER'));
        $this->getLogger()->info('StagingFileProvider: ' . getenv('KBC_STAGING_FILE_PROVIDER'));
        file_put_contents($this->getDataDir() . '/out/files/my-file', 'Fantômas');
        $this->getLogger()->info(file_get_contents($this->getDataDir() . 'config.json'));
        $m = new OutFileManifestOptions();
        $m->setTags(['Fantômas', 'was-here']);
        $mm = new ManifestManager($this->getDataDir());
        $mm->writeFileManifest('my-file', $m);
    }

    public function getSyncActions(): array
    {
        return ['first' => 'firstAction', 'second' => 'secondAction'];
    }

    public function firstAction(): array
    {
        return $this->getConfig()->getParameters();
    }

    public function secondAction(): array
    {
        return ['boo' => 'bar'];
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
