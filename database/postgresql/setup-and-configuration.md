### Install Postgresql 17 On Ubuntu 22.04

A detailed description for [Install Postgresql 17 On Ubuntu](https://dev.to/johndotowl/postgresql-17-installation-on-ubuntu-2404-5bfi).

#### Step 1 Add PostgreSQL Repository
Add PostgreSQL 17 repository
```
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
> /etc/apt/sources.list.d/pgdg.list'
```

Import repository signing key:

```
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc \
| sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
```

Update package list:
```
sudo apt update
```

#### Step 2 Install PostgreSQL 17
Install PostgreSQL 17
```
sudo apt install postgresql-17
```

Start and enable PstgreSQL service:
```
sudo systectl restart postgresql
sudo systemctl enable postgresql
```

Check the version
```
psql --version
```

#### Step 3 Cnfigure PostgreSQL 17 For Remote Access
Edit `ostgresql.conf` to allow remote connections by changing `listen_addresses to *:
```
sudo vim /etc/postgresql/17/main/postgresql.conf
listen_addresses = '*'
```

Configure PostgreSQL to use md5 password authentication by editing pg_hba.conf.
This is important if you wish to connect remotely e.g. via PGADMIN
```
sudo sed -i '/^host/s/ident/md5/' /etc/postgresql/17/main/pg_hba.conf
sudo sed -i '/^local/s/peer/trust/' /etc/postgresql/17/main/pg_hba.conf
echo "host all all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/17/main/pg_hba.conf
```

Restart PostgreSQL
```
sudo systemctl restart postgresql
```

Allow PostgreSQL port through the firewall
```
sudo ufw allow 5432/tcp
```

#### Step 4 Create USER For Backend Application
Connect as the postgres user:
```
sudo -u postgres psql
```

Set password for postgres user:
```
ALTER USER postgres PASSWORD '$PASSWORD'
```

Create the database ekl_dev
```
CREATE DATABASE ekl_dev;
```

Create the user ekl_be_dev (role). The `LOGIN` keyword allows the role to
log in to the database.
```
CREATE ROLE ekl_be_dev WITH LOGIN PASSWORD '$PASSWORD';
```

Grant privileges to the user
```
GRANT CONNECT ON DATABASE ekl_dev TO ekl_be_dev;
```

Make sure the user can create tables and schemas
```
GRANT CREATE ON DATABASE ekl_dev TO ekl_be_dev;
```

Reload or restart PostgreSQL
```
sudo systemctl reload postgresql
```