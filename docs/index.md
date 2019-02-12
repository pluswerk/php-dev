# Documentation

The base Docker Images are [webdevops/php-apache-dev] and [webdevops/php-nginx-dev] respectivly. ([github])

[webdevops/php-apache-dev]: https://hub.docker.com/r/webdevops/php-apache-dev
[webdevops/php-nginx-dev]: https://hub.docker.com/r/webdevops/php-nginx-dev
[github]: https://github.com/webdevops/Dockerfile

## Outsourced topics

* [TYPO3 configuration](typo3-configuration.md)
* [ImageMagick or GraphicMagick](magick.md)

## Mail

If you use another mail server you can specify it in docker-compose.yaml file via RelayHost.

```yaml
environment:
  - POSTFIX_RELAYHOST=[global-mail]:1025
```
