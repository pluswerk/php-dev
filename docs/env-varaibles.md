# Env Variables

The variables are for setting the configuration of the container. They can be set via the `docker-compose.yml`.

**\* where**
 - d = docker
 - php = for php process in the cli

| ENV                  |        Default       | where* | Description                                                                                                     |
|----------------------|:--------------------:|--------|-----------------------------------------------------------------------------------------------------------------|
| VIRTUAL_HOST         | (unset)              | d      | (jwilder) [docs php-dev](./nginx-reverse-proxy.md) [docs jwilder](https://github.com/jwilder/nginx-proxy#usage) |
| HTTPS_METHOD         | `redirect`           | d      | (jwilder) [docs jwilder](https://github.com/jwilder/nginx-proxy#uhow-ssl-support-works)                         |
| POSTFIX_RELAYHOST    | `[global-mail]:1025` | d      | (webdevops) the mail SMTP-Mail Server [docs webdevops]                                                          |
| PHP_DISMOD           | `ioncube`            | d      | (webdevops) You can specify a comma-separated list of unwanted modules as dynamic env variable [docs webdevops] |
| PHP_DISPLAY_ERRORS   | `1`                  | d      | (webdevops) set php config `display_errors` [docs webdevops]                                                    |
| PHP_MEMORY_LIMIT     | `-1`                 | d      | (webdevops) set php config `memory_limit` [docs webdevops]                                                      |
| PHP_DEBUGGER         | `none`               | d      | (webdevops) specifies which php debugger should be active [docs webdevops]                                      |
| PROFILING_ENABLED    | (unset)              | d,php  | (php-dev) enables the xhprof recording [see profiling](./profiling.md)                                          |
| XHGUI_MONGO_URI      | `global-xhgui:27017` | d,php  | (php-dev) sets the report DB [see profiling](./profiling.md) [docs xhgui collector]                             |
| XHGUI_PROFILING      | `enabled`            | d,php  | (php-dev) disables the profiling completely [docs xhgui collector]                                              |
| COMPOSE_PROJECT_NAME | (see docs)           | d      | (docker-compose) [docs php-dev](./docker-project-name.md) [docs docker]                                         |


[docs webdevops]: https://dockerfile.readthedocs.io/en/latest/content/DockerImages/dockerfiles/php-apache-dev.html
[docs docker]: https://docs.docker.com/compose/reference/envvars/#compose_project_name
[docs xhgui collector]: https://github.com/perftools/xhgui-collector#use-with-environment-variables
