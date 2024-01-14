- @Type(type="uuid-char") -- type is one of hibernate basic tpyes, may be referenced by the key from the registry, e.g. uuid-char
````
@Id
@Column(name="OBJEKTID")
@Type(type = "uuid-char")
@GeneratedValue
private UUID objektId;
    
@Type(type='uuid-char')
@Column(name="PROFILOBJEKTID")
@Type(type = "uuid-char")
private UUID profilObjektId;
````
