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

#### Step 3 COnfigure PostgreSQL 17
Edit configuration file `pg_hba.conf` 
```
sudo vim /etc/postgresql/17/main/pg_hba.conf
listen_addresses = '*'
```

Restart PostgreSQL
```
sudo systemctl restart postgresql
```

Allow PostgreSQL port through the firewall
```
sudo ufw allow 5432/tcp
```

#### Step 4 Connect to PostgreSQL
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