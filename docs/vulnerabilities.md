# Vulnerabilities

Investigate vulnerabilities.

```bash
# Run audit in docker container
~/audit.sh

# Run audit in project folder on host system
docker-compose exec -u application web bash -c "~/audit.sh"

# Search for Yarn and execute audit on host system
find . -maxdepth 2 -iname yarn.lock -exec sh -c '(echo "\n$(dirname {})" && cd $(dirname {}) && docker-compose up -d && docker-compose exec -u application web bash -c "~/audit.sh" && cd -)' \;
```

Update interactively. In case of doubt delete `node_modules` and reinstall with `yarn install`.

```bash
# Interactive upgrade
yarn upgrade-interactive --latest

# Show outdated packages
yarn outdated
```
