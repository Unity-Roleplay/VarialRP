# Dunko ghmattimysql

A basic adaptation of ghmattimysql for vRPold (DUNKO).

* Just Plug In
* Easy to use
* No modifications needed
* Faster than any other dbdriver
* Can be used with any other ghmattimysql version



## Tutorial RO

>Daca aveti deja aceste resurse in scripturile voastre va trebui sa le redenumiti sau sa le stergeti. ( ! Doar pentru np_mysql ! )

> Aceste doua linii vor fi puse inainte de `start vrp` in `server.cfg`.

```lua
start ghmattimysql
start np_mysql
```

> Se vor sterge din `vrp/base.lua` aceste linii:

```lua
MySQL.debug = config.debug
```

```lua
-- open MySQL connection
MySQL.createConnection("vRP", config.db.host,config.db.user,config.db.password,config.db.database)
```

> Se vor sterge din `vrp/cfg/base.lua` aceste linii:

```lua
cfg.db = {
  host = "127.0.0.1", -- database ip (default is local)
  database = "vrpfx",   -- name of database
  user = "root",    --  database username
  password = ""   -- password of your database
}
```
> Configuram in `ghmattimysql/config.json` cu detalii bazei noastre de date:

```json
{
    "user": "root",
    "password": "",
    "host": "localhost",
    "port": "3306",
    "database": "vrp"
}
```

> Daca intampinati urmatoarea eroare:

```
[ERROR] CONNECT ETIMEDOUT
```

> Da-ti start la resursele de tip `STREAM` ( masini, skinuri, mapping ) inainte de `start ghmattimysql`!

## Tutorial EN

> These to lines will be written before `start vrp` in `server.cfg`.

```lua
start ghmattimysql
start np_mysql
```

> These lines will be deleted from `vrp/base.lua`:

```lua
MySQL.debug = config.debug
```

```lua
-- open MySQL connection
MySQL.createConnection("vRP", config.db.host,config.db.user,config.db.password,config.db.database)
```

> These lines will be deleted form `vrp/cfg/base.lua`:

```lua
cfg.db = {
  host = "127.0.0.1", -- database ip (default is local)
  database = "vrpfx",   -- name of database
  user = "root",    --  database username
  password = ""   -- password of your database
}
```
> In `ghmattimysql/config.json` you will configure with your db details:

```json
{
    "user": "root",
    "password": "",
    "host": "localhost",
    "port": "3306",
    "database": "vrp"
}
```

> If you have this error:

```
[ERROR] CONNECT ETIMEDOUT
```

> Set start to `STREAM` type resources ( cars, skins, mappings ) before `start ghmattimysql`!
