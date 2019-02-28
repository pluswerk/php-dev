# TYPO3 configuration

For TYPO3 <= 7

## AdditionalConfiguration.php example

```php
if ($_SERVER['TYPO3_CONTEXT'] === 'Development/docker') {
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport'] = 'mail';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['host'] = getenv('typo3DatabaseHost') ?: 'global-db';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['port'] = getenv('typo3DatabasePort') ?: '3306';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['user'] = getenv('typo3DatabaseUsername') ?: 'root';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['password'] = getenv('typo3DatabasePassword') ?: 'root';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['database'] = getenv('typo3DatabaseName') ?: 'default_database';

//    $vmNumber = getenv('VM_NUMBER');
//    if (!\TYPO3\CMS\Core\Utility\MathUtility::canBeInterpretedAsInteger($vmNumber)) {
//        throw new \Exception('env VM_NUMBER needed! it must be an int!');
//    }
//    $GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['xyz_search']['domainA'] = sprintf('project.de.vm%d.iveins.de', $vmNumber);
//    $GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['xyz_search']['domainB'] = sprintf('cn.project.de.vm%d.iveins.de', $vmNumber);
}
```
