# Documentation

The base Docker Images are [webdevops/php-apache-dev] and [webdevops/php-nginx-dev] respectivly. ([github])

[webdevops/php-apache-dev]: https://hub.docker.com/r/webdevops/php-apache-dev
[webdevops/php-nginx-dev]: https://hub.docker.com/r/webdevops/php-nginx-dev
[github]: https://github.com/webdevops/Dockerfile

## Other topics

* [TYPO3 configuration >=8](typo3-configuration.md)
* [TYPO3 configuration <=7](typo3-configuration-legacy.md)
* [Change docker project name](docker-project-name.md)
* [ImageMagick or GraphicMagick](magick.md)
* [XDebug](xdebug.md)

## Mail

If you use another mail server you can specify it in docker-compose.yml file via RelayHost.

```yaml
environment:
  - POSTFIX_RELAYHOST=[global-mail]:1025
```
