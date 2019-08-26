# Fix special user permissions

As a user with a UID other than 1000, you have permissions issues with files.

The variables are automatically changed in `start.sh` for `.env`. But ultimately have to be handed over `docker-compose.yaml`.

Required: APPLICATION_UID_OVERRIDE & APPLICATION_GID_OVERRIDE

docker-compose.yaml:

```yaml
services:
  web:
    environment:
    # Fix special user permissions
    - APPLICATION_UID_OVERRIDE=${APPLICATION_UID_OVERRIDE:-1000}
    - APPLICATION_GID_OVERRIDE=${APPLICATION_GID_OVERRIDE:-1000}
```
