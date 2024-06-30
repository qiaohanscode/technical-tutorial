#### Write To File
```
# terminate with Ctrl+D or Ctrl+C (MacOS)
cat > README.md
```

#### Append To File
```
cat >> README.md
```

#### Write To File With Here Document Syntax
```
cat > README.md << EOF
bla bla bla
blu blu blu
EOF
```
`Note: EOF is a token which tells cat to terminate`

#### Append To File With Here Document Syntax
```
cat >> README.md << EOF
bli bli bli
blo blo blo
EOF
```