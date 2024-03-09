The ___envsubst___ command searches the input for pattern ___$VARIABLE___ or ___$[VARIABLE]___. Then, it replaces the 
pattern with the value of the corresponding bash variable. A pattern that does not refer to any
variables is replaced by an empty string. ___envsubst___ recognizes only exported variables.
```
envsubst [OPTION] [SHELL-FORMAT]
```

Let's prepare a simple greetings template in the file ___welcome.txt___.
```
Hello user $USER in $DESKTOP_SESSION. It's time to say $HELLO!
```
Now let's export the ___HELLO___ variable:
```
export HELLO="good morning"
envsubst < welcome.txt
Hello user joe in Lubuntu. It's time to say good morning!
```

For detailed description read [ Baeldung envsubst](https://www.baeldung.com/linux/envsubst-command).