# TYPO3 configuration

For TYPO3 >= 8

## AdditionalConfiguration.php example

```php
if ($_SERVER['TYPO3_CONTEXT'] === 'Development/docker') {
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport'] = 'mail';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['host'] = getenv('typo3DatabaseHost') ?: 'global-db';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['port'] = getenv('typo3DatabasePort') ?: '3306';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['user'] = getenv('typo3DatabaseUsername') ?: 'root';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['password'] = getenv('typo3DatabasePassword') ?: 'root';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['dbname'] = getenv('typo3DatabaseName') ?: 'default_database';

    $GLOBALS['TYPO3_CONF_VARS']['SYS']['trustedHostsPattern'] = '.*';
    $_SERVER['HTTPS'] = $_SERVER['HTTP_X_FORWARDED_SSL'] ? $_SERVER['HTTP_X_FORWARDED_SSL'] : ($_SERVER['HTTPS'] ? $_SERVER['HTTPS'] : 'off');

//    $vmNumber = getenv('VM_NUMBER');
//    if (!preg_match('/\d+/', $vmNumber)) {
//        throw new \Exception('env VM_NUMBER needed! it must be an int!');
//    }
//    $GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['xyz_search']['domainA'] = sprintf('project.de.vm%d.iveins.de', $vmNumber);
//    $GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['xyz_search']['domainB'] = sprintf('cn.project.de.vm%d.iveins.de', $vmNumber);
}
```
