![logo](./doc/logo.jpg)

[![NeurDB Website](https://img.shields.io/badge/Website-neurdb.com-blue)](https://neurdb.com)
[![Github](https://img.shields.io/badge/Github-100000.svg?logo=github&logoColor=white)](https://github.com/neurdb/neurdb)
![GitHub contributors](https://img.shields.io/github/contributors-anon/neurdb/neurdb)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![paper-24-1](https://img.shields.io/badge/DOI-10.1007/s11432--024--4125--9-B31B1B.svg)](http://scis.scichina.com/en/2024/200901.pdf)
[![paper-24-2](https://img.shields.io/badge/CIDR--25%20Paper-F7C15D)](https://vldb.org/cidrdb/papers/2025/p29-zhao.pdf)


NeurDB is an AI-powered autonomous data system.

![NeurDB demo](assets/demo.gif)

## Installation

### Clone the latest code

```bash
git clone https://github.com/neurdb/neurdb.git
cd neurdb
# Give Docker container write permission
chmod -R 777 .
```

### Build Dockerfile

```bash
bash build.sh
```

Wait until the following prompt shows:

```
Please use 'control + c' to exit the logging print
...
Press CTRL+C to quit
```

## Usage

### Create Shell

```bash
docker exec -it neurdb_dev bash
```

### Run Connector (in Docker Container)

```bash
$NEURDBPATH/psql/bin/psql -h 0.0.0.0
```

<!--
### Run tests

> [!NOTE]
> In the current state, the implementation of `PREDICT` syntax is not complete but scheduled. Once it is done, you can use the following syntax to run the training/inference on the specific data table, e.g.,
> ```
> PREDICT CLASS OF class FROM iris;
> ```
-->

### Start/stop the server (in Docker container)

```bash
# (Start/stop as a service)
$NEURDBPATH/psql/bin/pg_ctl -D $NEURDBPATH/psql/data start
$NEURDBPATH/psql/bin/pg_ctl -D $NEURDBPATH/psql/data stop

# (Start in frontend)
$NEURDBPATH/psql/bin/postgres -D $NEURDBPATH/psql/data -h 0.0.0.0
```

## Development

### Code Formatting

All tools are managed by pre-commit.

After installing pre-commit, run the following command:

```bash
pre-commit run -a
```

### Increase logging level

Update `$NEURDBPATH/psql/data/postgresql.conf` by changing the corresponding settings:

```ini
log_min_messages = DEBUG1
log_min_error_statement = DEBUG1
```

### Miscellaneous

If the server complains about the permission of the data directory, run the following command to fix it:

```bash
chmod 750 $NEURDBPATH/psql/data
```

Sometimes, the OS language settings could also affect the server starting. In such case, run the following commands:

```bash
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export DYLD_LIBRARY_PATH=$NEURDBPATH/psql/lib:$DYLD_LIBRARY_PATH
```

## Troubleshooting

### Building

#### `./configure: line ...: config.log: Permission denied`

Check the permissions of (1) executing for `dbengine/configure` (2) writing for other directories.

#### `pg_ctl: directory "/code/neurdb-dev/psql/data" is not a database cluster directory`

This happens when you have directory `psql/data` without initializing the database, e.g., if the init script exits abnormally before. By default, to avoid data loss, the init script will not touch `psql/data` if it already exists. To solve this, remove `psql/data` manually.


## Citation

Our vision paper can be found in:

```
@article{neurdb-scis-24,
  author = {Beng Chin Ooi and
            Shaofeng Cai and
            Gang Chen and
            Yanyan Shen and
            Kian-Lee Tan and
            Yuncheng Wu and
            Xiaokui Xiao and
            Naili Xing and
            Cong Yue and
            Lingze Zeng and
            Meihui Zhang and
            Zhanhao Zhao},
  title  =  {NeurDB: An AI-powered Autonomous Data System},
  journal=  {SCIENCE CHINA Information Sciences},
  year   =  {2024},
  pages  =  {-},
  url    =  {https://www.sciengine.com/SCIS/doi/10.1007/s11432-024-4125-9},
  doi    =  {https://doi.org/10.1007/s11432-024-4125-9}
}
```
