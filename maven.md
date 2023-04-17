### Project Inheritance
several maven projects have similar configurtions. Making a parent project and let all maven projects inherit the parent project
````
|-- ekl-backend-parent
|    `-- pom.xml
|-- ekl-backend-ws
|    `-- pom.xml
````
````
<project>
  <modelVersion>4.0.0</modelVersion>
 
  <parent>
    <groupId>org.ekl.backend</groupId>
    <artifactId>ekl-backend-ws</artifactId>
    <version>1.0.1</version>
    <relativePath>../ekl-backend-parent/pom.xml</relativePath>
  </parent>
 
  <artifactId>ekl-backend-ws</artifactId>
</project>
````

### Project Aggregation
a group of projects that are built or processed together
````
|-- ekl-backend-parent
|    `-- pom.xml
|-- ekl-backend-ws
|    `-- pom.xml
````
````
<project>
  <modelVersion>4.0.0</modelVersion>
 
  <groupId>org.ekl.backend</groupId>
  <artifactId>ekl-backend-parent</artifactId>
  <version>1.0.1</version>
  <packaging>pom</packaging>
 
  <modules>
    <module>../ekl-backend-ws</module>
  </modules>
</project>
````
One maven project can use both project inheritance and project aggregation
