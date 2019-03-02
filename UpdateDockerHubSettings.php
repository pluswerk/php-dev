<?php
declare(strict_types=1);

namespace Pluswerk;

final class UpdateDockerHubSettings
{
    public function __construct()
    {
        $buildSettings = $this->generateBuildSettings();

        $options = [
            CURLOPT_URL => 'https://cloud.docker.com/api/build/v1/pluswerk/source/b8d191f9-8896-4934-9361-be2f9ac8ef7a/',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_FAILONERROR => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 10,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'PATCH',
            CURLOPT_POSTFIELDS => json_encode(['build_settings' => $buildSettings]),
            CURLOPT_USERPWD => $this->getUserPwd(),
            CURLOPT_HTTPHEADER => [
                'Content-Type: application/json',
                'cache-control: no-cache',
            ],
        ];
        $result = $this->curlExec($options);

        echo $result . "\n" . 'DONE' . "\n";
    }

    private function generateBuildSettings(): array
    {
        $buildSettings = [];
        foreach (['apache', 'nginx'] as $webServer) {
            foreach (['5.6', '7.0', '7.1', '7.2', '7.3'] as $phpVersions) {
                $buildSettings[] = [
                    'source_type' => 'Branch',
                    'tag' => $webServer . '-' . $phpVersions,
                    'dockerfile' => 'Dockerfile',
                    'source_name' => 'master',
                    'build_context' => '/',
                    'autobuild' => true,
                    'nocache' => false,
                ];
            }
        }
        return $buildSettings;
    }

    private function getUserPwd(): string
    {
        if (file_exists('.env')) {
            $lines = explode("\n", file_get_contents('.env'));
            foreach ($lines as $line) {
                $line && putenv($line);
            }
        }
        $user = getenv('USER');
        $password = getenv('PASSWORD');
        if (!$user || !$password) {
            throw new \InvalidArgumentException('set env variables USER and PASSWORD');
        }
        return $user . ':' . $password;
    }

    /**
     * @param array $options
     * @return bool|string
     */
    protected function curlExec(array $options)
    {
        try {
            $curl = curl_init();
            curl_setopt_array($curl, $options);
            $result = curl_exec($curl);
            if (curl_errno($curl)) {
                throw new \RuntimeException(curl_error($curl));
            }
        } finally {
            @curl_close($curl);
        }
        return $result;
    }
}

new UpdateDockerHubSettings();
