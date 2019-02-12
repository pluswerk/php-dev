# TYPO3 configuration

## AdditionalConfiguration.php example

```php
if ($_SERVER['TYPO3_CONTEXT'] === 'Development/docker') {
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['host'] = getenv('typo3DatabaseHost') ?: 'global-db';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['port'] = getenv('typo3DatabasePort') ?: '3306';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['user'] = getenv('typo3DatabaseUsername') ?: 'root';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['password'] = getenv('typo3DatabasePassword') ?: 'root';
    $GLOBALS['TYPO3_CONF_VARS']['DB']['Connections']['Default']['dbname'] = getenv('typo3DatabaseName') ?: 'default_database';

    
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport'] = 'smtp';
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_encrypt'] = '';
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_username'] = '';
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_password'] = '';
    $GLOBALS['TYPO3_CONF_VARS']['MAIL']['transport_smtp_server'] = getenv('SMTP_MAIL_SERVER') ?: 'global-mail:1025';
        
//    $vmNumber = getenv('VM_NUMBER');
//    if (!\TYPO3\CMS\Core\Utility\MathUtility::canBeInterpretedAsInteger($vmNumber)) {
//        throw new \Exception('env VM_NUMBER needed! it must be an int!');
//    }
//    $domainPrefix = getenv('DOMAIN_PREFIX') ?: '';
//    $GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['xyz_search']['domainA'] = sprintf('%sproject.de.vm%d.iveins.de', $domainPrefix, $vmNumber);
//    $GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['xyz_search']['domainB'] = sprintf('cn.%sproject.de.vm%d.iveins.de', $domainPrefix, $vmNumber);
}
```
