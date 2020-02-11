# Code Coverage

If you want code coverage in your Tests, you can use one of `pcov`(recommended) or  `xdebug`

## pcov

To enable `pcov` put `php -dpcov.enabled=1 ` before your script:
e.g: `php -dpcov.enabled=1 vendor/bin/phpunit`

!!! to use pcov with phpunit <=7.0 you need [pcov/clobber](https://github.com/krakjoe/pcov-clobber)

## xdebug

To enable `xdebug` got to the Documentation about [xdebug.md](xdebug.md).
