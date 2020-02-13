```
name:         | seafile-cli
compiler:     | docker-compose
version:      | v4.1, 20191205
```

## Description:

This script runs a seafile-client and syncs the mounted folders in the server. Settings can be adjusted using the ".env" file. Synced libraries must have the id defined in ".env" file as well as having the folder in the mounted folder.

## Setup:

**Fast Deploy**
* `chmod +x ./init-env.sh && ./init-env.sh && nano init-env.sh`
* Add the same library ids under the volumes of `/data/$LIBRARYID`.

## Changelog

### v4.0, 20191205
* Fixed memory leak. It no more restarts seafile daemon each time.
* Fixed data mount directory to `/data`.
* Added `inint-env.sh` to initialize env variables.
