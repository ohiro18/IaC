# embulk-digdag
Use Embulk and Digdag to load CSV to Hologres. 

1. JAVA 8 (set java path)
2. Install postgresql
3. Install pgAdmin (keep the db user as "postgres" and password as "admin")
4. Create database "td_coding_challenge"

*Note: Run all commands as superuser

5. Install Embulk (use the following command)

```
$ curl --create-dirs -o ~/.embulk/bin/embulk -L "https://dl.embulk.org/embulk-latest.jar"
$ chmod +x ~/.embulk/bin/embulk
$ echo 'export PATH="$HOME/.embulk/bin:$PATH"' >> ~/.bashrc
$ source ~/.bashrc
```

6. Install JDBC input plugins for Embulk-postgresql
```
$ embulk gem install embulk-input-postgresql
```
7. Install JDBC output plugins for Embulk-postgresql
```
$ embulk gem install embulk-output-postgresql
```

8. Install Digdag (use the following command)
```
$ curl -o ~/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest"
$ chmod +x ~/bin/digdag
$ echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
```

*Note: Embulk and Digdag command can be tested using their respective examples 

     for embulk: https://github.com/embulk/embulk#linux--mac--bsd
		 
     for digdag: http://docs.digdag.io/getting_started.html#downloading-the-latest-version

*Note: Keep all the csv, embulk and digdag files in one folder or else provide the path.

Run the following commands to get the results:
```
$ sudo -s (to get super user previliges)
$ digdag secrets --local --set pg.password=admin (set the secret key)
$ digdag run tdcc.dig --rerun -O log/task (run the digdag command to get results and generte event logs)
```
